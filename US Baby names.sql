# US Name Dataset: 1910 to August 2022

# Preview table
SELECT * 
FROM `bigquery-public-data.usa_names.usa_1910_current`;

# All names in the dataset
SELECT DISTINCT name 
FROM bigquery-public-data.usa_names.usa_1910_current;

# Number of names
SELECT COUNT ( DISTINCT name ) AS Number_of_names 
FROM bigquery-public-data.usa_names.usa_1910_current;

# Number of boy names
SELECT COUNT(DISTINCT name)
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'M';

# Number of girl names
SELECT COUNT(DISTINCT name) 
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'F';

# Popular names overall
SELECT name, 
  SUM(number) AS num_names
FROM bigquery-public-data.usa_names.usa_1910_current
GROUP BY name
ORDER BY num_names DESC
LIMIT 50;

# Popular boy names
SELECT name, 
  SUM(number) AS num_names
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'M'
GROUP BY name
ORDER BY num_names DESC
LIMIT 20;

# Popular girl names
SELECT name, 
  SUM(number) AS num_names
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'F'
GROUP BY name
ORDER BY num_names DESC
LIMIT 20;

# Popular name by state
SELECT state, name
from (SELECT state, name, COUNT(*) as cnt,
             ROW_NUMBER() OVER (PARTITION BY state ORDER BY COUNT(*) DESC) AS seqnum
     FROM bigquery-public-data.usa_names.usa_1910_current
     GROUP BY state, name
    ) yn
WHERE seqnum = 1;

#The above version returns one arbitrary name if there are ties for the most frequent. 
#If you do want ties, use rank() instead of row_number().

# Popular girl names 1990
SELECT name, 
  SUM(number) AS num_names
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'F'AND year = 1990
GROUP BY name
ORDER BY num_names DESC
LIMIT 10;

# Popular boy names 1990
SELECT name, 
  SUM(number) AS num_names
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'M' AND year = 1990
GROUP BY name
ORDER BY num_names DESC
LIMIT 10;

# Popular girl names 2020
SELECT name, 
  SUM(number) AS num_names
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'F'AND year = 2020
GROUP BY name
ORDER BY num_names DESC
LIMIT 10;

# Popular boy names 2020
SELECT name, 
  SUM(number) AS num_names
FROM bigquery-public-data.usa_names.usa_1910_current
WHERE gender = 'M' AND year = 2020
GROUP BY name
ORDER BY num_names DESC
LIMIT 10;

# Popular boy name each year
SELECT year, name
FROM (SELECT year, name, COUNT(*) as cnt,
             ROW_NUMBER() OVER (PARTITION BY year ORDER BY COUNT(*) DESC) AS seqnum
     FROM bigquery-public-data.usa_names.usa_1910_current
     WHERE gender = 'M'
     GROUP BY year, name
     ORDER BY year
    ) yn
WHERE seqnum = 1;

# Popular girl name each year
SELECT year, name
FROM (SELECT year, name, COUNT(*) as cnt,
             ROW_NUMBER() OVER (PARTITION BY year ORDER BY COUNT(*) DESC) AS seqnum
     FROM bigquery-public-data.usa_names.usa_1910_current
     WHERE gender = 'F'
     GROUP BY year, name
     ORDER BY year
    ) yn
WHERE seqnum = 1;

