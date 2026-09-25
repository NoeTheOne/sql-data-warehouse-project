
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
-- Explore All Countries our customers from.
SELECT DISTINCT
	country
FROM gold.dim_customers;

-- Explore All Categories "The major Divisions"
SELECT DISTINCT
	category, subcategoryu, product_name
FROM gold.dim_products
ORDER BY 1,2,3;
