/*******************************************************************************************
    Project: SQL Data Warehouse & Analytics
    File:    02_load_bronze_procedure.sql
    Author:  [Your Name]
    Date:    [Date]

    Purpose:
    This stored procedure (bronze.load_bronze) automates the data ingestion 
    into the Bronze Layer of the Data Warehouse.

    Description:
    - The Bronze Layer stores raw, unprocessed data from multiple source systems 
      (ERP, CRM, and Excel files).
    - This procedure performs the following steps:
        1. Truncates existing Bronze tables (full load approach)
        2. Uses BULK INSERT to load CSV files into SQL Server tables
        3. Tracks and prints load duration for each dataset
        4. Implements TRY...CATCH for error handling
*******************************************************************************************/


/*******************************************************************************************
    PROCEDURE: bronze.load_bronze
*******************************************************************************************/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @whole_start_time DATETIME, @whole_end_time DATETIME;

    BEGIN TRY
        SET @whole_start_time = GETDATE();

        /*******************************************************************************************
            STEP 1: Load CRM Customer Info
        *******************************************************************************************/
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Saurabh Lagad\Data Engineer\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ('>> CRM_CUST_INFO LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds');


        /*******************************************************************************************
            STEP 2: Load CRM Product Info
        *******************************************************************************************/
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Saurabh Lagad\Data Engineer\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ('>> CRM_PRD_INFO LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds');


        /*******************************************************************************************
            STEP 3: Load CRM Sales Details
        *******************************************************************************************/
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Saurabh Lagad\Data Engineer\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ('>> CRM_SALES_DETAILS LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds');


        /*******************************************************************************************
            STEP 4: Load ERP Customer Data
        *******************************************************************************************/
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Saurabh Lagad\Data Engineer\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ('>> ERP_CUST_AZ12 LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds');


        /*******************************************************************************************
            STEP 5: Load ERP Location Data
        *******************************************************************************************/
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Saurabh Lagad\Data Engineer\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ('>> ERP_LOC_A101 LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds');


        /*******************************************************************************************
            STEP 6: Load ERP Product Category Data
        *******************************************************************************************/
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Saurabh Lagad\Data Engineer\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT ('>> ERP_PX_CAT_G1V2 LOAD DURATION: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds');

        /*******************************************************************************************
            STEP 7: Log Total Load Duration
        *******************************************************************************************/
        SET @whole_end_time = GETDATE();
        PRINT ('>> TOTAL BRONZE LAYER LOAD TIME: ' + CAST(DATEDIFF(second,@whole_start_time,@whole_end_time) AS NVARCHAR) + ' seconds');
    
    END TRY

    BEGIN CATCH
        PRINT '--------------------------------------';
        PRINT '❌ ERROR OCCURRED DURING BRONZE LAYER LOAD';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '--------------------------------------';
    END CATCH
END;
GO

/*******************************************************************************************
    EXECUTE PROCEDURE
*******************************************************************************************/
EXEC bronze.load_bronze;
GO
