# E-Commerce Data Pipeline | AWS S3, Snowflake & Power BI

An end-to-end data analytics engineering portfolio project demonstrating cloud data ingestion, automated incremental loading, SQL transformations, data quality validation, and business intelligence reporting.

## Architecture

![E-Commerce Data Pipeline Architecture](architecture/architecture.png)

## Technology Stack

<<<<<<< HEAD
* **Cloud storage:** Amazon S3
* **Data warehouse:** Snowflake
* **Data ingestion:** Snowpipe with automatic ingestion
* **Incremental processing:** Snowflake Streams and Tasks
* **Data modeling:** Fact and dimension tables
* **Business intelligence:** Power BI
* **Version control:** Git and GitHub

## Pipeline Overview8

1. Store initial and incremental CSV files in Amazon S3.
2. Ingest incremental files into Snowflake using Snowpipe.
3. Capture new data with Snowflake Streams.
4. Process changes through scheduled Tasks.
5. Load customer and product dimensions and the order fact table.
6. Validate records and relationships with SQL data-quality checks.
7. Analyze sales, products, customers, and orders in Power BI.

## Data Volume

| Table        | Final row count |
| ------------ | --------------: |
| DIM_CUSTOMER |             515 |
| DIM_PRODUCT  |             115 |
| FACT_ORDERS  |           5,125 |
| **Total**    |       **5,755** |

These are the recorded project results. The total is the sum of the three tables, not a count of unique entities across all tables.


## Data Quality

The recorded final validation included:

* No duplicate order IDs
* No orphan orders
* Checks for invalid quantities and discount values
* Reconciliation of gross sales, discounts, and net sales
=======
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

### Dashboard Screenshots

#### Executive Sales Dashboard
![Executive Sales Dashboard](powerbi/screenshots/Executive%20Sales%20Dashboard.png)

#### Product & Customer Analysis
![Product & Customer Analysis](powerbi/screenshots/Product%20%26%20Customer%20Analysis.png)

#### Operations & Order Analysis
![Operations & Order Analysis](powerbi/screenshots/Operations%20%26%20Order%20Analysis.png)

*Dashboard screenshots will be added to the `powerbi/` folder.*
>>>>>>> 0c69581985921bdf1c42c6db41785e1461c15808

## Repository Structure

```text
ecommerce-data-pipeline/
├── architecture/
<<<<<<< HEAD
│   └── architecture.png
├── data/
├── docs/
=======
├── data/
├── docs/
│   └── project_documentation.md
>>>>>>> 0c69581985921bdf1c42c6db41785e1461c15808
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

<<<<<<< HEAD
## Security

Credentials, private keys, environment files, and Power BI report files are excluded through `.gitignore`. Do not commit credentials, account identifiers that should remain private, or sensitive business data.

## Future Improvements

* Add automated pipeline monitoring and failure alerts.
* Add stronger duplicate handling and retry controls.
* Add automated tests for transformations and data quality.
* Document deployment and recovery procedures.
=======
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
>>>>>>> 0c69581985921bdf1c42c6db41785e1461c15808
