/*
Project: E-Commerce Sales & Customer Analytics
Author: Sudarshan Mallela

Description:
Business KPI Analysis
*/

USE ecommerce_project;

-- Overall KPIs

SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(AVG(sales),2) AS avg_order_value
FROM cleaned_orders;

-- Category Analysis

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM cleaned_orders
GROUP BY category
ORDER BY total_sales DESC;
-- Top Profitable Products
SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM cleaned_orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;
-- Loss Making Products
SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM cleaned_orders
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 10;
-- Top Customers
SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_spent,
    COUNT(DISTINCT order_id) AS total_orders
FROM cleaned_orders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;
-- Region Analysis
SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM cleaned_orders
GROUP BY region
ORDER BY total_sales DESC;
-- Monthly Sales Trend
SELECT
    order_month,
    ROUND(SUM(sales),2) AS monthly_sales
FROM cleaned_orders
GROUP BY order_month
ORDER BY monthly_sales DESC;