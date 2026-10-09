```sql
-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- ANALYTICS VIEWS FOR POWER BI
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA ANALYTICS;


-- ============================================================
-- 1. OVERALL SALES SUMMARY
-- ============================================================

CREATE OR REPLACE VIEW VW_SALES_SUMMARY AS
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units,
    SUM(gross_amount) AS gross_sales,
    SUM(discount_amount) AS total_discount,
    SUM(net_amount) AS net_sales,
    AVG(net_amount) AS average_order_value
FROM FACT_ORDERS;


-- ============================================================
-- 2. PRODUCT PERFORMANCE
-- ============================================================

CREATE OR REPLACE VIEW VW_PRODUCT_PERFORMANCE AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.quantity) AS units_sold,
    SUM(f.gross_amount) AS gross_sales,
    SUM(f.discount_amount) AS total_discount,
    SUM(f.net_amount) AS net_sales
FROM DIM_PRODUCT p
LEFT JOIN FACT_ORDERS f
    ON p.product_id = f.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory;


-- ============================================================
-- 3. CUSTOMER PERFORMANCE
-- ============================================================

CREATE OR REPLACE VIEW VW_CUSTOMER_PERFORMANCE AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.country,
    c.customer_segment,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.quantity) AS total_units,
    SUM(f.net_amount) AS total_spent
FROM DIM_CUSTOMER c
LEFT JOIN FACT_ORDERS f
    ON c.customer_id = f.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city,
    c.country,
    c.customer_segment;


-- ============================================================
-- 4. MONTHLY SALES
-- ============================================================

CREATE OR REPLACE VIEW VW_MONTHLY_SALES AS
SELECT
    DATE_TRUNC('MONTH', order_date)::DATE AS sales_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units,
    SUM(gross_amount) AS gross_sales,
    SUM(discount_amount) AS total_discount,
    SUM(net_amount) AS net_sales
FROM FACT_ORDERS
GROUP BY DATE_TRUNC('MONTH', order_date)::DATE;
```