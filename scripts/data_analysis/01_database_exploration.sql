/*
	Exploratory Data Analysis (EDA)
	Consists in 6 steps of exploratory actions helpng to undestand the Data on the business
*/
--=======================================================================
-- 01 >> Database Exploration
--=======================================================================
-- Explore All Objects in the Database
SELECT 
	*
FROM INFORMATION_SCHEMA.TABLES

-- Explore All Columns in the Database
SELECT 
	*
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'
