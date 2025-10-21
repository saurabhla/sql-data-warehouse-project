CREATE VIEW gold.dim_customers AS 
SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ca.cntry AS country,
	ci.cst_material_status as marital_status,
	CASE 
		WHEN ci.cst_gndr !='unknown' THEN ci.cst_gndr
		ELSE COALESCE(az.gen, 'unkown')
	END AS gender,
	az.bdate AS birthdate,
	cst_create_date AS create_date
FROM
silver.crm_cust_info ci LEFT JOIN silver.erp_cust_az12 az
ON ci.cst_key = az.cid
LEFT JOIN silver.erp_loc_a101 ca
ON ci.cst_key = ca.cid
