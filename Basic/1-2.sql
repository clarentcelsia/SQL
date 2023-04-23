/* SCHEMA SQL */
DROP TABLE IF EXISTS OCCUPATIONS_TB;

CREATE TABLE OCCUPATIONS_TB (
  	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	NAME VARCHAR(50),
	OCCUPATION VARCHAR(50)
);

INSERT INTO OCCUPATIONS_TB (
  NAME,OCCUPATION
) VALUES (
  'JOE CARRY',
  'DOCTOR'
), (
  'ADAM LEVINE',
  'SINGER'
), (
  'GERALD',
  'SINGER'
), (
  'LUMINE',
  'PSYCHIATRIST'
);

/* QUERY */
SELECT * FROM OCCUPATIONS_TB;

/* Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). 
For example: AnActorName(A) */
SELECT NAME, CONCAT(NAME, '(', SUBSTRING(OCCUPATION,1,1),')') AS RESULT
FROM OCCUPATIONS_TB;

/* Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order.

HINT: GROUP BY is to arrange identical data into groups */
SELECT OCCUPATION, COUNT(OCCUPATION) AS COUNTS 
FROM OCCUPATIONS_TB 
GROUP BY OCCUPATION 
ORDER BY COUNTS ASC;

/* Bonus. HAVING CLAUSE
HAVING clause must always be followed by the GROUP BY,
when it can be used with 'Aggregate' func
*/
SELECT OCCUPATION, COUNT(OCCUPATION) AS COUNTS 
FROM OCCUPATIONS_TB 
GROUP BY OCCUPATION 
HAVING COUNT(OCCUPATION) > 1
ORDER BY COUNTS;

/* https://www.tutorialspoint.com/sql/sql-union-vs-union-all.htm */
SELECT CONCAT(NAME, '(', SUBSTRING(OCCUPATION,1,1),')') AS RESULT
FROM OCCUPATIONS_TB
UNION ALL
SELECT CONCAT('There are a total of ', COUNT(OCCUPATION), ' ', LOWER(OCCUPATION), (if (COUNT(OCCUPATION) > 1,'S','')))
FROM OCCUPATIONS_TB 
GROUP BY OCCUPATION;
