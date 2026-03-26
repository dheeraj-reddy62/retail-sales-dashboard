-- =========================================
-- RETAIL SALES DATA PROJECT (STAR SCHEMA)
-- =========================================

-- ==============================
-- 1. DIMENSION TABLES
-- ==============================

CREATE TABLE dim_customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
region VARCHAR(50)
);

CREATE TABLE dim_products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category_name VARCHAR(50)
);

-- ==============================
-- 2. FACT TABLE
-- ==============================

CREATE TABLE fact_orders (
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
order_date DATE,
quantity INT,
total_sales DECIMAL(10,2),
total_profit DECIMAL(10,2),

```
FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
FOREIGN KEY (product_id) REFERENCES dim_products(product_id)
```

);

-- ==============================
-- 3. SAMPLE ANALYSIS QUERIES
-- ==============================

-- Total Sales by Category
SELECT
p.category_name,
SUM(f.total_sales) AS total_sales
FROM fact_orders f
JOIN dim_products p ON f.product_id = p.product_id
GROUP BY p.category_name
ORDER BY total_sales DESC;

-- Total Profit by Category
SELECT
p.category_name,
SUM(f.total_profit) AS total_profit
FROM fact_orders f
JOIN dim_products p ON f.product_id = p.product_id
GROUP BY p.category_name
ORDER BY total_profit DESC;

-- Profit Margin by Category
SELECT
p.category_name,
ROUND(SUM(f.total_profit) / SUM(f.total_sales) * 100, 2) AS profit_margin
FROM fact_orders f
JOIN dim_products p ON f.product_id = p.product_id
GROUP BY p.category_name
ORDER BY profit_margin DESC;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM fact_orders;

-- Top 5 Categories by Sales
SELECT
p.category_name,
SUM(f.total_sales) AS total_sales
FROM fact_orders f
JOIN dim_products p ON f.product_id = p.product_id
GROUP BY p.category_name
ORDER BY total_sales DESC
LIMIT 5;
