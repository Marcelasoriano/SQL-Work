#1 You need to pick a data type that can hold a bank account balance. Which type do you choose and why?
The numeric data type provides exact numeric calculations with precision and scale, making it a good choice for storing financial data.

#2 You need to pick a data type that can hold a phone number. Which type do you choose and why?
"varchar" because it allows you to store phone numbers, including with or without country/area codes, and other separators.

#3 Name 1 similarity and 1 difference between the NUMERIC type and the FLOAT type.
NUMERIC and FLOAT are both used to represent numbers with decimal points. However,
NUMERIC stores exact decimal values while FLOAT stores approximate values with a fixed number of bytes.

#4 You need to store blog posts in a database and must choose a data type to hold the text for each post.
Colleague A says to use CHAR(10000)
Colleague B says to use TEXT
Colleague C says to use VARCHAR(99999)
Which colleague do you agree with and why? What is the second best decision and why?
I agree with Colleague B.
I recommend using the TEXT data type to store the blog post text in the PostgreSQL database. This data type is designed to store large strings of text with no fixed length limit, making it ideal for storing blog posts. It is also more "flexible" than the CHAR and VARCHAR data types, which have fixed length limits that may not be enough for long blog posts.

#5 Connect to the dvdrental database.
Which columns on the film table hold "numeric" types? What do these columns have have in common?
rental_rate and replacement_cost
All columns have a specific type and nullability 

#6 Write a query that returns 3 columns
Column 1: first name
Column 2: last name
Column 3: First letter of the first name, last letter of the first name, a dot, first letter of the last name, last letter of the last name. All Caps, labeled as name.
Limit results to 10
SELECT 
    first_name, 
    last_name, 
    CONCAT(
        UPPER(LEFT(first_name, 1)),
        UPPER(RIGHT(first_name, 1)),
        '.',
        UPPER(LEFT(last_name, 1)),
        UPPER(RIGHT(last_name, 1))
    ) AS name
FROM 
    employees
LIMIT 10;


#7 Write a query that returns 4 columns.
Column 1: Employee number
Column 2: Birth date
Column 3: hired date
Column 4: The age (in years) when that employee was hired, labeled as hired_at_age
LIMIT Results to 10
SELECT emp_no, birth_date, hire_date, EXTRACT(YEAR FROM AGE(hire_date, birth_date)) AS hired_at_age
FROM employees
LIMIT 10;



#8 Write a query that returns 2 columns.
Column 1: first name
Column 2: first half of the first name. If there are an odd number of characters in the name: round up.
Limit results to 10
SELECT first_name,
    SUBSTRING(first_name, 1, CEILING(LENGTH(first_name)/2.0)::integer) AS first_name_first_half
FROM employees
LIMIT 10;



#9 Write a query that returns 4 columns.
Column 1: employee number
Column 2: "last name,first name" labeled as "full_name"
Column 3: Hire date
Column 4: True/False value indicating whether or not the employee has worked for the company for more than 30 years, labeled as over_30. Assume all employees are still working at the company. 
SELECT emp_no, CONCAT(last_name, ', ', first_name) AS full_name, hire_date,
    (DATE_TRUNC('year', NOW()) - DATE_TRUNC('year', hire_date) >= INTERVAL '30 years') AS over_30
FROM employees
LIMIT 50;


#10 Write a query that returns 3 columns
Column 1: employee number
Column 2: birth date
Column 3: birth_info column that formats the birthday as text: "born Y:YEAR, M:MONTH, D:DAY"
SELECT emp_no, birth_date,
    CONCAT('born Y:', EXTRACT(YEAR FROM birth_date), ', M:', EXTRACT(MONTH FROM birth_date), ', D:', EXTRACT(DAY FROM birth_date)) AS birth_info
FROM employees;


#11 Write a query that returns 4 columns.
Column 1: Employee number
Column 2: birth date
Column 3: hire date
Column 4: True/False value indicating whether or not the employee was hired in the same month as their birth day, labeled as hired_in_birth_month.
Limit results to 100.
SELECT emp_no, birth_date, hire_date,
    (DATE_PART('month', hire_date) = DATE_PART('month', birth_date)) AS hired_in_birth_month
FROM employees
LIMIT 100;

#12 Management throws a party once a month to celebrate employees who have been at the company for more than 5 years. If an employee is hired September 1990, they should be celebrated the following month 5 years into the future (October 1995). The VP of HR needs a report indicating when every employee should be recognized for 5 years of working.
Write a query that returns 3 columns
Column 1: employee number
Column 2: hire date
Column 3: Month and year the employee should be recognized labeled as five_year_party. This column must be formatted as Month YEAR. Example: "July 2021"
SELECT emp_no, hire_date, to_char(DATE_TRUNC('month', hire_date + INTERVAL '5 years' + INTERVAL '1 month'), 'Month YYYY') AS five_year_party
FROM employees;









