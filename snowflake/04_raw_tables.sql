-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- RAW TABLES
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA RAW;


-- ============================================================
-- CUSTOMERS
-- ============================================================

CREATE TABLE IF NOT EXISTS RAW_CUSTOMERS (
    customer_id       VARCHAR,
    customer_name     VARCHAR,
    email             VARCHAR,
    city              VARCHAR,
    country           VARCHAR,
    signup_date       DATE,
    customer_segment  VARCHAR
);


-- ============================================================
-- PRODUCTS
-- ============================================================

CREATE TABLE IF NOT EXISTS RAW_PRODUCTS (
    product_id    VARCHAR,
    product_name  VARCHAR,
    category      VARCHAR,
    subcategory   VARCHAR,
    price         NUMBER(12,2)
);


-- ============================================================
-- ORDERS
-- ============================================================

CREATE TABLE IF NOT EXISTS RAW_ORDERS (
    order_id        VARCHAR,
    customer_id     VARCHAR,
    product_id      VARCHAR,
    order_date      DATE,
    quantity        NUMBER,
    discount        NUMBER(5,4),
    payment_method  VARCHAR,
    order_status    VARCHAR
);


-- ============================================================
-- RAW LAYER PURPOSE
--
-- RAW_CUSTOMERS → customer source records
-- RAW_PRODUCTS  → product source records
-- RAW_ORDERS    → order source records
--
-- Data is initially ingested from AWS S3 through Snowpipe.
-- Incremental changes are captured later through Streams.
-- ============================================================