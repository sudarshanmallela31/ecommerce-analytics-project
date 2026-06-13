#SELECT * FROM `ecommerce_project;`.orders
#RENAME TABLE ecommerce_project TO orders;
Describe orders;
Select count(*) as total_rows
from orders;
SELECT
    SUM(CASE WHEN `Sales` IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN `Profit` IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN `Customer ID` IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN `Order ID` IS NULL THEN 1 ELSE 0 END) AS null_order_id
FROM orders;
SELECT
    `Order ID`,
    `Product ID`,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY `Order ID`, `Product ID`
HAVING COUNT(*) > 1;
SELECT
    `Order Date`,
    `Ship Date`
FROM orders
LIMIT 10;
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
SELECT * FROM cleaned_orders
LIMIT 10;
DESCRIBE cleaned_orders;
ALTER TABLE cleaned_orders
ADD COLUMN order_year INT,
ADD COLUMN order_month VARCHAR(20),
ADD COLUMN shipping_days INT,
ADD COLUMN profit_margin DECIMAL(10,2);
SET SQL_SAFE_UPDATES = 0;
UPDATE cleaned_orders
SET
    order_year = YEAR(order_date),
    order_month = MONTHNAME(order_date),
    shipping_days = DATEDIFF(ship_date, order_date),
    profit_margin = ROUND((profit / sales) * 100, 2);
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
UPDATE orders SET sales = 0;
SET SQL_SAFE_UPDATES = 0;
-- update query
SET SQL_SAFE_UPDATES = 1;
#Overall business KPIs
SELECT
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    count(distinct order_id) as total_orders,
    count(distinct customer_id) as total_costomers,
    round(avg(sales), 2)as avg_order_value
from cleaned_orders;
#Top Revenue generating categoties
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_orders
GROUP BY category
ORDER BY total_sales DESC;
#MOst Profitable Products
SELECT
    product_name,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;
#Low Profit/Loss products
SELECT
    product_name,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_orders
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 100;
#Top customers
SELECT
    customer_name,
    ROUND(SUM(sales), 2) AS total_spent,
    COUNT(DISTINCT order_id) AS total_orders
FROM cleaned_orders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;
#Region performance
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM cleaned_orders
GROUP BY region
ORDER BY total_sales DESC;
#Monthly Sales Trend
select
    order_month,
    round(sum(sales), 2) as monthly_sales
From cleaned_orders
group by order_month
order by monthly_sales desc
#Discount impact
SELECT
    ROUND(discount * 100,0) AS discount_percent,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM cleaned_orders
GROUP BY discount_percent
ORDER BY discount_percent;
#Shipping Analysis
select
    ship_mode,
    round(avg(shipping_days),2) as avg_shipping_days
from cleaned_orders
group by ship_mode
order by avg_shipping_days;
#Profit margin by category
SELECT
    category,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_pct
FROM cleaned_orders
GROUP BY category
ORDER BY profit_margin_pct DESC;
#Top states
SELECT
    state,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM cleaned_orders
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;
#customer Segmentatin
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