-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- SNOWFLAKE TASKS
-- ============================================================

USE DATABASE ECOMMERCE_DW;
USE SCHEMA ANALYTICS;


-- ============================================================
-- CUSTOMER TASK
-- ============================================================

CREATE TASK IF NOT EXISTS TASK_LOAD_CUSTOMERS
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '5 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('ECOMMERCE_DW.RAW.CUSTOMER_STREAM')
AS
    INSERT INTO DIM_CUSTOMER (
        customer_id,
        customer_name,
        email,
        city,
        country,
        signup_date,
        customer_segment
    )
    SELECT
        customer_id,
        customer_name,
        email,
        city,
        country,
        signup_date,
        customer_segment
    FROM ECOMMERCE_DW.RAW.CUSTOMER_STREAM;


-- ============================================================
-- PRODUCT TASK
-- ============================================================

CREATE TASK IF NOT EXISTS TASK_LOAD_PRODUCTS
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '5 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('ECOMMERCE_DW.RAW.PRODUCT_STREAM')
AS
    INSERT INTO DIM_PRODUCT (
        product_id,
        product_name,
        category,
        subcategory,
        price
    )
    SELECT
        product_id,
        product_name,
        category,
        subcategory,
        price
    FROM ECOMMERCE_DW.RAW.PRODUCT_STREAM;


-- ============================================================
-- ORDER TASK
-- ============================================================

CREATE TASK IF NOT EXISTS TASK_LOAD_ORDERS
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '5 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('ECOMMERCE_DW.RAW.ORDER_STREAM')
AS
    INSERT INTO FACT_ORDERS (
        order_id,
        customer_id,
        product_id,
        order_date,
        quantity,
        discount,
        payment_method,
        order_status,
        unit_price,
        gross_amount,
        discount_amount,
        net_amount
    )
    SELECT
        o.order_id,
        o.customer_id,
        o.product_id,
        o.order_date,
        o.quantity,
        o.discount,
        o.payment_method,
        o.order_status,

        p.price AS unit_price,

        o.quantity * p.price AS gross_amount,

        o.quantity * p.price * o.discount
            AS discount_amount,

        o.quantity * p.price * (1 - o.discount)
            AS net_amount

    FROM ECOMMERCE_DW.RAW.ORDER_STREAM o

    INNER JOIN DIM_PRODUCT p
        ON o.product_id = p.product_id

    INNER JOIN DIM_CUSTOMER c
        ON o.customer_id = c.customer_id

    LEFT JOIN FACT_ORDERS f
        ON o.order_id = f.order_id

    WHERE f.order_id IS NULL;


-- ============================================================
-- TASK SCHEDULE
--
-- Tasks execute every 5 minutes, but only when the associated
-- Stream contains data.
--
-- SYSTEM$STREAM_HAS_DATA()
-- prevents unnecessary transformation execution when there
-- are no new records.
--
-- Flow:
--
-- RAW → Stream → Task → Analytics
--
-- Customer:
-- CUSTOMER_STREAM → TASK_LOAD_CUSTOMERS → DIM_CUSTOMER
--
-- Product:
-- PRODUCT_STREAM → TASK_LOAD_PRODUCTS → DIM_PRODUCT
--
-- Orders:
-- ORDER_STREAM → TASK_LOAD_ORDERS → FACT_ORDERS
-- ============================================================


-- ============================================================
-- ACTIVATE TASKS
-- ============================================================

ALTER TASK TASK_LOAD_CUSTOMERS RESUME;
ALTER TASK TASK_LOAD_PRODUCTS RESUME;
ALTER TASK TASK_LOAD_ORDERS RESUME;