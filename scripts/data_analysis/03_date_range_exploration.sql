/*
	Exploratory Data Analysis (EDA)
	Consists in 6 steps of exploratory actions helpng to undestand the Data on the business
*/
--=======================================================================
-- 03 >> Date Exploration
--=======================================================================
-- Find the date of the first and last order
SELECT 
	MIN(order_date) as fist_order_date, 
	MAX(order_date) as last_order_date,
	DATEDIFF(year, MIN(order_date), MAX(order_date)) as order_range_years
FROM gold.fact_sales

-- Explore oldest and youngest customers
SELECT 
	MIN(birthdate) AS oldest_birthdate,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS youngest_birthdate,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers
