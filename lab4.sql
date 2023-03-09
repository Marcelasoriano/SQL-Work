# 1. What is the difference between CONCAT and || 
CONCAT takes two or more arguments and concatenates them into a single string.
With CONCAT any NULL values are treated as empty strings, so they don't affect the output of the concatenation. 
|| only takes two arguments and concatenates them.
With ||, if either operand is NULL, the entire result is NULL.

# 2. Write a query that returns employee first name and last name (2 columns) with all capital letters.
SELECT
    UPPER(first_name) AS "first name",
    UPPER(last_name) AS "last name"
FROM 
    employees;

# 3. Write a query that returns employees' full name (1 column) with a space separator. Label the column "Full name".
# Example: "Ben Franklin"
SELECT
    first_name || ' ' || last_name AS "Full name"
FROM 
    employees;

# 4. Write a query that returns 2 colums:
# column 1: Employee number 
# column 2: Number of characters in employee last name, labeled as "Last name length"
SELECT 
    emp_no AS "Employee number", 
    LENGTH(last_name) AS "Last name length" 
FROM 
    employees;


# 5. Write a query that returns 1 column. The text in this 1 column should include the first letter of the employee's first name, followed by a ".", followed by their last name. Label the column "Short name".
# Example: "B.Franklin"
SELECT 
    CONCAT(UPPER(SUBSTR(first_name,1,1)), '.', last_name) AS "Short name" 
FROM 
    employees;

# 6. Write a query that returns 2 columns
# Column 1: Employee first name but only the first 2 characters
# Column 2: Employee last name
# Example: "Be"    "Franklin":
SELECT 
    SUBSTR(first_name,1,2) AS "first name", 
    last_name AS "last name"
FROM 
    employees;

# 7.Write a query that returns the first word in the title column of the title table.
SELECT 
    SUBSTRING(title FROM 1 FOR POSITION(' ' IN title)) AS "first word"
FROM 
    titles;

# 8. Write a query that returns 2 columns
# column 1: first name 
# column 2: last name but with total characters not exceeding the number of characters in the first name
# Example: "Ben"  "Fra"
# Explanation: The last name was cut short to 3 characters because the first name only has 3 character.
SELECT 
  first_name AS "first name", 
  SUBSTRING(last_name FROM 1 FOR LENGTH(first_name)) AS "last name" 
FROM 
  employees;

# 9. Write a query that returns 2 columns
# Column 1: first word in department name
# Column 2: second word in department name
# Example: "Customer"   "Service"
SELECT 
  SPLIT_PART(dept_name, ' ', 1) AS "first word",
  SPLIT_PART(dept_name, ' ', 2) AS "second word"
FROM 
  departments;
