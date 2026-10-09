-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- FILE FORMAT CONFIGURATION
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA RAW;

-- CSV format used for files arriving from AWS S3
CREATE FILE FORMAT IF NOT EXISTS CSV_FORMAT
    TYPE = CSV
    FIELD_DELIMITER = ','
    RECORD_DELIMITER = '\n'
    SKIP_HEADER = 1;

-- ============================================================
-- EXPECTED SOURCE FILE FORMAT
--
-- Customers:
-- customer_id, customer_name, email, city, country,
-- signup_date, customer_segment
--
-- Products:
-- product_id, product_name, category, subcategory, price
--
-- Orders:
-- order_id, customer_id, product_id, order_date, quantity,
-- discount, payment_method, order_status
-- ============================================================