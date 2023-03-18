#1
When a column is part of the GROUP BY clause, each unique combination of values in that column will be treated as a separate group. Within each group, the values in that column are treated as equivalent and have no relative distinction from one another.
However, when a column is wrapped in an AGGREGATE function, such as SUM or AVG, it is being used to perform a calculation across all the rows in the group. This means that the values in that column are no longer treated as individual distinct values, but rather as a single value that represents the group as a whole.
Using a column in the GROUP BY clause results in each distinct value in that column being treated as a separate group, while wrapping a column in an AGGREGATE function results in the values in that column being treated as a single value representing the entire group.

#2
SELECT DISTINCT region
FROM country
LIMIT 25;

#3
PT1:
SELECT DISTINCT region, continent
FROM country
LIMIT 25;

PT2:
 The reason why this query returns the same number of rows as the previous query is because both queries use the DISTINCT keyword to eliminate duplicates and return only the unique values. In the first query, we retrieve a unique list of regions, while in the second query, we retrieve a unique list of region and continent combinations. Since each region belongs to only one continent, there is a one-to-one relationship between the two queries, which results in the same number of rows in both cases.

#4
SELECT COUNT(DISTINCT governmentform) AS count
FROM country;

#5
SELECT 
    COUNT(CASE WHEN LOWER(governmentform) = 'republic' THEN 1 END) AS republic_count
FROM 
    country;


#6
PT1:
 The query written by the colleague is incorrect because it attempts to calculate the average life expectancy using the sum of all life expectancies divided by the total count of countries. This will not provide an accurate result, as it will not take into account the differences in the number of countries and their corresponding life expectancies. 
PT2:
The query generates a life expectancy that is too high because it is summing up the life expectancies of all countries and dividing it by the total count of countries, regardless of the population of those countries. Therefore, it assigns equal weight to each country, even though some countries have significantly larger populations than others, and this results in a skewed average that does not accurately reflect the true average life expectancy of the globe.
PT3:
SELECT SUM(lifeexpectancy * population) / SUM(population) AS average_life_expectancy
FROM country;

#7
SELECT continent, AVG(lifeexpectancy)
FROM country
WHERE lifeexpectancy IS NOT NULL OR continent = 'Antarctica'
GROUP BY continent;

#8
SELECT continent, AVG(COALESCE(lifeexpectancy, 50))
FROM country
GROUP BY continent;

#9
SELECT 
    CASE 
        WHEN LEFT(name, 1) IN ('A', 'E', 'I', 'O', 'U') THEN 'vowel'
        ELSE 'consonant'
    END AS starts_with_type,
    AVG(country.lifeexpectancy) AS avg_life_expectancy
FROM
    country
WHERE
    country.lifeexpectancy IS NOT NULL
GROUP BY
    starts_with_type;


#10
PT1:
SELECT 
    SUBSTRING(countrycode, 2, 1) AS country_code_middle_letter, 
    SUM(population) AS total_population, 
    COUNT(*) AS city_count
FROM 
    city
WHERE 
    population IS NOT NULL
GROUP BY 
    country_code_middle_letter;

PT2:
The query does not return 26 rows because it is not grouping the data by the 26 letters of the English alphabet. Instead, it groups the data by the second letter of the country code in the city table. This means that the number of rows returned by the query is based on the number of unique second letters that exist in the country codes of the cities in the database. As there are only 25 unique second letters in the city table, the query returns 25 rows instead of 26.


#11
SELECT 
    continent, 
    AVG(
        CASE 
            WHEN region ILIKE 'west%' THEN gnp * 1.03
            WHEN region ILIKE 'south%' THEN gnp * 1.04
            WHEN region ILIKE 'north%' THEN gnp * 1.02
            WHEN region ILIKE 'east%' THEN gnp * 1.01
            ELSE gnp 
        END
    ) AS average_gross_national_product
FROM 
    country
WHERE 
    gnp IS NOT NULL
GROUP BY 
    continent;


#12
PT1:
SELECT 
    customer_id, 
    SUM(amount) AS amount_paid, 
    COUNT(*) AS count_of_payments
FROM payment
GROUP BY customer_id
ORDER BY customer_id
LIMIT 7;

PT2:
This means that on average, customer 1 has paid roughly $3.80 per payment. This information can be useful for marketing purposes such as analyzing customer behavior and retention.

#13
PT1:
SELECT DATE_PART('hour', payment_date) AS hour, COUNT(*) AS count_of_payments, 
ROUND(SUM(amount)) AS total_payment_amount
FROM payment
GROUP BY hour;

PT2:
The number of rows returned by this query is not surprising as there are 24 hours in a day, and the query is aggregating data by hour. Therefore, the query is expected to return a row for each hour of the day.

#14
SELECT 
    CASE WHEN LENGTH(first_name) = LENGTH(last_name) THEN 'last-name-equal'
         WHEN LENGTH(first_name) < LENGTH(last_name) THEN 'last-name-longer'
         ELSE 'last-name-shorter' END AS name_type,
    COUNT(*) AS count
FROM actor
GROUP BY name_type;


#15
SELECT to_char(payment_date, 'Month YYYY') AS month,
       max(amount) AS largest_payment,
       min(amount) AS smallest_payment,
       round(avg(amount), 2) AS average_payment
FROM payment
GROUP BY month
ORDER BY month;


#16
PT1:
SELECT 
    DATE_PART('month', birth_date) AS birth_month,
    DATE_PART('quarter', birth_date) AS birth_quarter,
    COUNT(*) AS count_of_births
FROM employees
GROUP BY birth_month, birth_quarter;

PT2:
This query returns 12 rows because it is grouping the employee birth dates by month and quarter, resulting in a maximum of 12 unique combinations of month and quarter. For example, January is always in the first quarter, February is always in the first quarter, March is always in the first quarter, and so on. Therefore, there is no need to group by both month and quarter, as it would result in duplicate combinations. Instead, grouping by month and quarter separately will give us the total number of births for each unique combination of month and quarter, resulting in 12 rows.


#17
SELECT
    DATE_PART('year', birth_date) AS birth_year,
    CONCAT('q', DATE_PART('quarter', birth_date)) AS birth_quarter,
    COUNT(*) AS count_of_births
FROM employees
GROUP BY birth_year, birth_quarter;

#18
PT1:
As I add more and more columns to the GROUP BY clause, I expect the total number of rows returned by my query to decrease.
PT2:
This happens because the GROUP BY clause groups together rows that have the same values in the specified columns. When more columns are added to the GROUP BY clause, it creates more specific groupings, which results in fewer rows being returned.
