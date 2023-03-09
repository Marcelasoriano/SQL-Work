#1 Write a query that gets employee number, hire date, and last name (columns in that order), maximum of 30 rows.

SELECT
emp_no, hire_date, last_name 
FROM employees 
LIMIT 30;

#2 Fix this query:
#SELECT first_name, last_name, hire_date, FROM employees LIMIT 20;

SELECT
first_name, last_name, hire_date 
FROM employees 
LIMIT 20;

#3 Fix this query:
#SELECT first_name, last_name LIMIT 5 FROM employees;

SELECT
first_name, last_name
FROM employees
LIMIT 5;

#4 Fix this query:
#SELECT first_name FROM employee LIMIT 42;

SELECT
first_name
FROM employees
LIMIT 42;

#5 Fix this query:
#SELECT emp_no, salary_amount FROM salaries LIMIT 10;

SELECT 
emp_no, salary 
FROM salaries
LIMIT 10;

#6 Fix this query: 
$SELECT dept_no, name FROM departments;

SELECT
dept_no, dept_name
FROM departments;

#7 Write a query that gets all the departments. The query should return 2 columns: department number labeled as "NUMBER" and department name labeled as "NAME".

SELECT
dept_no AS "NUMBER", 
dept_name AS "NAME"
FROM departments;

#8 Your new coworker wrote this query and is very confused as to why it's not working. 
# Write a short explanation for what your coworker is doing wrong.
# SELECT emp_no, first_name, last_name, dept_no, dept_name FROM employees LIMIT 10;

SELECT
emp_no, first_name, last_name, 
dept_no, dept_name
FROM employees
LIMIT 10;

#The coworker is trying to extract data from the wrong place. "dept_no" and "dept_name" do not exist on the "employees" table, but rather in the "departments" table.

#9 Rewrite this broken query so it propery gets the first 10 rows from the employees table, showing employee number, first name, and last name:
#SeLeCt emp_num, first_name last_name fRoM employees lImIt 10;

SELECT
emp_no, first_name, last_name
FROM employees
LIMIT 10;

#10 Write a query that gets the first 25 employees from the employees table. Include all columns and rename the columns from snake case to camel case. For example: relabel 'emp_no' to 'empNo', relabel 'first_name' to 'firstName', etc.

SELECT
emp_no AS "empNo",
birth_date AS "birthDate",
first_name AS "firstName",
last_name AS "lastName",
gender AS "gender",
hire_date AS "hireDate"
FROM employees
LIMIT 25;

#11 Write a query that gets the first 4 titles from the titles table. Include all columns that are of type DATE and no other columns. Relabel columns from snake case to camel case.

SELECT
title,
from_date AS "fromDate",
to_date AS "toDate"
FROM titles
LIMIT 4;


#12 Write a query the gets the first 100 employee last names in the first column, and the text "FULL-TIME-EMPLOYEE" in a second column with the label "extra_column"

SELECT 
last_name, 
'FULL-TIME-EMPLOYEE' AS "extra_column"
FROM 
employees
LIMIT 100;







