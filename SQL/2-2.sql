/* BST */
SELECT N, 
    CASE 
        WHEN P IS NULL THEN 'Root'
        WHEN (SELECT COUNT(*) FROM BST WHERE P=B.N) = 0 THEN 'Leaf'
    ELSE 'Inner'
    END
FROM BST as B
ORDER BY N

/*  query to print the company_code, founder name, 
total number of lead managers, total number of senior managers, 
total number of managers, and total number of employees. 
Order your output by ascending company_code */
SELECT C.COMPANY_CODE, C.FOUNDER,
    COUNT(DISTINCT LM.LEAD_MANAGER_CODE),
    COUNT(DISTINCT SM.SENIOR_MANAGER_CODE),
    COUNT(DISTINCT M.MANAGER_CODE), 
    COUNT(DISTINCT E.EMPLOYEE_CODE)
FROM EMPLOYEE E
INNER JOIN MANAGER M ON E.MANAGER_CODE = M.MANAGER_CODE
INNER JOIN SENIOR_MANAGER SM ON E.SENIOR_MANAGER_CODE = SM.SENIOR_MANAGER_CODE
INNER JOIN LEAD_MANAGER LM ON E.LEAD_MANAGER_CODE = LM.LEAD_MANAGER_CODE
INNER JOIN COMPANY C ON E.COMPANY_CODE = C.COMPANY_CODE
GROUP BY C.COMPANY_CODE, C.FOUNDER 
ORDER BY C.COMPANY_CODE

/* Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
The report must be in descending order by grade 
If there is more than one student with the same grade (8-10), 
order those particular students by their name alphabetically.
If the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
If there is more than one student with the same grade (1-7) assigned to them, 
order those particular students by their marks in ascending order.*/
SELECT
    CASE
        WHEN (G.GRADE) < 8 THEN NULL
        ELSE S.NAME
    END AS NAME,
G.GRADE AS GRADE, S.MARKS
FROM GRADES G
INNER JOIN STUDENTS S ON S.MARKS BETWEEN G.MIN_MARK AND G.MAX_MARK -- OR RIGHT JOIN
ORDER BY G.GRADE DESC, NAME
   