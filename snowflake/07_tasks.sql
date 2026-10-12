```sql
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
    MERGE INTO DIM_CUSTOMER AS target
    USING (
        SELECT
            customer_id,
            customer_name,
            email,
            city,
            country,
            signup_date,
            customer_segment
        FROM ECOMMERCE_DW.RAW.CUSTOMER_STREAM
        QUALIFY ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY customer_id
        ) = 1
    ) AS source
    ON target.customer_id = source.customer_id
    WHEN MATCHED THEN UPDATE SET
        customer_name = source.customer_name,
        email = source.email,
        city = source.city,
        country = source.country,
        signup_date = source.signup_date,
        customer_segment = source.customer_segment,
        loaded_at = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN INSERT (
        customer_id,
        customer_name,
        email,
        city,
        country,
        signup_date,
        customer_segment,
        loaded_at
    )
    VALUES (
        source.customer_id,
        source.customer_name,
        source.email,
        source.city,
        source.country,
        source.signup_date,
        source.customer_segment,
        CURRENT_TIMESTAMP()
    );

-- ============================================================
-- PRODUCT TASK
-- ============================================================

CREATE TASK IF NOT EXISTS TASK_LOAD_PRODUCTS
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '5 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('ECOMMERCE_DW.RAW.PRODUCT_STREAM')
AS
    MERGE INTO DIM_PRODUCT AS target
    USING (
        SELECT
            product_id,
            product_name,
            category,
            subcategory,
            price
        FROM ECOMMERCE_DW.RAW.PRODUCT_STREAM
        QUALIFY ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY product_id
        ) = 1
    ) AS source
    ON target.product_id = source.product_id
    WHEN MATCHED THEN UPDATE SET
        product_name = source.product_name,
        category = source.category,
        subcategory = source.subcategory,
        price = source.price,
        loaded_at = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN INSERT (
        product_id,
        product_name,
        category,
        subcategory,
        price,
        loaded_at
    )
    VALUES (
        source.product_id,
        source.product_name,
        source.category,
        source.subcategory,
        source.price,
        CURRENT_TIMESTAMP()
    );

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
        net_amount,
        loaded_at
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
        o.quantity * p.price * o.discount AS discount_amount,
        o.quantity * p.price * (1 - o.discount) AS net_amount,
        CURRENT_TIMESTAMP()
    FROM ECOMMERCE_DW.RAW.ORDER_STREAM AS o
    INNER JOIN ECOMMERCE_DW.ANALYTICS.DIM_PRODUCT AS p
        ON o.product_id = p.product_id
    INNER JOIN ECOMMERCE_DW.ANALYTICS.DIM_CUSTOMER AS c
        ON o.customer_id = c.customer_id
    WHERE NOT EXISTS (
        SELECT 1
        FROM ECOMMERCE_DW.ANALYTICS.FACT_ORDERS AS f
        WHERE f.order_id = o.order_id
    );

-- ============================================================
-- TASK ACTIVATION
--
-- Run these RESUME statements only when intentionally
-- activating suspended tasks. Do not rerun blindly.
-- ============================================================

-- ALTER TASK TASK_LOAD_CUSTOMERS RESUME;
-- ALTER TASK TASK_LOAD_PRODUCTS RESUME;
-- ALTER TASK TASK_LOAD_ORDERS RESUME;
```