USE testing_system_02;
-- SUBQUERY
-- to return a value or a table
-- when retern a value, it can be used with other operators
-- when return a table, we can use with the following operators
-- IN
SELECT *
FROM department
WHERE department_id IN (SELECT department_id FROM department);

-- ALL
SELECT *
FROM department
WHERE department_id >= ALL (SELECT department_id FROM department);

-- EXISTS
-- return true if subquery has result
-- return false if subquery has no result
SELECT *
FROM department
WHERE EXISTS (SELECT 1);

-- Question 4
SELECT * FROM `account`
WHERE CHAR_LENGTH(full_name) = (SELECT MAX(CHAR_LENGTH(full_name)) FROM `account`);

-- Question 5
SELECT * FROM `account`
WHERE CHAR_LENGTH(full_name) = (
			SELECT MAX(CHAR_LENGTH(full_name)) FROM `account` where department_id = 3
            ) 
            AND department_id = 3;

-- VIEW: virtual table - not create new table in DB
CREATE OR REPLACE VIEW view_01 AS 
SELECT * FROM department;

SELECT * FROM view_01;

-- CTE: Common Table Expression
SELECT question.*
FROM answer
JOIN question USING (question_id)
GROUP BY question_id
HAVING COUNT(answer_id) = 
	(SELECT MAX(total_answers)
    FROM (	SELECT COUNT(answer_id) AS total_answers
			FROM answer
            GROUP BY question_id) AS t1);
            
-- with CTE
WITH cte_01 AS (
	SELECT question.content, COUNT(answer_id) AS total_answers
	FROM answer
    JOIN question USING (question_id)
	GROUP BY question_id
)
SELECT * 
FROM cte_01 
WHERE total_answers = 
	( SELECT MAX(total_answers)
	FROM cte_01);
