/*
=====================================================================================
Quality Checks
=====================================================================================
Script Purpose:
	This script performs various quality checks for data consistency, accuracy,
	and standardization across the 'silver' schemas. It includes checks for:
	- Null or duplicate primary keys.
	- Unwanted spaces in string fields.
	- Data standardization and consistency.
	- Invalid date ranges and orders.
	- Data consistency between related fields.
 
Usage Notes:
	- Run these checks after data loading Silver Layer.
	- Investigate and resolve any discrepancies found during the checks. 
==============================================================================
*/

--===================================================================
-- Checking silver.crm_cust_info
--===================================================================
-- Check for NULLs or Duplicates on Primary
-- Expectation: No Result
SELECT 
	cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted spaces
-- Expectation: No Result
SELECT 
	cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT 
	cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT 
	cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- Data Standarization & consistency
SELECT DISTINCT 
	cst_gndr
FROM silver.crm_cust_info;

SELECT DISTINCT 
	cst_marital_status
FROM silver.crm_cust_info;

--===================================================================
-- Checking  silver.crm_prd_info
--===================================================================
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT 
	prd_id, 
	count(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
-- Expectation: No Result
select 
	prd_nm
from silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLS or Negative Costs
select 
	prd_cost
from silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standarization & consistency
SELECT DISTINCT 
	prd_line
FROM silver.crm_prd_info;

-- Check for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Results
SELECT 
	*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--===================================================================
-- Check silver.crm_sales_details
--===================================================================
--Check for invalid dates
-- Expectation: No Invalid Dates
SELECT 
	NULLIF(sls_order_dt,0)
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 
	  OR LEN(sls_order_dt) != 8 
	  OR sls_order_dt > 20270101 
	  OR sls_order_dt < 19000101;

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation: No Results
SELECT 
	*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
	  OR sls_order_dt > sls_due_dt;

/*
Check Data Consistency: Between Sales, Quantity, and Price
>> Sales = Quantity * Price
>> Values must not be NULL, zero, or negative
*/
SELECT 
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
	  OR sls_sales IS NULL 
	  OR sls_quantity IS NULL 
	  OR sls_price IS NULL
	  OR sls_sales <= 0 
	  OR sls_quantity <= 0 
	  OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

--===================================================================
-- Check silver.erp_cust_az12
--===================================================================
-- Identify Out-of-Range Dates
SELECT DISTINCT 
	bdate
FROM silver.erp_cust_az12
WHERE bdate < '1930-01-01' OR bdate > GETDATE();

-- Data Standarization & Consistency
SELECT DISTINCT 
	gen
FROM silver.erp_cust_az12;

--===================================================================
-- Check silver.erp_px_g1v2
--===================================================================
--Check for unwanted spaces
SELECT 
	*
FROM silver.erp_px_cat_g1v2
where TRIM(cat) != cat OR TRIM(subcat) != subcat 
	  OR TRIM(maintenance) != maintenance;

-- Check data Standarization & Consistency
SELECT DISTINCT
	cat
FROM silver.erp_px_cat_g1v2;

SELECT DISTINCT
	subcat
FROM silver.erp_px_cat_g1v2;

SELECT DISTINCT
	maintenance
FROM silver.erp_px_cat_g1v2;

--===================================================================
--Check silver.erp_loc_a101
--===================================================================
-- Check data Standarization & Consistency
SELECT DISTINCT 
	cid
FROM silver.erp_loc_a101;

SELECT DISTINCT
	cntry
FROM silver.erp_loc_a101;
