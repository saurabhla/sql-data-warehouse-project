INSERT INTO silver.crm_cust_info(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_material_status,
cst_gndr,
cst_create_date)
SELECT cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE									
WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
ELSE 'unknown'
END AS cst_material_status,
CASE									
WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
ELSE 'unknown'
END AS cst_gndr,
cst_create_date
FROM
( 
Select *, 
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronze.crm_cust_info
) t 
WHERE flag_last = 1 AND cst_id IS NOT NULL

INSERT INTO silver.crm_prd_info (
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5), '-','_') as cat_id,
SUBSTRING(prd_key, 7,LEN(prd_key)) as prd_key,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	WHEN 'M' THEN 'Mountain'
	WHEN 'R' THEN 'Road'
	WHEN 'S' THEN 'Other Sales'
	WHEN 'T' THEN 'Touring'
	ELSE 'unknown'
END AS prd_line,
CAST( prd_start_dt as DATE) as prd_start_dt,
DATEADD(day, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt
FROM bronze.crm_prd_info;


INSERT INTO silver.crm_sales_details
(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price)
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE 
	WHEN sls_order_dt < 0 or LEN(sls_order_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END AS sls_order_dt,
CASE 
	WHEN sls_ship_dt < 0 or LEN(sls_ship_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
END AS sls_ship_dt,
CASE 
	WHEN sls_due_dt < 0 or LEN(sls_due_dt) != 8 THEN NULL
	ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
END AS sls_due_dt,
CASE
	WHEN sls_sales <= 0 OR sls_sales IS NULL OR sls_sales != sls_quantity * ABS(sls_price) 
	THEN 
	sls_quantity * ABS(sls_price)
	ELSE sls_sales
END as sls_sales,
sls_quantity,
CASE 
	WHEN sls_price IS NULL OR sls_price <= 0
	THEN (sls_sales/ sls_quantity)
	ELSE sls_price
END AS sls_price
FROM 
bronze.crm_sales_details



