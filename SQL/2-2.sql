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


/* query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
If more than one hacker received full scores in same number of challenges, 
then sort them by ascending hacker_id */
SELECT S.HACKER_ID, H.NAME
FROM SUBMISSIONS S
INNER JOIN CHALLENGES C ON S.CHALLENGE_ID = C.CHALLENGE_ID
INNER JOIN HACKERS H ON S.HACKER_ID = H.HACKER_ID
INNER JOIN DIFFICULTY D ON C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL 
WHERE S.SCORE=D.SCORE -- who achieved "full scores" for more than one challenge
GROUP BY S.HACKER_ID, H.NAME -- to identify more than 1 same data/row based on grouped col 
HAVING COUNT(*) > 1 --  query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge
ORDER BY COUNT(*) DESC, S.HACKER_ID -- descending order by the total number of challenges

-- ----------------------------------------------

/* If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project. */

-- expl. to find whether the project is consecutive or not, it's needed to figure out if the date in End_Date is also in Start_Date

-- hint. another way to join multiple table implicitly without keyword 'join' is to use subquery in which can be applied after various statement of sql parts. i.e 'from/where/having/select/...'
SELECT START_DATE, MIN(END_DATE)
FROM 
    -- LIT. '1ST' START_DATE WON'T EXIST IN END_DATE, THEN THE COMPLETION DAYS WILL BE THE LAST DAY IF NOT EXIST IN START_DATE 
    (SELECT START_DATE FROM PROJECTS WHERE START_DATE NOT IN (
        SELECT END_DATE FROM PROJECTS
    )) SD,
    (SELECT END_DATE FROM PROJECTS WHERE END_DATE NOT IN (
        SELECT START_DATE FROM PROJECTS
    )) ED
WHERE START_DATE < END_DATE
GROUP BY START_DATE
-- DATEDIFF() function is used to calculate the number of days
ORDER BY DATEDIFF(DAY, START_DATE, MIN(END_DATE)) ASC, START_DATE ASC;