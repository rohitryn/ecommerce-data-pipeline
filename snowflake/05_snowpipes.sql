-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- SNOWPIPES
-- ============================================================

USE DATABASE ECOMMERCE_DW;

USE SCHEMA RAW;

-- ============================================================
-- CUSTOMERS SNOWPIPE
-- ============================================================

CREATE
OR
REPLACE
    PIPE PROJECT_CUSTOMERS_PIPE AUTO_INGEST = TRUE AS COPY INTO RAW_CUSTOMERS
FROM
    @PROJECT_CUSTOMERS_INCREMENTAL_STAGE FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- PRODUCTS SNOWPIPE
-- ============================================================

CREATE
OR
REPLACE
    PIPE PROJECT_ORDERS_PIPE AUTO_INGEST = TRUE AS COPY INTO RAW_ORDERS
FROM
    @PROJECT_ORDERS_INCREMENTAL_STAGE FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- ORDERS SNOWPIPE
-- ============================================================

CREATE
OR
REPLACE
    PIPE PROJECT_PRODUCTS_PIPE AUTO_INGEST = TRUE AS COPY INTO RAW_PRODUCTS
FROM
    @PROJECT_PRODUCTS_INCREMENTAL_STAGE FILE_FORMAT = CSV_FORMAT;

-- ============================================================
-- SNOWPIPE ARCHITECTURE
--
-- New CSV file uploaded to S3
--          ↓
-- S3 Event Notification
--          ↓
-- Snowpipe AUTO_INGEST
--          ↓
-- RAW table
--
-- Snowpipe performs file-level ingestion. Business-level
-- duplicate validation is handled later in the pipeline.
-- ============================================================