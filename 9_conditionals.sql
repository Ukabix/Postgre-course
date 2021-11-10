/* CASE - used to execute SQL code only when certain conditions are met, similar to if/else
 general case syntax - more flexible: */
CASE
    WHEN cond1 THEN result1
    WHEN cond2 THEN result2
    ELSE other_result
END;
/**/
SELECT a,
    CASE
        WHEN a = 1 THEN 'one'
        WHEN a = 2 THEN 'two'
        ELSE 'other' AS label
    END
FROM test_table;
/* case expression syntax:
 first evaluates an expression then compares the result with each value in the WHEN clauses sequentially 
 */
CASE
    expression
    WHEN val1 THEN result1
    WHEN val2 THEN result2
    ELSE other_result
END;
/**/
SELECT a,
    CASE
        a
        WHEN 1 THEN 'one'
        WHEN 2 THEN 'two'
        ELSE 'other'
    END
FROM test;
/* examples: set tiers for customers based on first ones to use our service
1-100 premium, 101-200 plus */
SELECT customer_id,
    CASE
        WHEN (customer_id <= 100) THEN 'Premium'
        WHEN (customer_id BETWEEN 101 and 200) THEN 'Plus'
        ELSE 'Normal'
    END AS customer_rank
FROM customer;
/* award customer 2 and 5 with prize with case expression */
SELECT customer_id,
    CASE customer_id
        WHEN 2 THEN 'Prize'
        WHEN 5 THEN 'Prize'
        ELSE 'Normal'
    END AS customer_winners
FROM customer;
/* make categories for rental rates - very useful method! */
SELECT
    SUM (CASE rental_rate
        WHEN 0.99 THEN 1
        ELSE 0
    END) AS bargains,
    SUM (CASE rental_rate
        WHEN 2.99 THEN 1
        ELSE 0
    END) AS regular,
    SUM (CASE rental_rate
        WHEN 4.99 THEN 1
        ELSE 0
    END) AS premium
FROM film;
/* challenge - compare various amounts of films we have per movie rating */
SELECT
    SUM (CASE rating
        WHEN 'R' THEN 1
        ELSE 0
    END) AS R,
	 SUM (CASE rating
        WHEN 'NC-17' THEN 1
        ELSE 0
    END) AS NC17,
     SUM (CASE rating
        WHEN 'G' THEN 1
        ELSE 0
    END) AS G,
	 SUM (CASE rating
        WHEN 'PG' THEN 1
        ELSE 0
    END) AS PG,
	 SUM (CASE rating
        WHEN 'PG-13' THEN 1
        ELSE 0
    END) AS PG13
FROM film;
/**/
/* COALESCE - accepts args and returns first argument that !=NULL,
if all args == NULL => returns NULL */
COALESCE (arg_1,arg_2,...,arg_n);
COALESCE (1,2); /* returns 1 */
COALESCE (NULL,2,3); /* returns 2*/
/* common example - what is the dissscount price for a table of 3 products name/price/discount: A/B/B, 100/300/200, 20/NULL/10 */
SELECT item, (price-discount) AS final FROM table; /* returns null for B */
SELECT item, price - COALESCE(discount,0)) AS final FROM table; /* returns 300 for B */
/**/
/* CAST - converts one datatype into another,
not every data type can be cast to another */
/* CAST function */
SELECT CAST('5' AS INTEGER);
/* CAST operator - only postgre? */
SELECT '5'::INTEGER;
/* usually using in a select query, examples */
SELECT CAST(date AS TIMESTAMP) FROM table;
SELECT CAST('5' AS INTEGER) AS new_int;
SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR)) FROM rental;
/*  */
/* NULLIF takes 2 inputand  returns NULL if both are equal, otherwise returns first arg passed */
NULLIF(arg1,arg2);
NULLIF(10,10); /* return NULL */
NULLIF(10,12); /* return 10 */
/*  */
/*  */
/*  */
/*  */
/*  */