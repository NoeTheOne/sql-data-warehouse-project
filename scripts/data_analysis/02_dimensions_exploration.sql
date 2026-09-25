/*
	Exploratory Data Analysis (EDA)
	Consists in 6 steps of exploratory actions helpng to undestand the Data on the business
*/
--=======================================================================
-- 02 >> Dimensions Exploration
--=======================================================================
-- Explore All Countries our customers from.
SELECT DISTINCT
	country
FROM gold.dim_customers

-- Explore All Categories "The major Divisions"
SELECT DISTINCT
	category, subcategoryu, product_name
FROM gold.dim_products
order by 1,2,3
