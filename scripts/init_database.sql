/*******************************************************************************************
    Project: SQL Data Warehouse & Analytics
    File:    create_datawarehouse.sql
    Purpose: Create a new SQL Data Warehouse with layered schemas (Bronze, Silver, Gold)
    Author:  Saurabh
 

    Description:
    This script creates a clean Data Warehouse environment by:
    1. Dropping the existing DataWarehouse database (if it exists)
    2. Creating a new DataWarehouse database
    3. Defining three schemas — bronze, silver, and gold — representing different data layers

	WARNING:
		Running this script will drop the entire 'DataWarehouse' database if it exists.
*******************************************************************************************/

-- Switch to master database
USE master;
GO

/*******************************************************************************************
    STEP 1: Drop the existing DataWarehouse database (if it already exists)
*******************************************************************************************/
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    -- Force disconnect all users and drop the existing database
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

/*******************************************************************************************
    STEP 2: Create a new DataWarehouse database
*******************************************************************************************/
CREATE DATABASE DataWarehouse;
GO

-- Switch context to the new DataWarehouse
USE DataWarehouse;
GO

/*******************************************************************************************
    STEP 3: Create Schemas for Medallion Architecture
*******************************************************************************************/

-- Bronze Schema: Raw, unprocessed data directly from source
CREATE SCHEMA bronze;
GO

-- Silver Schema: Cleaned, standardized, and transformed data
CREATE SCHEMA silver;
GO

-- Gold Schema: Business-ready data models and views for analytics
CREATE SCHEMA gold;
GO

/*******************************************************************************************
    END OF SCRIPT
*******************************************************************************************/
