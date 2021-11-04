/*  JOINS allows us to combine information from multiple tables 
join type helps to deal with information only present in one of the joined tables 
inner join - returns data present in both tables
outer join - returns data only present in one table */

/*  AS statement
allows us to create an alias for a column or result 
!executed at the end of the query
you can only use it with SELECT statement, not really anywhere else */

SELECT col AS new_name 
FROM table_name;

SELECT amount AS rental_price 
FROM payment;

SELECT SUM(amount) AS net_revenue
FROM payment;

SELECT COUNT(*) AS num_transactions
FROM payment;

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id;

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100; /*  correct */

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > 100; /*  !wrong, alias is given after filtering! */

/*  JOINS | INNER = iloczyn zbiorów
results with the set of records that match in both tables */

SELECT * FROM tableA
INNER JOIN TableB
ON TableA.col_match = TableB.col_match;

SELECT reg_id,Logins.name,log_id /* Logins.name | Registrations.name will give the same result */
FROM Registrations
INNER JOIN Logins
ON Registrations.name = Logins.name;

/*  let's link customer name with payment id */
SELECT payment_id,payment.customer_id,first_name
FROM payment
INNER JOIN customer
ON customer_id
ON payment.customer_id = customer.customer_id;

/*  JOINS | FULL OUTER = suma zbiorów
values only present in one table return null for the second and vice versa */

SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.col_match = TableB.col_match;

SELECT * Registrations
FULL OUTER JOIN Logins
ON Registrations.name = Logins.name;

/*  FULL OUTER JOIN with WHERE
get rows unique to either table = suma rozłączna zbiorów (suma - iloczyn) */

SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.col_match = TableB.col_match
WHERE TableA.id IS null 
OR TableB.id IS null;

SELECT * FROM Registrations
FULL OUTER JOIN Logins
ON Registrations.name = Logins.name
WHERE Registration.reg_id IS null
OR Logins.log_id IS null;

/*  check if we have any customer info on a customers that: never made a payment, not associated with any payment */
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.payment_id
WHERE customer.customer_id IS null
OR payment.payment_id IS null;

/*  JOIN | OUTER LEFT = różnica zbiorów A/B + iloczyn zbiorów A*B = tylko zbiór A
assymetrical, so order of query matters */

SELECT * FROM TableA
LEFT OUTER JOIN TableB /* == LEFT JOIN */
ON TableA.col_match = TableB.col_match;

SELECT * FROM Registrations
LEFT OUTER JOIN Logins
ON Registrations.name = Logins.name;

/* LEFT OUTER JOIN with WHERE - get only unique rows to left table = różnica zbiorów A-B */

SELECT * FROM TableA
LEFT OUTER JOIN TableB
ON TableA.col_mathch = TableB.col_match
WHERE TableB.id IS null;

SELECT * FROM Registrations
LEFT OUTER JOIN Logins
ON Registrations.name = Logins.name
WHERE Logins.log_id IS null;

/* find films that we are missing from our inventory, but we have them in our db */
SELECT film.film_id,film.title,inventory_id,store_id 
FROM film
LEFT OUTER JOIN inventory ON
inventory.film_id = film.film_id
WHERE inventory.film_id IS null;

/* JOINS | RIGHT */

SELECT * FROM TableA
RIGHT OUTER JOIN TableB
ON TableA.col_match = TableB.col_match;

SELECT * FROM TableA
RIGHT OUTER JOIN TableB
ON TableA.col_match = TableB.col_match
WHERE TableA.id IS null;

/* UNION 
an operator used to combine the result-set of two or more SELECT statements
pastes results of two select statements
they should be matching, to stack the results on each other */

SELECT column_name FROM TableA
UNION
SELECT column_name FROM TableB;

SELECT * FROM Sales2021_Q1
UNION
SELECT * FROM Sales2021_Q2
ORDER BY name;


/* We need to alert our customers who live in California via email */

/* Get a list of movies that "Nick Wahlberg" has been in */


