-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- SNOWPIPES
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA RAW;


-- ============================================================
-- CUSTOMERS SNOWPIPE
-- ============================================================

CREATE PIPE IF NOT EXISTS PROJECT_CUSTOMERS_PIPE
    AUTO_INGEST = TRUE
    AS
    COPY INTO RAW_CUSTOMERS
    FROM @PROJECT_CUSTOMERS_INCREMENTAL_STAGE
    FILE_FORMAT = (FORMAT_NAME = 'ECOMMERCE_DW.RAW.CSV_FORMAT')
    ON_ERROR = 'CONTINUE';


-- ============================================================
-- PRODUCTS SNOWPIPE
-- ============================================================

CREATE PIPE IF NOT EXISTS PROJECT_PRODUCTS_PIPE
    AUTO_INGEST = TRUE
    AS
    COPY INTO RAW_PRODUCTS
    FROM @PROJECT_PRODUCTS_INCREMENTAL_STAGE
    FILE_FORMAT = (FORMAT_NAME = 'ECOMMERCE_DW.RAW.CSV_FORMAT')
    ON_ERROR = 'CONTINUE';


-- ============================================================
-- ORDERS SNOWPIPE
-- ============================================================

CREATE PIPE IF NOT EXISTS PROJECT_ORDERS_PIPE
    AUTO_INGEST = TRUE
    AS
    COPY INTO RAW_ORDERS
    FROM @PROJECT_ORDERS_INCREMENTAL_STAGE
    FILE_FORMAT = (FORMAT_NAME = 'ECOMMERCE_DW.RAW.CSV_FORMAT')
    ON_ERROR = 'CONTINUE';


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