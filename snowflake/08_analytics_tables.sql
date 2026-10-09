-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- ANALYTICS TABLES
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA ANALYTICS;


-- ============================================================
-- CUSTOMER DIMENSION
-- ============================================================

CREATE TABLE IF NOT EXISTS DIM_CUSTOMER (
    customer_id       VARCHAR,
    customer_name     VARCHAR,
    email             VARCHAR,
    city              VARCHAR,
    country           VARCHAR,
    signup_date       DATE,
    customer_segment  VARCHAR
);


-- ============================================================
-- PRODUCT DIMENSION
-- ============================================================

CREATE TABLE IF NOT EXISTS DIM_PRODUCT (
    product_id    VARCHAR,
    product_name  VARCHAR,
    category      VARCHAR,
    subcategory   VARCHAR,
    price         NUMBER(12,2)
);


-- ============================================================
-- ORDER FACT TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS FACT_ORDERS (
    order_id          VARCHAR,
    customer_id       VARCHAR,
    product_id        VARCHAR,
    order_date        DATE,
    quantity          NUMBER,
    discount          NUMBER(5,4),
    payment_method    VARCHAR,
    order_status      VARCHAR,

    unit_price        NUMBER(12,2),
    gross_amount      NUMBER(14,2),
    discount_amount   NUMBER(14,2),
    net_amount        NUMBER(14,2)
);


-- ============================================================
-- STAR SCHEMA
--
--                   DIM_CUSTOMER
--                        |
--                        |
--                        ↓
-- DIM_PRODUCT  →  FACT_ORDERS
--
-- FACT_ORDERS contains transactional measures.
--
-- DIM_CUSTOMER provides customer attributes.
-- DIM_PRODUCT provides product attributes.
--
-- Power BI uses these relationships for filtering and
-- analytical reporting.
-- ============================================================