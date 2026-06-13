/*
Project: E-Commerce Sales & Customer Analytics
Author: Sudarshan Mallela

Description:
Data Understanding & Cleaning
*/
RENAME TABLE `sample - superstore`
TO orders;
USE ecommerce_project;
-- Check Structure
DESCRIBE orders;
-- Total Records
SELECT COUNT(*) AS total_rows
FROM orders;
-- Null Checks
SELECT
    SUM(CASE WHEN `Sales` IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN `Profit` IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS null_order_id
FROM orders;
-- Duplicate Check
SELECT
    `Order ID`,
    `Product ID`,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY `Order ID`, `Product ID`
HAVING COUNT(*) > 1;
-- Date Validation
SELECT
    `Order Date`,
    `Ship Date`
FROM orders
LIMIT 10;