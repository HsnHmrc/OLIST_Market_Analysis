-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
-- <1> Case 1 : Order Analysis
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
---- <1.1> Question 1 : Please provide the monthly order distribution.
-------------------------------------------------------------------------------------------------------------------------------

SELECT 
	DATE_TRUNC ('MONTH',order_approved_at)::DATE AS monthly,
	COUNT (order_id)
FROM orders
GROUP BY 1
ORDER BY 1

	

-------------------------------------------------------------------------------------------------------------------------------
---- <1.2> Question 2 : Show the number of orders in order status breakdown on a monthly basis.
-------------------------------------------------------------------------------------------------------------------------------

SELECT 
	TO_CHAR(order_approved_at,'yyyy-mm') AS monthly,
	order_status,
	COUNT(order_id)
FROM orders
GROUP BY 1,2
ORDER BY 1,2


	
-------------------------------------------------------------------------------------------------------------------------------
---- <1.3> Question 3 : Show the number of orders by product category.
-------------------------------------------------------------------------------------------------------------------------------

-- <1.3.1> For the New Year; 
SELECT 
	category_name_english AS category,
	COUNT (oi.order_id) AS order_count
FROM translation AS t
INNER JOIN products AS p
	ON p.product_category_name=t.category_name
INNER JOIN order_items AS oi
	ON oi.product_id=p.product_id
INNER JOIN orders AS o
	ON o.order_id=oi.order_id
WHERE TO_CHAR(order_approved_at,'yyyy-mm')='2017-12'
GROUP BY 1
ORDER BY 2 DESC
	
-- <1.3.2> For Independence Day; 
SELECT 
	category_name_english AS category,
	COUNT (oi.order_id) AS order_count
FROM translation AS t
INNER JOIN products AS p
	ON p.product_category_name=t.category_name
INNER JOIN order_items AS oi
	ON oi.product_id=p.product_id
INNER JOIN orders AS o
	ON o.order_id=oi.order_id
WHERE TO_CHAR(order_approved_at,'yyyy-mm-dd') BETWEEN '2017-08-07' AND '2017-09-07'
GROUP BY 1
ORDER BY 2 DESC
	
-- <1.3.3>For the Carnival; 
SELECT 
	category_name_english AS category,
	COUNT (oi.order_id) AS order_count
FROM translation AS t
INNER JOIN products AS p
	ON p.product_category_name=t.category_name
INNER JOIN order_items AS oi
	ON oi.product_id=p.product_id
INNER JOIN orders AS o
	ON o.order_id=oi.order_id
WHERE TO_CHAR(order_approved_at,'yyyy-mm')= '2017-02' or TO_CHAR(order_approved_at,'yyyy-mm')= '2018-02'
GROUP BY 1
ORDER BY 2 DESC


	
-------------------------------------------------------------------------------------------------------------------------------
---- <1.4> Question 4 : Examine the number of orders on the basis of days of the week (Monday, Thursday, ....) 
-- and days of the month (such as the 1st, 2nd of the month).
-------------------------------------------------------------------------------------------------------------------------------

--Days of Week:
SELECT 
	TO_CHAR(order_approved_at, 'Day') AS week_days,
	COUNT (order_id) AS orders_count
FROM orders
WHERE TO_CHAR(order_approved_at, 'Day') IS NOT NULL
GROUP BY 1, EXTRACT (ISODOW FROM order_approved_at)
ORDER BY EXTRACT (ISODOW FROM order_approved_at)


--Days of Month:
SELECT 
    EXTRACT(DAY FROM order_approved_at) AS day_of_month,
    count (order_id) as orders_count
FROM 
    orders
WHERE EXTRACT(DAY FROM order_approved_at) IS NOT NULL
GROUP BY 1
ORDER BY 1


	
-------------------------------------------------------------------------------------------------------------------------------
-- <2> Case 2 : Customer Analysis
-------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
---- <2.1> Question 1 : In which cities do customers shop more? 
-- Identify the customer's city as the city where they place the most orders and analyze accordingly.
-------------------------------------------------------------------------------------------------------------------------------
	
WITH all_customers AS
(
	SELECT
		c.customer_id,
		customer_city,
		COUNT (order_id) AS order_count
	FROM customers AS c
	JOIN orders AS o
		ON o.customer_id=c.customer_id
	GROUP BY 1,2
), 
	customer_with_city AS
(
	SELECT
		customer_id,
		customer_city,
		order_count,
		ROW_NUMBER () OVER (PARTITION BY customer_id ORDER BY order_count) AS rn
	FROM all_customers
)

SELECT 
	customer_id,
	customer_city,
	order_count
FROM customer_with_city
WHERE rn=1



-------------------------------------------------------------------------------------------------------------------------------
-- <3> Case 3: Seller Analysis
-------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
---- <3.1> Question 1 : Who are the sellers who deliver orders to customers the fastest? Bring the top 5.
-------------------------------------------------------------------------------------------------------------------------------
	
WITH sellers_shipping_time AS
(
	SELECT 
		s.seller_id,
		COUNT(o.order_id) total_order_count,
		AVG(order_delivered_carrier_date - order_purchase_timestamp) AS sellers_avg_shipping_time
	FROM sellers AS s
	JOIN order_items AS oi
		ON oi.seller_id=s.seller_id
	JOIN orders AS o
		ON o.order_id=oi.order_id
	WHERE (order_delivered_carrier_date - order_purchase_timestamp) IS NOT NULL AND (order_delivered_carrier_date - order_purchase_timestamp)>'0'
	GROUP BY 1
	ORDER BY 3
	LIMIT 5
)
SELECT
	sst.seller_id,
	total_order_count,
	sellers_avg_shipping_time,
	review_score,
	review_comment_message
FROM sellers_shipping_time AS sst
JOIN order_items AS oi
	ON sst.seller_id=oi.seller_id
JOIN reviews AS r
	ON oi.order_id=r.order_id



-------------------------------------------------------------------------------------------------------------------------------
---- <3.2> Question 2 : Which sellers sell products from more categories?
-------------------------------------------------------------------------------------------------------------------------------
	
SELECT
	seller_id,
	COUNT(DISTINCT product_category_name) AS categories,
	COUNT (o.order_id) AS order_count
FROM order_items AS oi
JOIN products AS p
	ON p.product_id=oi.product_id
JOIN orders AS o
	ON oi.order_id=o.order_id
GROUP BY 1
ORDER BY 2 DESC



-------------------------------------------------------------------------------------------------------------------------------
-- <4> Case 4 : Payment Analysis
-------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
---- <4.1> Question 1 : In which region do users who pay in more installments live the most?
-------------------------------------------------------------------------------------------------------------------------------

SELECT 
	c.customer_city,
	MAX(payment_sequential) AS tax_,
	COUNT(o.order_id) AS order_count
FROM payments AS p
JOIN orders AS o
	ON o.order_id=p.order_id
JOIN customers AS c
	ON o.customer_id=c.customer_id
GROUP BY 1
ORDER BY 3 DESC



-------------------------------------------------------------------------------------------------------------------------------
---- <4.2> Question 2 : Calculate the number of successful orders and total amount of successful payments by payment type. 
-- Sort from the most used payment type to the least used payment type.
-------------------------------------------------------------------------------------------------------------------------------

WITH succ_order AS
(
	SELECT
		payment_type,
		COUNT (DISTINCT p.order_id) AS order_count
	FROM payments AS p
	JOIN orders AS o
		ON p.order_id=o.order_id
	WHERE order_status='delivered'
	GROUP BY 1
	ORDER BY 2 DESC
)
SELECT 
	payment_type,
	order_count,
	(
		SELECT 
	 		ROUND(SUM(payment_value)::numeric,2)
	 	FROM payments AS p
	 	JOIN orders AS o
	 		ON o.order_id=p.order_id
		 WHERE order_status != 'canceled'
	) AS sum_succ_paymet
FROM succ_order



-------------------------------------------------------------------------------------------------------------------------------
---- <4.3> Question 3 : Make a category-based analysis of orders paid in single check and installments. 
-- Which categories use installment payments the most?
-------------------------------------------------------------------------------------------------------------------------------

WITH one_shot_payment AS
(
	SELECT 
		DISTINCT order_id AS one_shot_order_id,
		MAX(payment_sequential) AS one_shot
	FROM payments 
	GROUP BY 1
	HAVING MAX(payment_sequential)=1
	ORDER BY 2 DESC
),
taxit_payment AS
(
	SELECT 
		DISTINCT order_id AS tax_order_id,
		MAX(payment_sequential) AS one_shot
	FROM payments 
	GROUP BY 1
	HAVING MAX(payment_sequential)>1
	ORDER BY 2 ASC
)
SELECT 
	category_name_english,
	COUNT(DISTINCT tax_order_id) AS taxit_order_count,
	COUNT(DISTINCT one_shot_order_id) AS one_shot_order_count
FROM translation AS t
JOIN products AS pr 
	ON t.category_name=pr.product_category_name
JOIN order_items AS oi
	ON pr.product_id=oi.product_id
LEFT JOIN taxit_payment AS tp
	ON tp.tax_order_id=oi.order_id
LEFT JOIN one_shot_payment AS osp
	ON osp.one_shot_order_id=oi.order_id
GROUP BY 1
ORDER BY 2 DESC


	
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
-- <RFM> RFM ANALYSIS (Recency - Frequence - Monetary)
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------

WITH rfm_analysis AS 
(
WITH recency_values AS
(	WITH max_date AS
 	(
		SELECT
			DISTINCT customer_id,
			MAX(invoicedate) AS max_invoice_date
		FROM rfm
		GROUP BY 1
	)
	SELECT
 		customer_id,
 		AGE('2011-12-09',max_invoice_date::DATE) AS recency
 	FROM max_date
),
	frequency_values AS
(
	SELECT
		DISTINCT customer_id,
		COUNT(DISTINCT invoiceno) AS frequency
	FROM rfm
	GROUP BY 1
),
	monetary_values AS
(
	SELECT
		DISTINCT customer_id,
		ROUND(SUM(quantity*unitprice)::NUMERIC,2) AS monetary
	FROM rfm
	--WHERE unitprice>0 AND quantity>0
	GROUP BY 1
)
SELECT
	r.customer_id,
	recency,
	frequency,
	monetary
FROM recency_values AS r
JOIN frequency_values AS f
	ON r.customer_id=f.customer_id
JOIN monetary_values AS m
	ON r.customer_id=m.customer_id
ORDER BY 2
)
SELECT
	customer_id,
	CASE
		WHEN recency<='3 days' THEN 5
		WHEN recency>'3 days' AND recency<='10 days' THEN 4
		WHEN recency>'10 days' AND recency<='30 days' THEN 3
		WHEN recency>'30 days' AND recency<='90 days' THEN 2
		WHEN recency>'90 days' THEN 1
	END AS recency,
	CASE
		WHEN frequency<=5 THEN 1
		WHEN frequency>5 AND frequency<=20 THEN 2
		WHEN frequency>20 AND frequency<=50 THEN 3
		WHEN frequency>50 AND frequency<=100 THEN 4
		WHEN frequency>100 THEN 5
	END AS frequency,
	CASE
		WHEN monetary<=200 THEN 1
		WHEN monetary>200 AND monetary<=500 THEN 2
		WHEN monetary>500 AND monetary<=1000 THEN 3
		WHEN monetary>1000 AND monetary<=50000 THEN 4
		WHEN monetary>50000 THEN 5
	END AS monetary
FROM rfm_analysis