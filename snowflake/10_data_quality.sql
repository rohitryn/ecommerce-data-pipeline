```sql
-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- DATA QUALITY AND RECONCILIATION CHECKS
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA ANALYTICS;


-- ============================================================
-- 1. FINAL ROW COUNTS
-- Expected at the time this project was completed:
-- Customers = 515, Products = 115, Orders = 5,125
-- ============================================================

SELECT 'DIM_CUSTOMER' AS table_name, COUNT(*) AS row_count
FROM DIM_CUSTOMER

UNION ALL

SELECT 'DIM_PRODUCT', COUNT(*)
FROM DIM_PRODUCT

UNION ALL

SELECT 'FACT_ORDERS', COUNT(*)
FROM FACT_ORDERS;


-- ============================================================
-- 2. DUPLICATE CUSTOMER IDS
-- Expected: zero rows
-- ============================================================

SELECT customer_id, COUNT(*) AS duplicate_count
FROM DIM_CUSTOMER
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. DUPLICATE PRODUCT IDS
-- Expected: zero rows
-- ============================================================

SELECT product_id, COUNT(*) AS duplicate_count
FROM DIM_PRODUCT
GROUP BY product_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 4. DUPLICATE ORDER IDS
-- Expected: zero rows
-- ============================================================

SELECT order_id, COUNT(*) AS duplicate_count
FROM FACT_ORDERS
GROUP BY order_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 5. ORPHAN ORDERS
-- Orders must reference valid customer and product records.
-- Expected: orphan_orders = 0
-- ============================================================

SELECT COUNT(*) AS orphan_orders
FROM FACT_ORDERS f
LEFT JOIN DIM_CUSTOMER c
    ON f.customer_id = c.customer_id
LEFT JOIN DIM_PRODUCT p
    ON f.product_id = p.product_id
WHERE c.customer_id IS NULL
   OR p.product_id IS NULL;


-- ============================================================
-- 6. INVALID QUANTITIES
-- Expected: zero rows
-- ============================================================

SELECT *
FROM FACT_ORDERS
WHERE quantity IS NULL
   OR quantity <= 0;


-- ============================================================
-- 7. INVALID DISCOUNTS
-- Assumes discounts are fractions between 0 and 1.
-- Expected: zero rows
-- ============================================================

SELECT *
FROM FACT_ORDERS
WHERE discount IS NOT NULL
  AND (discount < 0 OR discount > 1);


-- ============================================================
-- 8. AMOUNT CALCULATION CHECK
-- Check that net amount matches gross less discount.
-- Expected: zero rows, allowing small rounding differences.
-- ============================================================

SELECT *
FROM FACT_ORDERS
WHERE ABS(
    net_amount - (gross_amount - discount_amount)
) > 0.02;


-- ============================================================
-- 9. MISSING KEY FIELDS
-- ============================================================

SELECT
    SUM(IFF(order_id IS NULL, 1, 0)) AS missing_order_ids,
    SUM(IFF(customer_id IS NULL, 1, 0)) AS missing_customer_ids,
    SUM(IFF(product_id IS NULL, 1, 0)) AS missing_product_ids,
    SUM(IFF(order_date IS NULL, 1, 0)) AS missing_order_dates
FROM FACT_ORDERS;
```