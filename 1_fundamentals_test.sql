/*  how many payment transactions were greater than $5.00  */

SELECT * FROM payment
LIMIT 1;

SELECT COUNT(amount) FROM payment
WHERE amount > 5.00;

/*  how many actors have a first name that starts with P  */

SELECT * FROM actor
LIMIT 1;

SELECT COUNT(*) FROM actor
WHERE first_name LIKE 'P%';

/*  how many unique districts are our customers from?  */

SELECT * FROM address
LIMIT 1;

SELECT COUNT(DISTINCT(district)) FROM address;

/*  retrieve the list of names for those distinct districts  */

SELECT DISTINCT(district) FROM address;

/*  how many films have a rating of R and a replacement cost between $5 and $15  */

SELECT * FROM film
LIMIT 1;

SELECT COUNT(title) FROM film
WHERE rating = 'R' AND replacement_cost BETWEEN 5.00 AND 15.00;

/*  how many films have a word Truman somewhere in the title  */

SELECT * FROM film
LIMIT 1;

SELECT COUNT(title) FROM film
WHERE title LIKE '%Truman%';