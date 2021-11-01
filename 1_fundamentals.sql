/* -- basic select
query emails of existing customers -- */

SELECT col_name1, col_name2 FROM table_name;
SELECT first_name, last_name FROM customer;

/* -- select distinct = query uniques
retrieve distinct rating types from db -- */

SELECT DISTINCT col_name1 FROM table_name;
SELECT DISTINCT rating FROM film;

/* -- select count = returns numbers of input rows -- */

SELECT COUNT * FROM table_name;
SELECT COUNT(DISTINCT col_name1) FROM table_name;

/* -- select where = conditions on rows
comparison operators = {=,<,>,<=,>=,<> or !=}
combine with logical AND, OR, NOT
  -- */

SELECT col1, col2 FROM table_name
WHERE conditions;

/* -- query a customer email with name Nancy Thomas -- */

SELECT email FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

/* -- query describtion of a movie Oulat Hanky -- */

SELECT describtion FROM film
WHERE title = 'Outlaw Hanky';

/* -- query the phone np. from customer living in Dallas at 295 Epoh Drive -- */

SELECT phone_number FROM customer
WHERE customer_city = 'Dallas' AND customer_address = '295 Epoh Drive';

/* -- ORDER BY = asc by default 
LIMIT = always on the end -- */

SELECT col_name1, col_name2 FROM table_name
ORDER BY col_name1 ASC / DESC;

SELECT * from table_name
LIMIT 1;

/* -- query 5 shortest movies in database -- */

SELECT title,lenght from film
ORDER BY lenght
LIMIT 5;

/* -- query how many movies that are 50 mins or less -- */

SELECT COUNT(title) from film
WHERE lenght >= 50;

/* -- BETWEEN = "value >= AND value <= high", can combine with NOT operator,
!!! date format = YYYY-MM-DD, excludes last day (day starts on 0:00) -- */

SELECT * FROM payment
WHERE amount BETWEEN 8 AND 9;

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15 23:59:59';

/* -- IN = in range (list) -- */

SELECT color FROM table_name
WHERE color IN ('red', 'blue');

/* -- LIKE/ILIKE = uses wildcard operators: % = any sequence, _ = any single char
bot wildcards can be = 0
LIKE = case sensitive, ILIKE - not case sensitive -- */

SELECT * FROM customer
WHERE first_name LIKE 'J%';

SELECT * FROM customer
WHERE first_name LIKE '_her%';
