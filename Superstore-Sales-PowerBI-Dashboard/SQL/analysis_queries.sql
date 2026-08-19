-- =========================================================
-- Superstore Sales Analysis — REAL Kaggle dataset
-- Table: orders (one row per order line item)
-- Covers: joins (self/derived), CTEs, window functions
-- =========================================================

-- 1. MONTHLY REVENUE TREND
SELECT
    strftime('%Y-%m', "Order Date") AS order_month,
    ROUND(SUM(Sales), 2)  AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS order_count
FROM orders
GROUP BY order_month
ORDER BY order_month;


-- 2. YEAR-OVER-YEAR REVENUE GROWTH BY MONTH (CTE + window function)
WITH monthly AS (
    SELECT
        strftime('%Y', "Order Date") AS yr,
        strftime('%m', "Order Date") AS mo,
        SUM(Sales) AS revenue
    FROM orders
    GROUP BY yr, mo
)
SELECT
    yr, mo, ROUND(revenue,2) AS revenue,
    ROUND(
        (revenue - LAG(revenue, 12) OVER (ORDER BY yr, mo))
        / LAG(revenue, 12) OVER (ORDER BY yr, mo) * 100, 1
    ) AS pct_change_vs_same_month_last_year
FROM monthly
ORDER BY yr, mo;


-- 3. TOP 10 PRODUCTS BY REVENUE
SELECT
    "Product Name", Category,
    ROUND(SUM(Sales), 2) AS total_revenue,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Profit), 2) AS total_profit
FROM orders
GROUP BY "Product Name"
ORDER BY total_revenue DESC
LIMIT 10;


-- 4. REVENUE & PROFIT MARGIN BY REGION x CATEGORY
SELECT
    Region, Category,
    ROUND(SUM(Sales), 2)  AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 1) AS profit_margin_pct
FROM orders
GROUP BY Region, Category
ORDER BY Region, total_revenue DESC;


-- 5. TOP 5 CUSTOMERS BY SPEND, PER REGION (CTE + window function: RANK)
WITH customer_spend AS (
    SELECT
        Region, "Customer Name",
        SUM(Sales) AS total_spend
    FROM orders
    GROUP BY Region, "Customer Name"
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY Region ORDER BY total_spend DESC) AS spend_rank
    FROM customer_spend
)
SELECT Region, "Customer Name", ROUND(total_spend,2) AS total_spend, spend_rank
FROM ranked
WHERE spend_rank <= 5
ORDER BY Region, spend_rank;


-- 6. SUB-CATEGORIES LOSING MONEY (negative profit margin)
-- Business question: which product sub-categories should we stop discounting so heavily?
SELECT
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Discount) * 100, 1) AS avg_discount_pct,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 1) AS profit_margin_pct
FROM orders
GROUP BY "Sub-Category"
HAVING profit_margin_pct < 5
ORDER BY profit_margin_pct;


-- 7. QUARTER-OVER-QUARTER REGION PERFORMANCE (CTE + window function)
WITH quarterly AS (
    SELECT
        Region,
        strftime('%Y', "Order Date") || '-Q' ||
            ((CAST(strftime('%m', "Order Date") AS INTEGER) - 1) / 3 + 1) AS year_quarter,
        SUM(Sales) AS revenue
    FROM orders
    GROUP BY Region, year_quarter
)
SELECT
    Region, year_quarter, ROUND(revenue,2) AS revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (PARTITION BY Region ORDER BY year_quarter))
        / LAG(revenue) OVER (PARTITION BY Region ORDER BY year_quarter) * 100, 1
    ) AS pct_change_vs_prev_quarter
FROM quarterly
ORDER BY Region, year_quarter;


-- 8. SHIPPING DELAY ANALYSIS (derived join via date math)
-- Business question: does shipping delay vary meaningfully by Ship Mode?
SELECT
    "Ship Mode",
    ROUND(AVG(julianday("Ship Date") - julianday("Order Date")), 1) AS avg_ship_days,
    COUNT(*) AS order_lines
FROM orders
GROUP BY "Ship Mode"
ORDER BY avg_ship_days DESC;
