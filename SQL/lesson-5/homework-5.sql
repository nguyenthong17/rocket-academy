USE testing_system_02;
-- Question 1
CREATE OR REPLACE VIEW question_01 AS 
	SELECT *
	FROM `account`
	JOIN department dept USING (department_id) 
	WHERE dept.department_name = 'Sale';
    
-- Question 2
CREATE OR REPLACE VIEW question_02 AS
WITH group_count AS (
SELECT `account`.*, COUNT(group_id) AS group_counts
FROM `group_account`
JOIN `account` USING (account_id)
GROUP BY account_id
)
SELECT * 
FROM group_count
WHERE group_counts = 
	(SELECT MAX(group_counts)
	FROM group_count);
    
-- Question 3
CREATE OR REPLACE VIEW question_03 AS
	SELECT *
	FROM question
	WHERE CHAR_LENGTH(content) >= 300;

WITH long_question AS (
	SELECT question_id FROM question_03
)
DELETE 
FROM question
WHERE question_id IN (SELECT * FROM long_question);


-- Question 4
CREATE OR REPLACE VIEW question_04 AS
SELECT dept.department_name, COUNT(account_id) AS account_count
FROM `account`
JOIN department dept USING (department_id)
GROUP BY department_id;

-- Question 5
CREATE OR REPLACE VIEW question_05 AS 
WITH nguyen_list AS (
SELECT *
FROM `account`
WHERE SUBSTRING_INDEX(full_name,' ', 1) = 'Nguyen'
)
SELECT question.question_id, question.content, `account`.full_name AS creator
FROM question
JOIN `account` ON question.creator_id = account_id
WHERE question.creator_id IN (SELECT account_id FROM nguyen_list)
 

