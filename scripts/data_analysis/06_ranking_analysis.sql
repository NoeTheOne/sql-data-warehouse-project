/*
	Exploratory Data Analysis (EDA)
	Consists in 6 steps of exploratory actions helpng to undestand the Data on the business
*/
--=======================================================================
-- 06 >> Ranking Analysis
--=======================================================================
-- Wich 5 products generate the highest revenue
SELECT TOP 5 
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

SELECT * FROM (
SELECT 
	p.product_name,
	SUM(s.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(s.sales_amount) DESC) AS rank_products
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name) t
WHERE rank_products <= 5

-- What are the 5 worst-performing products in terms of sales?
SELECT TOP 5 
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue 

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key,c.first_name,c.last_name
ORDER BY total_revenue DESC

-- Find the 3 customers with the fewest orders placed
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT s.order_number) AS total_orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key,c.first_name,c.last_name
ORDER BY total_orders 
