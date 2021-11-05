/* Data types:
boolean
character (char, varchar, text)
numeric (int, float)
temporat (date, time,  ts, interval)
UUID (universally unique identifiers)
array (=list)
JSON
Hstore key-value pair (=dict)
Special types (net adresses, geometric data) */

/* PRIMARY AND FOREIGN KEYS
Primary key [PK] is a column or a group of columns used to identify a row uniquely in a table 
Foreign key is a field or group of fields in a table that uniquely identifies a row in another table, 
it is defined in a table that references to the PK of the other table
A table that contains FK = referencing table/child table
A table that FK refers to = referenced table/parent table */

/* CONSTRAINTS
Rules enforced on data columns in the table.
Used to prevent invalid data from being entered into the db
Column constraints = constrains the data ina a column to adhere to given conditions
Table constraints = same but for the table */

COLUMN:
NOT NULL
UNIQUE /* all values must be different */
PRIMARY KEY
FOREIGN KEY
CHECK /* given conditions */
EXCLUSION /* if any two rows on the specified column or expression
using the spec. operator - not all of those comparisons will return TRUE */

TABLE:
CHECK (cond)
REFERENCES /* data must exist in a column in another table */
UNIQUE (column_list) /* value stored in listed columns must be unique */
PRIMARY KEY (column_key) /* allows defining primary key that consists of multiple columns */


/* CREATE - full syntax */

CREATE TABLE table_name (
    column_name TYPE column_constraint,
    column_name TYPE column_constraint,
    table_constraint table_constraint
    ) INHERITS existing_table_name;

/* common simple syntax */
CREATE TABLE table_name (
    column_name TYPE column_constraint,
    column_name TYPE column_constraint,
    );

/* SERIAL datatype - 
object that autogenerates a sequence of ints,
often used for PK
! if a row is later removed, this data type will not adjust marking the fact that row was removed */

/* Examples */
CREATE TABLE players(
    player_id SERIAL PRIMARY KEY,
    age SMALLINT NOT NULL
    );

CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
);

/* INSERT - add rows to a table.
General syntax:*/
INSERT INTO table (col1,col2,...)
VALUES
    (val1, val2,...),
    (val1, val2,...), ... ;

/* Syntax when inserting values from another table */
INSERT INTO table (col1,col2,...)
SELECT col1,col2,...
FROM another_table
WHERE condition;

/* example */
INSERT INTO account(username,password,email,created_on)
VALUES
    ('Jose','pass','jose@mail.com',CURRENT_TIMESTAMP);

INSERT INTO job(job_name)
VALUES
    ('astronaut');

INSERT INTO job(job_name)
VALUES
    ('president');

INSERT INTO account_job(user_id,job_id,hire_date)
VALUES
    (1,1,CURRENT_TIMESTAMP);

/* UPDATE - allows changing of values of the columns in the table */
UPDATE table
SET
    column1 = val1,
    column2 = val2, ...
WHERE
    condition;

/* Example */
UPDATE account
SET
    last_login = CURRENT_TIMESTAMP
WHERE
    last_login IS NULL;

UPDATE account
SET
    last_login = CURRENT_TIMESTAMP

UPDATE account /* another column */
SET
    last_login = created_on;

/* use another table's valuess | update join */
UPDATE TableA
SET original_col = TableB.new_col
FROM TableB
WHERE tableA.id = TableB.id;

/* return affected rows */
UPDATE account
SET last_login = created_on
RETURNING account_id,last_login;

/* DELETE */
DELETE FROM table
WHERE row_id = 1;
/* based on presence in other tables */
DELETE FROM tableA
USING tableB
WHERE tableA.id = tableB.id;
/*delete all rows */
DELETE FROM table
RETURNING *;

/* ALTER - make changes to an existing table structure, i.e.:
add, drop, rename columns
change data type of column
set DEFAULT values for column
add CHECK constraints
rename table */
/* general syntax*/
ALTER TABLE table_name action;

ALTER TABLE table_name
ADD COLUMN new_col TYPE;

ALTER TABLE table_name
DROP COLUMN col_name;

ALTER TABLE table_name
ALTER COLUMN col_name
SET DEFAULT value; /*ADD, DROP, ADD CONSTRAINT NOT NULL etc.*/

/*examples */
CREATE TABLE information(
    info_id SERIAL PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    person VARCHAR(50) NOT NULL UNIQUE
);

ALTER TABLE information
RENAME TO new_info;

ALTER TABLE new_info
RENAME COLUMN person TO people;

ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL;

INSERT INTO new_info(title)
VALUES 
('something');

/* DROP - used to remove a column in a table (in postgre additionally indexes and constraints)
! it will not remove columns used in views, triggers or stored procedures without CASCADE */
/* general syntax */
ALTER TABLE table_name
DROP COLUMN col_name;

ALTER TABLE table_name
DROP COLUMN col_name CASCADE;
/*check for existence to avoid error */
ALTER TABLE table_name
DROP COLUMN IF EXISTS col_name;
/*drop multiple*/
ALTER TABLE table_name
DROP COLUMN col_one,
DROP COLUMN col_two;

/* examples */ 
ALTER TABLE new_info
DROP COLUMN people;

ALTER TABLE new_info
DROP COLUMN IF EXISTS people;

/* CHECK constraint - create more customized constraints that aadhere certain condition,
i.e. all inserted ints fall below certain value
general syntax */
CREATE TABLE example(
    ex_id SERIAL PRIMARY KEY,
    age SMALLINT CHECK (age>21),
    parent_age SMALLINT CHECK(
        parent_age>age)
);

/*examples*/
CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK (
        birthdate > '1900-01-01'),
	hire_date DATE CHECK (
        hire_date > birthdate),
	salary INTEGER CHECK (
        salary >0)
);

INSERT INTO employees(
	first_name,
	last_name,
	birthdate,
	hire_date,
	salary
)
VALUES (
	'John',
	'Carpenter',
	'1910-02-05',
	'2010-10-10',
	100	
);

