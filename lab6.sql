1)
SELECT 
   AVG(CASE WHEN gender = 'M' THEN FLOOR((EXTRACT(YEAR FROM AGE(hire_date, birth_date)))) END) AS men_avg_age_at_hire,
   AVG(CASE WHEN gender = 'F' THEN FLOOR((EXTRACT(YEAR FROM AGE(hire_date, birth_date)))) END) AS women_avg_age_at_hire
FROM employees
WHERE gender IN ('M', 'F');

2)
SELECT 
   COUNT(CASE WHEN EXTRACT(QUARTER FROM birth_date) = 1 THEN 1 END) AS q1_count,
   COUNT(CASE WHEN EXTRACT(QUARTER FROM birth_date) = 2 THEN 1 END) AS q2_count,
   COUNT(CASE WHEN EXTRACT(QUARTER FROM birth_date) = 3 THEN 1 END) AS q3_count,
   COUNT(CASE WHEN EXTRACT(QUARTER FROM birth_date) = 4 THEN 1 END) AS q4_count
FROM employees;

3) 
SELECT 
   title,
   from_date,
   to_date,
   COALESCE(
       title || ' from ' || to_char(from_date, 'Mon DD, YYYY') || ' to ' || 
           COALESCE(NULLIF(CASE 
               WHEN to_date = '9999-01-01' THEN 'present' 
               ELSE to_char(to_date, 'Mon DD, YYYY') END, ''), 'present')
           ) AS description
FROM titles
LIMIT 50;


4)
SELECT
  COUNT(CASE WHEN LENGTH(last_name) > LENGTH(first_name) THEN 1 END) AS lastname_longer_count,
  COUNT(CASE WHEN LENGTH(last_name) < LENGTH(first_name) THEN 1 END) AS lastname_shorter_count,
  COUNT(CASE WHEN LENGTH(last_name) = LENGTH(first_name) THEN 1 END) AS lastname_equal_count
FROM employees;

5)
SELECT 
  SUM(salary) AS current_salary_even_total
FROM 
  salaries
WHERE 
  to_date = '9999-01-01' 
  AND emp_no % 2 = 0;

6)
PT1: 
SELECT 
  MAX(LENGTH(first_name)) AS max_first_name_length 
FROM 
  employees;

PT2:
SELECT 
  COUNT(*) AS tied_for_longest_first_name_count 
FROM 
  employees
WHERE 
  LENGTH(first_name) = 14;

7)
SELECT 
first_name, 
birth_date, 
length(trim(to_char(birth_date, 'Month'))) AS month_char_count
FROM employees
LIMIT 50;

8)
SELECT COUNT(*) AS count
FROM employees
WHERE lower(substring(first_name from 3 for 1)) = lower(substring(last_name from 3 for 1));

9)
SELECT dept_no,
       COALESCE(NULLIF(dept_name, 'Human Resources'), 'HR') AS dept_name
FROM departments;

10)
SELECT dept_no,
  CASE dept_name
    WHEN 'Customer Service' THEN 'CX'
    WHEN 'Development' THEN 'Engineering'
    ELSE dept_name
  END AS dept_name
FROM departments;

11)
PT1:
SELECT
  ROUND(AVG(lifeexpectancy)::NUMERIC, 2) AS life_expectancy,
  ROUND(AVG(COALESCE(lifeexpectancy, 50))::NUMERIC, 2) AS life_expectancy_all
FROM
  country;

PT2:
SELECT
  COUNT(CASE WHEN lifeexpectancy IS NULL THEN 1 END) AS missing_stat_count,
  COUNT(CASE WHEN lifeexpectancy IS NOT NULL THEN 1 END) AS has_stat_count
FROM
  country;

12)
SELECT COUNT(*) AS count
FROM employees
WHERE LOWER(first_name) = LOWER(REVERSE(first_name));

13)
SELECT 
    AVG(
        CASE 
            WHEN return_date IS NOT NULL THEN return_date - rental_date
            ELSE NULL
        END
    ) AS avg_duration
FROM rental;







