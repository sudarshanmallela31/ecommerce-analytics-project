/*
Project: E-Commerce Sales & Customer Analytics
Author: Sudarshan Mallela

Description:
Advanced Business Analysis
*/

USE ecommerce_project;

-- Discount Impact
SELECT
    ROUND(discount * 100,0) AS discount_percent,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM cleaned_orders
GROUP BY ROUND(discount * 100,0)
ORDER BY ROUND(discount * 100,0);

-- Shipping Analysis
SELECT
    ship_mode,
    ROUND(AVG(shipping_days),2) AS avg_shipping_days
FROM cleaned_orders
GROUP BY ship_mode
ORDER BY avg_shipping_days;

-- Profit Margin By Category
SELECT
    category,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_pct
FROM cleaned_orders
GROUP BY category
ORDER BY ROUND((SUM(profit)/SUM(sales))*100,2) DESC;
-- Top States
SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM cleaned_orders
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;

-- Customer Segmentation
SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_spent,
    CASE
        WHEN SUM(sales) >= 10000 THEN 'High Value'
        WHEN SUM(sales) >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM cleaned_orders
GROUP BY customer_name
ORDER BY total_spent DESC;