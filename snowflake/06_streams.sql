-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- SNOWFLAKE STREAMS
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA RAW;


-- ============================================================
-- CUSTOMER STREAM
-- ============================================================

CREATE STREAM IF NOT EXISTS CUSTOMER_STREAM
    ON TABLE RAW_CUSTOMERS;


-- ============================================================
-- PRODUCT STREAM
-- ============================================================

CREATE STREAM IF NOT EXISTS PRODUCT_STREAM
    ON TABLE RAW_PRODUCTS;


-- ============================================================
-- ORDER STREAM
-- ============================================================

CREATE STREAM IF NOT EXISTS ORDER_STREAM
    ON TABLE RAW_ORDERS;


-- ============================================================
-- STREAM PURPOSE
--
-- Streams capture changes made to the RAW tables after the
-- stream was created.
--
-- CUSTOMER_STREAM → new/changed customer records
-- PRODUCT_STREAM  → new/changed product records
-- ORDER_STREAM    → new/changed order records
--
-- Tasks consume these streams and load the ANALYTICS layer.
--
-- Conceptually:
--
-- S3
--  ↓
-- Snowpipe
--  ↓
-- RAW tables
--  ↓
-- Streams  ← Detect changes
--  ↓
-- Tasks
--  ↓
-- ANALYTICS
-- ============================================================