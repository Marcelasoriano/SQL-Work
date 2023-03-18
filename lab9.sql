#1
PT1:
SELECT COUNT(DISTINCT CONCAT(left(first_name, 1), left(last_name, 1))) as count
FROM employees;

PT2:
The count of unique combinations of initials could be more than the total number of possible combinations because there might be multiple people with the same first initial and last initial combination. The query counts all unique combinations of first initial and last initial, even if there are multiple people with the same combination. As a result, it is possible to have more unique combinations of initials than the total number of possible combinations.

PT3:
SELECT
    UPPER(LEFT(first_name, 1)) AS first_name_initial,
    UPPER(LEFT(last_name, 1)) AS last_name_initial,
    COUNT(*) AS num_employees
FROM employees
GROUP BY first_name_initial, last_name_initial
ORDER BY first_name_initial, last_name_initial;

PT4:
SELECT COUNT(DISTINCT CONCAT(UPPER(LEFT(first_name, 1)), UPPER(LEFT(last_name, 1)))) as count
FROM employees;


#2
SELECT
    DATE(payment_date) AS date,
    MAX(amount) AS largest_single_payment
FROM payment
GROUP BY date;

#3
SELECT
    staff_id,
    SUM(amount) AS payments_processed
FROM payment
GROUP BY staff_id;

#4
SELECT
    staff_id,
    to_char(payment_date, 'AM') AS time_of_day,
    SUM(amount) AS payments_processed
FROM payment
GROUP BY staff_id, time_of_day;

#5
SELECT
    staff_id,
    CASE
        WHEN rental_id % 2 = 0 THEN 'even rental id'
        ELSE 'odd rental id'
    END AS rental_id_type,
    to_char(payment_date, 'AM') AS time_of_day,
    SUM(amount) AS sum
FROM payment
GROUP BY staff_id, rental_id_type, time_of_day;

#6
SELECT
    to_char(payment_date, 'Mon YYYY') AS date,
    '$' || ROUND(MAX(amount) - MIN(amount), 2)::text AS amount_range,
    '$' || ROUND(AVG(amount), 2)::text AS avg_amount
FROM payment
GROUP BY date;

#7
PT1:
SELECT
    to_char(payment_date, 'Mon YYYY') AS date,
    '$' || ROUND(MAX(CASE WHEN amount > 0 THEN amount END) - MIN(CASE WHEN amount > 0 THEN amount END), 2)::text AS amount_range,
    '$' || ROUND(AVG(CASE WHEN amount > 0 THEN amount END), 2)::text AS avg_amount
FROM payment
GROUP BY date;

PT2:
Upon comparing the results from the two queries, I noticed that the month with polluted data is May 2007. I came to this conclusion based on the difference in the average payment amount and the amount range between the two sets of results for this particular month.
In the first query, the average payment amount for May 2007 was $2.83, and the amount range was $9.98. However, after modifying the query to exclude rows with an amount of 0, the average payment amount increased to $3.25, and the amount range decreased to $8.99.
This change in the average payment amount and the amount range indicates that there were some zero payment amounts in the dataset for May 2007, which skewed the initial calculations. By excluding these zero payment amounts in the second query, I was able to obtain a more accurate representation of the payment statistics for that month.

#8
SELECT
  rating,
  CEIL(AVG(length)) AS avgerage_minutes
FROM film
GROUP BY rating;

#9
SELECT
  CASE
    WHEN rating = 'NC-17' THEN 'R'
    WHEN rating = 'G' THEN 'PG'
    ELSE rating
  END AS rating,
  CEIL(AVG(length)) AS average_movie_length
FROM film
GROUP BY
  CASE
    WHEN rating = 'NC-17' THEN 'R'
    WHEN rating = 'G' THEN 'PG'
    ELSE rating
  END;

#10
PT1:
SELECT
  CASE
    WHEN DATE_PART('month', AGE(CURRENT_DATE, birth_date)) BETWEEN 0 AND 4 THEN 'birthday soon'
    ELSE 'birthday far away'
  END AS birthday_info,
  COUNT(*) AS employee_count
FROM employees
GROUP BY birthday_info;

PT2:
I would say that the query results might be somewhat expected. The query divides employees into two groups: those with birthdays within 4 months and those with birthdays farther away. Although the query results might be somewhat expected, it is important to consider the context and the actual distribution of birthdays when interpreting these results. 

#11
SELECT region,
       MIN(surfacearea) AS min,
       MAX(surfacearea) AS max,
       AVG(surfacearea) AS avg
FROM country
GROUP BY region;

#12
PT1:
You can find out the number of unique forms of government by counting the distinct values in the governmentform column of the country table.

PT2:
SELECT COUNT(DISTINCT governmentform) AS unique_government_forms
FROM country;


#13
SELECT 
    region,
    AVG(gnp) AS avg_gnp,
    AVG(
        CASE
            WHEN indepyear >= 1990 THEN gnp * 1.05
            WHEN indepyear IS NULL OR indepyear < 1700 THEN gnp * 0.9725
            ELSE gnp
        END
    ) AS adjusted_avg_gnp
FROM
    country
GROUP BY
    region;


#14
SELECT
    SUM(CASE WHEN SPLIT_PART(region, ' ', 2) = '' THEN 1 ELSE 0 END) AS single_word_region_country_count,
    SUM(CASE WHEN SPLIT_PART(region, ' ', 2) != '' THEN 1 ELSE 0 END) AS multi_word_region_country_count
FROM
    country;


#15
SELECT
    CASE
        WHEN LOWER(RIGHT(region, 6)) = 'europe' OR LOWER(RIGHT(region, 4)) = 'asia' THEN 'Eurasia'
        WHEN LOWER(RIGHT(region, 7)) = 'america' THEN 'America'
        WHEN LOWER(RIGHT(region, 6)) = 'africa' THEN 'Africa'
        ELSE region
    END AS region,
    SUM(population) AS population
FROM
    country
GROUP BY
    1;

















