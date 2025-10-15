/*******************************************************************************************
    Project: SQL Data Warehouse & Analytics
    File:    create_bronze_tables.sql
    Purpose: Create all source (Bronze Layer) tables for CRM and ERP systems

    Description:
    This script creates the Bronze Layer tables that store raw, unprocessed data 
    directly as received from various source systems (ERP, CRM, Excel, etc.).
    
    Each table represents a different data source and is designed to:
    - Retain source structure and naming conventions
    - Enable data traceability and debugging
    - Avoid transformations at this stage (Raw Layer)
*******************************************************************************************/


/*******************************************************************************************
    CRM SOURCE TABLES
*******************************************************************************************/

-- 1️⃣ CRM Customer Information Table
-- Holds basic customer profile data as extracted from CRM system
IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info ( 
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);
GO


-- 2️⃣ CRM Product Information Table
-- Contains product metadata and validity period as captured in CRM
IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);
GO


-- 3️⃣ CRM Sales Details Table
-- Stores transactional sales data at order line level
IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);
GO


/*******************************************************************************************
    ERP SOURCE TABLES
*******************************************************************************************/

-- 4️⃣ ERP Customer Table
-- Basic customer demographic data from ERP source
IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12(
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);
GO


-- 5️⃣ ERP Location Table
-- Contains customer-to-country mapping information
IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101(
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);
GO


-- 6️⃣ ERP Product Category Table
-- Holds product category, subcategory, and maintenance details
IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO


/*******************************************************************************************
    END OF SCRIPT
*******************************************************************************************/
