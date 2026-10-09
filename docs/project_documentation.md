# E-Commerce Data Pipeline — Project Documentation

## 1. Project Objective

Build an end-to-end e-commerce data pipeline using Amazon S3, Snowflake, and Power BI to ingest data, process incremental updates, validate data quality, and generate business insights.

## 2. Technology Stack

* Amazon S3 — cloud storage for CSV files
* Snowflake — cloud data warehouse
* Snowpipe — automated ingestion of incremental files
* Streams and Tasks — incremental data processing
* SQL — transformations, analytical views, and validation
* Power BI — business intelligence dashboards
* Git and GitHub — version control and project documentation

## 3. Architecture and Data Flow

1. Initial and incremental CSV files are stored in Amazon S3.
2. Snowpipe loads new incremental files into Snowflake RAW tables.
3. Snowflake Streams track changes to raw data.
4. Scheduled Tasks process stream data into analytical tables.
5. Dimension and fact tables support reporting.
6. SQL views provide aggregated business metrics.
7. Power BI presents sales, product, customer, and order analysis.

Refer to `../architecture/architecture.png` for the architecture diagram.

## 4. Snowflake Data Model

### RAW schema

* `RAW_CUSTOMERS`
* `RAW_PRODUCTS`
* `RAW_ORDERS`

### ANALYTICS schema

* `DIM_CUSTOMER`
* `DIM_PRODUCT`
* `FACT_ORDERS`

The model uses customer and product dimensions linked to the order fact table.

## 5. Incremental Processing

Snowpipe ingests files arriving in the configured S3 incremental folders. Streams capture changes in the raw tables, and scheduled Tasks process those changes into the analytics layer.

The pipeline uses separate processing flows for customers, products, and orders.

## 6. Recorded Data Volume

| Analytics table                    | Final row count |
| ---------------------------------- | --------------: |
| DIM_CUSTOMER                       |             515 |
| DIM_PRODUCT                        |             115 |
| FACT_ORDERS                        |           5,125 |
| **Total rows across these tables** |       **5,755** |

These counts reflect the recorded state of the completed project.

## 7. Data Quality Validation

Recorded checks included:

* Duplicate order IDs
* Orders without matching customer or product records
* Invalid order quantities
* Discounts outside the expected range
* Reconciliation of gross sales, discounts, and net sales

The final recorded validation found zero duplicate order IDs and zero orphan orders.

## 8. Power BI Reporting

The report contains three pages:

1. Executive Sales Dashboard
2. Product & Customer Analysis
3. Operations & Order Analysis

The dashboards use Snowflake analytics tables, analytical views, and a date table to analyze business performance.

## 9. Security and Reproducibility

Credentials, private keys, environment files, and Power BI report files should not be committed to the public repository.

Before using the SQL scripts to recreate the environment, verify the actual Snowflake object names, definitions, AWS storage integration, stages, pipes, streams, tasks, and permissions. Test scripts in an appropriate development environment before running them against a production environment.

## 10. Potential Future Improvements

* Add pipeline monitoring and failure notifications.
* Improve retry handling and duplicate prevention.
* Add automated transformation and data-quality tests.
* Document deployment, troubleshooting, and recovery procedures.
