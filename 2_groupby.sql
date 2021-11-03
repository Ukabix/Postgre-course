/* -- GROUP BY aggregates data and lets us use functions to better understand data distribution -- */

/* -- AGGREGATE FUNCTIONS
only used in SELECT or HAVING clauses
AVG() = return mean avg value, use ROUND(int) to get precision from float
COUNT() = return number of values
MAX() = return max value
MIN() = return min value
SUM() = return sum of values
 -- */

SELECT MAX(replacement_cost) FROM film;
SELECT ROUND(AVG(replacement_cost),2)
FROM film;

/*-- GROUP BY 
only use on categorical columns = non-continious
--*/

SELECT category_col, AGGFUN(data_col)
FROM table_name
GROUP BY category_col;

SELECT company, division, SUM(sales)
FROM finance_table
GROUP BY company,division;

SELECT company, division, SUM(sales)
FROM finance_table
WHERE division IN('marketing','transport')
GROUP BY company,division;

SELECT company, SUM(sales)
FROM finance_table
GROUP BY company
ORDER BY SUM(sales)
LIMIT 10;

/*-- group customer ids --*/

SELECT customer_id FROM payment
GROUP BY customer_id
ORDER BY customer_id;

/*-- find best spending customer --*/

SELECT customer_id, SUM (amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

/*-- count their transactions --*/

SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

/*-- grouping by customer id and staff id - how much each customer spent with staff member sort by customer --*/

SELECT customer_id,staff_id, SUM(amount) FROM payment
GROUP BY staff_id,customer_id
ORDER BY customer_id;

/*-- grouping by customer id and staff id - how much each customer spent with staff member sort by staff member then customer --*/

SELECT staff_id,customer_id, SUM(amount) FROM payment
GROUP BY staff_id,customer_id
ORDER BY staff_id,customer_id;

/*-- date column = change timestamp into date --*/
SELECT DATE(payment_date) FROM payment
/* -- return distinct dates --*/
SELECT DATE(payment_date) FROM payment
GROUP BY DATE(payment_date);
/* -- how much is being processed each day? most profitable days --*/
SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;

/* -- we have two staff members with ID 1&2. We want to give bonus to the staff member who handled most payments (number, not value)
How many payments did each staff member handle and who gets the bonus? --*/

SELECT * FROM payment
LIMIT 1;

SELECT staff_id, COUNT(payment_id) FROM payment
GROUP BY staff_id
ORDER BY COUNT(payment_id);

/* -- conduct a study on the relationship between replacement cost of movie rating
What is the average replacement cost per rating? --*/

SELECT * FROM film
LIMIT 1;

SELECT rating, ROUND(AVG(replacement_cost),2) FROM film
GROUP BY rating
ORDER BY rating;

/* -- find customer ids of top 5 customers by total spend --*/

SELECT * FROM payment
LIMIT 1;

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

/* -- HAVING clause = allows us to filter after an aggregation has taken place,
comes after GROUP BY call,
WHERE on the other hand filters before aggregate function is run  --*/

SELECT company, SUM(sales)
FROM finance_table
WHERE comapny !='Google'
/* Google is not aggregated */
GROUP BY company
HAVING SUM(sales)<1000;
/* for all comapnies without Google */

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id
HAVING COUNT (customer_id) > 300;

/* -- what customer ids have 40 or more payments --*/

SELECT * FROM payment
LIMIT 1;

SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >= 40
ORDER BY COUNT(amount) DESC;

/* -- what are the ids of customers who spent more than 100$ in payment transactions with our staff id 2? --*/

SELECT * FROM payment
LIMIT 1;

SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC;

/* --  --*/
/* --  --*/
/* --  --*/