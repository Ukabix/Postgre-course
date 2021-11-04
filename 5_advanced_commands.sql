/* Time and date information datatypes:
TIME - only time
DATE - only date
TIMESTAMP - date + time
TIMESTAMPTZ - date, time and timezone */

SHOW ALL /* shows all db and admin parameters */
SHOW TIMEZONE
SELECT NOW() /* FULL TIMESTAMPTZ info for now */
SELECT TIMEOFDAY() /* FULL TIMESTAMPTZ info for now as string */
SELECT CURRENT_TIME
SELECT CURRENT_DATE

/* EXTRACT() - allows to extract a subcomponent of date value:
YEAR, MONTH, DAY, WEEK, QUARTER */
EXTRACT(YEAR FROM date_col);

/* AGE() - calculates and returns current age of timestamp */
AGE(date_col);

/* TO_CHAR() - converts data types to text */
TO_CHAR(date_col,'mm-dd-yyyy');

/* EXAMPLES */
SELECT EXTRACT(YEAR FROM payment_date) AS pay_year
FROM payment;

SELECT AGE(payment_date)
FROM payment;

SELECT TO_CHAR(payment_date,'hh24:mi:ss dd-mm-yyyy')
FROM payment;

/* during which months did payments occur, format to return full month name */

SELECT DISTINCT(TO_CHAR(payment_date,'Month'))
FROM payment;

/* how many payments occured on a Monday */

SELECT * from payment
LIMIT 1;

SELECT COUNT(*)
FROM payment
WHERE EXTRACT(DOW from payment_date)=1;

/* MATH OPERATORS */
/* what % of replacement cost is the rental rate */
SELECT ROUND(rental_rate/replacement_cost,2)*100 AS repl_to_rent
FROM film;

/* make a deposit = 10% of replacement cost */
SELECT 0.1 * replacement_cost AS deposit
FROM film;

/* STRING FUNCTIONS AND OPERATIONS */
/* common examples: */
SELECT LENGHT(first_name) FROM customer;

SELECT first_name || ' ' || last_name AS full_name
FROM customer;

SELECT upper(first_name) || ' ' || upper(last_name) AS full_name
FROM customer;

SELECT LEFT(LOWER(first_name),1) || '.' || LOWER(last_name) || '@gmail.com' AS email
FROM customer;

/* SUBQUERY - a query on results of another query, uses two select statements */
/* get a list of students that scored better than avg score */

SELECT student,grade
FROM test_scores
WHERE grade > (SELECT AVG (grade)
FROM test_scores);

/* using IN list range */
SELECT student,grade
FROM test_scores
WHERE student IN
(SELECT student
FROM honor_roll_table);

/* EXIST operator - a kind of boolean var */
SELECT column_name
FROM table_name
WHERE EXISTS
(SELECT column_name FROM
table_name WHERE condition);

/* return films with rental rate higher than avg */

SELECT AVG(rental_rate) FROM film; /* subquery*/

SELECT title,rental_rate
FROM film
WHERE rental rate >
(SELECT AVG(rental_rate) FROM film); /* subquery is executed first! */

/* Subquery with joins
find film titles returned in certain set of dates */
SELECT * FROM rental
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'; /* no film_id here!, so we need to join inventory table */

SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'; /* returns list of film_ids - this is our subquery */

SELECT film_id,title
FROM film
WHERE film_id IN
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY title;

/* exists example - find names of customers who have at least 1 payment with amount > 11 */
SELECT first_name,last_name
FROM customer AS c /* c= org. customer table */
WHERE EXISTS
(SELECT * FROM payment AS p /* p = subquery customer table */
WHERE p.customer_id = c.customer_id
AND amount > 11);

/* SELF-JOIN - a query where a table is joined to itself
useful to compare values in a column of rows within the same table
join of two copies of the same table, use standard join syntax
! use alias! as below, same table has two aliases, thus allowing a join */
SELECT tableA.col, tableB.col
FROM table AS tableA
JOIN table AS tableB ON
tableA.some_col = tableB.other_col;

/* example: */
SELECT emp.name,report.name AS rep
FROM employees AS emp
JOIN employees AS report ON
emp.emp_id = report.report_id;

/* another example - find all pair of films with same lenght */
SELECT f1.title,f2.title,f2.length
FROM film AS f1
INNER JOIN film AS f2 ON
f1.film_id != f2.film_id
AND f1.length = f2.length;

