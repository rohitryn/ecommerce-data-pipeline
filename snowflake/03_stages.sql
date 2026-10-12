-- ============================================================
8 -- ============================================================
-- E-COMMERCE DATA PIPELINE
-- AWS S3 EXTERNAL STAGES
-- ============================================================

USE DATABASE ECOMMERCE_DW;

USE SCHEMA RAW;

-- ============================================================
-- NOTE:
-- The storage integration is intentionally referenced here
-- instead of storing AWS credentials in the repository.
--
-- Storage Integration:
--     S3_INT2
--
-- S3 Bucket:
--     snow-demo2-rohit
--
-- Project Prefix:
--     Ecommerce_project/
-- ============================================================

-- ============================================================
-- CUSTOMERS - INITIAL DATA
-- ============================================================

CREATE STAGE IF NOT EXISTS PROJECT_CUSTOMERS_STAGE URL = 's3://snow-demo2-rohit/Ecommerce_project/customers/initial/' STORAGE_INTEGRATION = S3_INT2 FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- CUSTOMERS - INCREMENTAL DATA
-- ============================================================

CREATE STAGE IF NOT EXISTS PROJECT_CUSTOMERS_INCREMENTAL_STAGE URL = 's3://snow-demo2-rohit/Ecommerce_project/customers/incremental/' STORAGE_INTEGRATION = S3_INT2 FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- PRODUCTS - INITIAL DATA
-- ============================================================

CREATE STAGE IF NOT EXISTS PROJECT_PRODUCTS_STAGE URL = 's3://snow-demo2-rohit/Ecommerce_project/products/initial/' STORAGE_INTEGRATION = S3_INT2 FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- PRODUCTS - INCREMENTAL DATA
-- ============================================================

CREATE STAGE IF NOT EXISTS PROJECT_PRODUCTS_INCREMENTAL_STAGE URL = 's3://snow-demo2-rohit/Ecommerce_project/products/incremental/' STORAGE_INTEGRATION = S3_INT2 FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- ORDERS - INITIAL DATA
-- ============================================================

CREATE STAGE IF NOT EXISTS PROJECT_ORDERS_STAGE URL = 's3://snow-demo2-rohit/Ecommerce_project/orders/initial/' STORAGE_INTEGRATION = S3_INT2 FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- ORDERS - INCREMENTAL DATA
-- ============================================================

CREATE STAGE IF NOT EXISTS PROJECT_ORDERS_INCREMENTAL_STAGE URL = 's3://snow-demo2-rohit/Ecommerce_project/orders/incremental/' STORAGE_INTEGRATION = S3_INT2 FILE_FORMAT = CSV_FORMAT;