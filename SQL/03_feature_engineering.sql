/*
Project: E-Commerce Sales & Customer Analytics
Author: Sudarshan Mallela

Description:
Create analytics-ready table
*/

USE ecommerce_project;

-- Create Clean Table
CREATE TABLE cleaned_orders AS
SELECT
    `Row ID` AS row_id,
    `Order ID` AS order_id,
    STR_TO_DATE(`Order Date`, '%m/%d/%Y') AS order_date,
    STR_TO_DATE(`Ship Date`, '%m/%d/%Y') AS ship_date,
    `Ship Mode` AS ship_mode,
    `Customer ID` AS customer_id,
    `Customer Name` AS customer_name,
    Segment AS segment,
    Country AS country,
    City AS city,
    State AS state,
    Region AS region,
    `Product ID` AS product_id,
    Category AS category,
    `Sub-Category` AS sub_category,
    `Product Name` AS product_name,
    Sales AS sales,
    Quantity AS quantity,
    Discount AS discount,
    Profit AS profit
FROM orders;

-- Add New Columns
ALTER TABLE cleaned_orders
ADD COLUMN order_year INT,
ADD COLUMN order_month VARCHAR(20),
ADD COLUMN shipping_days INT,
ADD COLUMN profit_margin DECIMAL(10,2);
-- Disable Safe Mode
SET SQL_SAFE_UPDATES = 0;
-- Populate New Columns
UPDATE cleaned_orders
SET
    order_year = YEAR(order_date),
    order_month = MONTHNAME(order_date),
    shipping_days = DATEDIFF(ship_date, order_date),
    profit_margin = ROUND((profit / sales) * 100, 2);
-- Enable Safe Mode
SET SQL_SAFE_UPDATES = 1;
-- Verification
SELECT
    order_id,
    order_date,
    ship_date,
    order_year,
    order_month,
    shipping_days,
    profit_margin
FROM cleaned_orders
LIMIT 10;