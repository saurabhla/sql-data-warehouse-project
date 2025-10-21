/********************************************************************************************
 Description   : 
   This script creates three key views for the GOLD layer of the data warehouse:
   1. gold.dim_customers – Customer dimension view
   2. gold.dim_products  – Product dimension view
   3. gold.fact_sales    – Sales fact view

 Purpose:
   These views serve as the foundation for business intelligence (BI), reporting, 
   and analytics use cases. The GOLD layer provides cleansed, conformed, 
   and enriched data ready for use in Power BI dashboards, machine learning models, 
   and ad-hoc data exploration.

 Usage:
   - Query these views directly in analytical tools.
   - Join DIM (dimension) views with FACT views on surrogate keys for insights.
   - Example:
        SELECT c.first_name, c.country, p.product_name, f.sales_amount
        FROM gold.fact_sales f
        JOIN gold.dim_customers c ON f.customer_key = c.customer_key
        JOIN gold.dim_products p  ON f.product_key = p.product_key;

********************************************************************************************/


/*===========================================================================================
  1. Customer Dimension View: gold.dim_customers
     - Builds a unified view of customer attributes combining CRM and ERP data.
     - Adds surrogate key, enriches gender and country information.
===========================================================================================*/
CREATE OR REPLACE VIEW gold.dim_customers AS 
SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,             -- Surrogate key for dimension joins
    ci.cst_id AS customer_id,                                        -- Business customer ID from CRM
    ci.cst_key AS customer_number,                                   -- External system customer key
    ci.cst_firstname AS first_name,                                  -- Customer first name
    ci.cst_lastname AS last_name,                                    -- Customer last name
    ca.cntry AS country,                                             -- Country from ERP location data
    ci.cst_material_status AS marital_status,                        -- Marital status
    CASE 
        WHEN ci.cst_gndr != 'unknown' THEN ci.cst_gndr               -- Use CRM gender if valid
        ELSE COALESCE(az.gen, 'unknown')                             -- Fallback to ERP gender or mark unknown
    END AS gender,
    az.bdate AS birthdate,                                           -- Birthdate from ERP auxiliary table
    cst_create_date AS create_date                                   -- Record creation date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 az
    ON ci.cst_key = az.cid
LEFT JOIN silver.erp_loc_a101 ca
    ON ci.cst_key = ca.cid;



/*===========================================================================================
  2. Product Dimension View: gold.dim_products
     - Creates a product dimension with category and cost details.
     - Filters out inactive products (prd_end_dt IS NULL).
===========================================================================================*/
CREATE OR REPLACE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,  -- Surrogate key
    pn.prd_id AS product_id,                                                  -- Business product ID
    pn.prd_key AS product_number,                                             -- Product key from CRM
    pn.prd_nm AS product_name,                                                -- Product name
    pn.cat_id AS category_id,                                                 -- Category ID
    pc.cat AS category,                                                       -- Category name
    pc.subcat AS subcategory,                                                 -- Subcategory name
    pc.maintenance,                                                           -- Maintenance category flag
    pn.prd_cost AS cost,                                                      -- Product cost
    pn.prd_line AS product_line,                                              -- Product line or brand
    pn.prd_start_dt AS start_date                                             -- Product start date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;                                                  -- Exclude discontinued products



/*===========================================================================================
  3. Sales Fact View: gold.fact_sales
     - Combines sales transactions with customer and product dimensions.
     - Provides metrics like sales amount, quantity, and price.
===========================================================================================*/
CREATE OR REPLACE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num AS order_number,       -- Unique order number
    pd.product_key,                       -- Foreign key to product dimension
    cu.customer_key,                      -- Foreign key to customer dimension
    sd.sls_order_dt AS order_date,        -- Order creation date
    sd.sls_ship_dt AS shipping_date,      -- Shipment date
    sd.sls_due_dt AS due_date,            -- Expected delivery date
    sd.sls_sales AS sales_amount,         -- Total sales amount
    sd.sls_quantity AS quantity,          -- Quantity sold
    sd.sls_price AS price                 -- Unit price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pd 
    ON sd.sls_prd_key = pd.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;



/********************************************************************************************
 Notes:
 - These views form a standard STAR SCHEMA: 
       * dim_customers  → Customer Dimension
       * dim_products   → Product Dimension
       * fact_sales     → Fact Table for transactional data
 - Ensure that gold layer permissions are configured for BI and analytics users.
 - Update periodically to reflect latest records from SILVER layer.
********************************************************************************************/
