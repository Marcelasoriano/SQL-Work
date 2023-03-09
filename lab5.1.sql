1) 
SELECT 
    salary,
    CAST(FLOOR(salary * 0.1) AS integer) AS ten_percent
FROM 
    salaries
LIMIT 20;


2) 
SELECT 
    salary, 
    CAST(SUBSTR(salary::TEXT, 1, 1) AS INTEGER) * CAST(RIGHT(salary::TEXT, 1) AS INTEGER) AS salary_product 
FROM 
    salaries
LIMIT 50;

3) ?
SELECT 
    birth_date,
    DATE_TRUNC('year', NOW()) + (birth_date - DATE_TRUNC('year', birth_date)) <= NOW() + INTERVAL '6 months' AS birthday_soon 
FROM 
    employees 
LIMIT 25;



4) 
SELECT birth_date, 
    EXTRACT(YEAR FROM birth_date) * EXTRACT(MONTH FROM birth_date) * EXTRACT(DAY FROM birth_date) AS birthday_product
FROM employees
LIMIT 50;

5) 
SELECT SUBSTR(CAST(NOW() AS TEXT), 12, 18) AS current_time;

6) 
SELECT hire_date,
    CASE WHEN EXTRACT(DOW FROM hire_date) = 2 THEN true ELSE false END AS hired_on_a_tuesday
FROM employees
LIMIT 50;

7)
SELECT 
    rental_date,
    return_date,
    AGE(return_date, rental_date) AS rental_interval,
    CASE 
        -- round up if hours >= 12, round down otherwise
        WHEN EXTRACT(HOUR FROM AGE(return_date, rental_date)) >= 12 
            THEN CONCAT('rented for ', ROUND(EXTRACT(DAY FROM AGE(return_date, rental_date)))::INT + 1, ' days')
        ELSE CONCAT('rented for ', ROUND(EXTRACT(DAY FROM AGE(return_date, rental_date)))::INT, ' days')
    END AS rental_time_description
FROM rental
LIMIT 25;

8)
SELECT rental_date,
       CASE WHEN EXTRACT(HOUR FROM rental_date) < 12 THEN 'AM rental' ELSE 'PM rental' END AS rental_type
FROM rental
LIMIT 25;

9)
SELECT 
    title,
    from_date,
    to_date,
    CONCAT(title, ' from ', to_char(from_date, 'Mon DD, YYYY'), ' to ',
    CASE WHEN to_date = '9999-01-01' THEN 'present' ELSE to_char(to_date, 'Mon DD, YYYY') END) AS description
FROM 
    employees 
    JOIN titles ON employees.emp_no = titles.emp_no
LIMIT 50;

10)
SELECT 
    first_name, 
    last_name, 
    CASE 
        WHEN LENGTH(first_name) > LENGTH(last_name) THEN 'first_name_larger' 
        WHEN LENGTH(first_name) < LENGTH(last_name) THEN 'last_name_larger'
        ELSE 'equal' 
    END AS name_char_count_desc
FROM employees
LIMIT 100;

11) 
SELECT 
    birth_date, 
    CASE 
        WHEN EXTRACT(YEAR FROM birth_date)::INT % 2 = 1 THEN EXTRACT(YEAR FROM birth_date)::INT * EXTRACT(MONTH FROM birth_date)::INT * EXTRACT(DAY FROM birth_date)::INT 
        ELSE EXTRACT(YEAR FROM birth_date)::INT + EXTRACT(MONTH FROM birth_date)::INT + EXTRACT(DAY FROM birth_date)::INT 
    END AS birthday_math
FROM employees
LIMIT 50;

12)
SELECT 
    SUM(salary) AS current_salary_odd_total
FROM 
    salaries
WHERE 
    to_date = '9999-01-01' 
    AND emp_no % 2 = 1;


13)
SELECT
    SUM(CASE WHEN EXTRACT(HOUR FROM payment_date) < 12 THEN amount ELSE 0 END) AS am_sum,
    COUNT(CASE WHEN EXTRACT(HOUR FROM payment_date) < 12 THEN 1 ELSE NULL END) AS am_count,
    SUM(CASE WHEN EXTRACT(HOUR FROM payment_date) >= 12 THEN amount ELSE 0 END) AS pm_sum,
    COUNT(CASE WHEN EXTRACT(HOUR FROM payment_date) >= 12 THEN 1 ELSE NULL END) AS pm_count,
    SUM(amount) AS total_sum,
    COUNT(*) AS total_count
FROM
    payment;

By manually comparing the calculated values with the actual payment amounts and counts for those time periods, the payment recordsare filtered based on the hour of the payment date column and then adding up the payment amounts and counts for each time period. 
If the calculated values match the values in columns 1 through 4, it means the query is calculating the sums and counts correctly.



