-- ============================================================
-- E-COMMERCE DATA PIPELINE
-- DATABASE & SCHEMA SETUP
-- ============================================================

-- Create the project database
CREATE DATABASE IF NOT EXISTS ECOMMERCE_DW;

-- Use the project database
USE DATABASE ECOMMERCE_DW;

-- Raw layer: stores source data ingested from AWS S3
CREATE SCHEMA IF NOT EXISTS RAW;

-- Analytics layer: stores transformed dimensional and fact data
CREATE SCHEMA IF NOT EXISTS ANALYTICS;

-- Set the default schemas
USE SCHEMA RAW;

-- ============================================================
-- PROJECT ARCHITECTURE
--
-- AWS S3
--    ↓
-- Snowpipe
--    ↓
-- RAW schema
--    ↓
-- Streams
--    ↓
-- Tasks
--    ↓
-- ANALYTICS schema
--    ↓
-- Power BI
-- ============================================================