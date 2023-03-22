-- Topic covered
-- 1) Query data

-- Order of execution
-- (8) SELECT ...
-- (1) FROM ...
-- (2) JOIN ...
-- (3) WHERE
-- (4) GROUP BY ...
-- (5) HAVING ...
-- (6) ORDER BY ...
-- (7) LIMIT ...

USE testing_system_02;

-- Query all data
SELECT *
FROM department;

-- Query with condition
SELECT *
FROM department
WHERE department_id > 5;

-- WHERE - AND / OR
SELECT *
FROM department
WHERE department_id != 5 AND department_id != 10;

SELECT *
FROM department
WHERE department_id = 5 AND department_id = 10;

-- WHERE - IN /NOT IN
SELECT * FROM department
WHERE department_id IN (1,3,5,7,9);

-- WHERE - BETWEEN ... AND ... (include =)
SELECT * FROM department 
WHERE department_id BETWEEN 5 AND 8;

-- WHERE - LIKE / NOT LIKE
-- in LIKE operator:
-- % - represents 0 or more characters
-- _ - represents 1 character
SELECT * FROM department 
WHERE department_name LIKE 'B%';

SELECT * FROM department 
WHERE department_name LIKE '_a%';

-- WHERE - IS NULL / IS NOT NULL - check if the vale is null/ not null
SELECT * FROM department 
WHERE department_name IS NULL;

-- DISTINCT: query distinct value
SELECT DISTINCT duration
FROM exam;

-- ORDER BY
-- ASC: from small to large (by default, when not specify whether ASC or DESC)
-- DESC: from large to small
SELECT * FROM exam
ORDER BY duration DESC;
-- ORDER BY duration DESC, exam_id ASC 
-- (Order by both criteria. e.g. 1st duration, 2nd exam_id)

-- AGGREGATE FUNCTIONS
-- COUNT()
SELECT COUNT(*)
FROM exam
WHERE duration = 60;

-- MAX, MIN
SELECT MAX(duration)
FROM exam;

-- AVG
SELECT AVG(duration)
FROM exam;

SELECT COUNT(*)
FROM `account`
WHERE department_id = 2;

-- GROUP BY (between WHERE and ORDER BY)
-- groups value together and then perform calculations with Aggregate functions
-- can apply to multiple columns
-- if want to use conditions in GROUP BY => use HAVING

SELECT duration, COUNT(exam_id)
FROM exam                   -- (1) Từ bảng đề thi -> 10 đề thi
WHERE duration < 100        -- (2) Lọc ra những đề thi có duration < 100 phút -> 8 đề thi
GROUP BY duration           -- (3) Chia 8 đề thi ra làm 2 nhóm: 60 phút - 6, 90 phút - 2
HAVING COUNT(exam_id) > 3;  -- (4) Lấy ra nhóm có số đề thi > 3: 60 phút - 6

-- Question 7
SELECT question_id, COUNT(answer_id) 
FROM answer
GROUP BY question_id
HAVING COUNT(question_id) >= 4;

-- LIMIT: limit the amount of results
SELECT *
FROM department
LIMIT 3;

-- Question 9
SELECT * FROM `group`
ORDER BY created_date DESC
LIMIT 5;

-- AS: Alias for column
SELECT COUNT(*) AS total_exam
FROM exam;

-- Update data
UPDATE department
SET department_name = 'Kinh Doanh'
WHERE department_id = 2;

-- Question 14
UPDATE `account`
SET full_name = 'Nguyen Ba Loc', email = 'loc.nguyenba@vti.com.vn'
WHERE account_id = 5;

-- Question 15
UPDATE `group_account`
SET group_id = 4
WHERE account_id = 5;

-- Delete data
-- Question 12
DELETE
FROM exam
WHERE created_date < '2019-12-20';

-- Question 13
SELECT SUBSTRING_INDEX(content, ' ',2) FROM question;
DELETE
FROM question
WHERE SUBSTRING_INDEX(content, ' ',2) = 'Câu hỏi'