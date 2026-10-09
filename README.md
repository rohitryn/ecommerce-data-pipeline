# E-Commerce Data Engineering & Analytics Pipeline

An end-to-end data engineering and business intelligence project using **AWS S3, Snowflake, SQL, and Power BI** to ingest e-commerce data, process incremental updates, build an analytics data model, and deliver interactive dashboards.

## Project Overview

This project simulates an e-commerce data platform that processes customer, product, and order data from CSV files stored in Amazon S3. Snowpipe automates file ingestion, Snowflake Streams track changes, and scheduled Tasks process incremental records into analytics tables. Power BI connects to Snowflake to support sales, product, customer, and operational analysis.

## Architecture

**Data flow:**

`AWS S3 → Snowflake Stages → Snowpipe → RAW Tables → Streams → Tasks → Analytics → Power BI`

New files uploaded to configured incremental S3 folders are ingested through Snowpipe. Scheduled tasks check for stream data every five minutes and process pending changes.

![E-Commerce Data Pipeline Architecture](architecture/architecture.png)

## Technology Stack

| Technology        | Purpose                                   |
| ----------------- | ----------------------------------------- |
| Amazon S3         | Source file storage                       |
| Snowflake         | Cloud data warehouse                      |
| Snowpipe          | Automated file ingestion                  |
| Snowflake Streams | Change tracking                           |
| Snowflake Tasks   | Scheduled incremental processing          |
| SQL               | Transformation and data quality checks    |
| Power BI          | Interactive reporting and visualization   |
| Git / GitHub      | Version control and project documentation |

## Data Pipeline

1. **Source:** Customer, product, and order CSV files are stored in S3.
2. **Staging:** Snowflake external stages point to the configured S3 folders.
3. **Ingestion:** Snowpipe automatically loads files from incremental folders into RAW tables.
4. **Change tracking:** Streams capture changes to raw data after the streams are created.
5. **Transformation:** Scheduled tasks process stream data and load the analytics layer.
6. **Analytics:** Dimension and fact tables support reporting and business analysis.
7. **Visualization:** Power BI dashboards present sales, customer, product, and operational metrics.

## Data Model

The analytics layer uses a star-schema design.

* **`DIM_CUSTOMER`** — customer details, location, and segment.
* **`DIM_PRODUCT`** — product details, category, subcategory, and price.
* **`FACT_ORDERS`** — order transactions, quantities, discounts, and calculated monetary amounts.

The fact table includes:

* `gross_amount`
* `discount_amount`
* `net_amount`

## Project Results

Final analytics table counts from the completed project run:

| Table          |   Records |
| -------------- | --------: |
| `DIM_CUSTOMER` |       515 |
| `DIM_PRODUCT`  |       115 |
| `FACT_ORDERS`  |     5,125 |
| **Total**      | **5,755** |

Data quality validation found **zero duplicate order IDs and zero orphan orders** in the final fact table.

## Power BI Dashboards

The report contains three pages:

### 1. Executive Sales Dashboard

* Total sales, orders, units, discounts, and average order value
* Monthly sales trend
* Sales by category
* Order status distribution
* Interactive date and business filters

### 2. Product & Customer Analysis

* Top products by sales
* Sales by category and subcategory
* Top customers by sales
* Customer segment analysis
* Units sold by category

### 3. Operations & Order Analysis

* Order and unit KPIs
* Monthly order trends
* Payment method analysis
* Sales by order status
* Cancellation rate

*Dashboard screenshots will be added to the `powerbi/` folder.*

## Repository Structure

```text
ecommerce-data-pipeline/
├── architecture/
├── data/
├── docs/
│   └── project_documentation.md
├── powerbi/
├── snowflake/
│   ├── 01_database_schema.sql
│   ├── 02_file_formats.sql
│   ├── 03_stages.sql
│   ├── 04_raw_tables.sql
│   ├── 05_snowpipes.sql
│   ├── 06_streams.sql
│   ├── 07_tasks.sql
│   ├── 08_analytics_tables.sql
│   ├── 09_views.sql
│   └── 10_data_quality.sql
├── .gitignore
└── README.md
```

## Running the Project

The SQL files document the main Snowflake objects and validation queries. To reproduce the project in another environment:

1. Configure an AWS S3 bucket and upload the source CSV files.
2. Configure a Snowflake storage integration and the necessary AWS permissions.
3. Review the SQL scripts and adjust object names or configuration to match your environment.
4. Create the database, schemas, file format, stages, and raw tables.
5. Configure Snowpipe and S3 event notifications.
6. Create the analytics tables, Streams, Tasks, and views.
7. Load initial data, then test the incremental ingestion workflow.
8. Connect Power BI to Snowflake and configure the data model and visuals.

**Note:** Account-specific AWS resources, storage integration permissions, event notifications, and any required task setup must be configured separately. The repository scripts should be reviewed against the live Snowflake definitions before being used as a fresh deployment.

## Data Quality Checks

The repository includes SQL checks for:

* Duplicate customer, product, and order IDs
* Orphan fact records
* Missing key fields
* Invalid quantities and discount values
* Monetary calculation reconciliation
* Final table row counts

## Security

Never commit passwords, AWS access keys, private keys, or Snowflake credentials. The `.gitignore` file excludes common credential files, local environments, logs, and Power BI project files.

## Future Enhancements

* Automated pipeline monitoring and failure alerts
* Stronger automated data-quality tests
* Slowly changing dimensions
* CI/CD for Snowflake SQL deployment
* More advanced sales forecasting and customer segmentation

---

**Project focus:** Cloud data ingestion, incremental data processing, dimensional modeling, SQL transformations, data quality, and business intelligence reporting.
