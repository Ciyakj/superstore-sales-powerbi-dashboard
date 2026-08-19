# Superstore Sales & Profitability Dashboard

An end-to-end data analytics project using **SQL and Power BI** to analyze sales performance, profitability, product-level performance, regional trends, and discounting patterns using the Superstore dataset.

## Business Question

**Where is the business profitable, where is it losing money, and what factors may be contributing to weak profitability?**

## Project Overview

This project analyzes Superstore sales data from **2014–2017** across the United States.

The analysis combines:

* **SQL** for data exploration and business analysis
* **Power BI** for interactive visualization and dashboard development
* **DAX** for KPI and profitability calculations

The goal is to move from raw transactional data to actionable business insights.

---

## Dataset

**Dataset:** Superstore Sales Dataset
**Records:** 9,994 order line items
**Period:** 2014–2017
**Geography:** United States

The dataset contains information about orders, customers, products, sales, discounts, profit, regions, categories, and shipping.

---

## Tools & Technologies

* **Power BI**
* **DAX**
* **SQL**
* **SQLite**
* Data Visualization
* Business Analysis

---

## SQL Analysis

The SQL analysis includes eight business-focused queries covering:

1. Monthly sales and profit trends
2. Year-over-year growth using the `LAG()` window function
3. Top 10 products by sales
4. Sales and profit margin by region and category
5. Top 5 customers by sales within each region using `RANK()`
6. Sub-categories with negative or low profit margins
7. Quarter-over-quarter sales by region using `LAG()`
8. Shipping delay analysis by ship mode

These queries were used to identify profitability issues, regional patterns, product performance, and operational trends.

---

## Power BI Dashboard

The Power BI report contains three analytical pages.

### 1. Executive Overview

Provides a high-level view of overall business performance through:

* Total Sales
* Total Profit
* Profit Margin %
* Total Orders
* Profit by Sub-Category
* Region filter
* Category filter

This page provides a quick overview of the company's sales and profitability position.

### 2. Profitability Analysis

Analyzes profitability across **categories and regions**, helping identify areas where sales do not translate into healthy margins.

The analysis highlights differences in profitability across product and regional segments.

### 3. Sales Trends

Visualizes **monthly sales trends from 2014–2017** to identify changes and patterns in sales performance over time.

---

## Key Insights

### 1. Tables is the weakest-performing sub-category

Tables generated a **-8.6% profit margin**, representing a net loss of approximately **$17,725** in the dataset.

The sub-category also had relatively high average discounting of approximately **26%**, suggesting that discounting may be contributing to its weak profitability.

### 2. Other weak-performing sub-categories

**Bookcases and Supplies** also showed weak or negative profitability, making them candidates for further pricing and discount analysis.

### 3. Stronger-performing sub-categories

**Copiers, Phones, and Accessories** were among the stronger-performing sub-categories, combining positive profitability with comparatively moderate discounting.

### 4. Regional differences exist

Profitability varies across regions and categories. In particular, **Central-region Furniture** showed a negative profit margin of approximately **-1.8%**, suggesting that profitability issues may be concentrated in specific regional-category combinations.

### 5. Discounting deserves further investigation

The analysis indicates a relationship between higher discounting and weaker profit margins in several product segments. However, the dataset alone does not establish causation.

---

## Business Recommendations

Based on the analysis:

* Review discount levels for **Tables, Bookcases, and Supplies**.
* Investigate whether lower discounts can improve margins without significantly reducing sales volume.
* Conduct a more detailed pricing review for **Central-region Furniture**.
* Consider controlled pricing or discount experiments before implementing company-wide discount policies.
* Continue monitoring profitability at the **subcategory and regional-category level**, rather than relying only on overall sales.

---

## Dashboard Preview

### Executive Overview

![Executive Overview](Screenshots/executive-overview.png)

### Profitability Analysis

![Profitability Analysis](Screenshots/profitability-analysis.png)

### Sales Trends

![Sales Trends](Screenshots/sales-trends.png)

---

## Repository Structure

```text
superstore-sales-powerbi-dashboard/
│
├── README.md
│
├── PowerBI/
│   └── Superstore_Sales_Dashboard.pbix
│
├── SQL/
│   └── analysis_queries.sql
│
├── Data/
│   ├── superstore.csv
│   └── superstore_real.db
│
└── Screenshots/
    ├── executive-overview.png
    ├── profitability-analysis.png
    └── sales-trends.png
```

---

## How to Explore the Project

### SQL Analysis

The SQL queries can be executed using SQLite or opened in a SQLite-compatible database tool.

```bash
sqlite3 Data/superstore_real.db < SQL/analysis_queries.sql
```

Alternatively, open `Data/superstore_real.db` using a SQLite-compatible tool such as DB Browser for SQLite.

### Power BI Dashboard

Open `PowerBI/Superstore_Sales_Dashboard.pbix` using **Power BI Desktop** to explore the interactive dashboard, filters, KPIs, and visualizations.

---

## Skills Demonstrated

**Data Analysis**

Exploratory Data Analysis, KPI Analysis, Profitability Analysis, Trend Analysis, Business Insights

**SQL**

CTEs, Aggregations, Joins, Window Functions, `LAG()`, `RANK()`, Date Calculations

**Power BI**

Dashboard Development, Data Visualization, Interactive Filters, KPI Cards, Matrix Analysis, Trend Analysis

**DAX**

Calculated Measures, Profit Margin, Order Metrics

---

## Conclusion

This project demonstrates an end-to-end analytics workflow:

**Raw Data → SQL Analysis → Business Insights → Power BI Dashboard → Recommendations**

The analysis focuses not only on sales performance but also on understanding **where profitability is being lost and where the business may need to review pricing and discounting strategies**.
