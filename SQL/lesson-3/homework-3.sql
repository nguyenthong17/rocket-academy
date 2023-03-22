USE testing_system_02;

-- Question 2
SELECT * FROM department;

-- Question 3
SELECT department_id FROM department
WHERE department_name = 'Sale';

-- Question 4
SELECT * FROM `account`
WHERE LENGTH(full_name) = (
	SELECT MAX(LENGTH(full_name)) 
    FROM `account`
);

-- Question 5
SELECT * FROM `account`
WHERE LENGTH(full_name) = (
	SELECT MAX(LENGTH(full_name)) 
    FROM `account`
    WHERE department_id = 3
) AND department_id = 3;

-- Question 6
SELECT * FROM `group`
WHERE created_date < '2019-12-20';

-- Question 8
SELECT * FROM exam
WHERE duration > 60 AND created_date < '2019-12-20';

-- Question 11
SELECT * FROM `account`
WHERE full_name LIKE 'D%o';

SELECT * FROM `account`
WHERE SUBSTRING_INDEX(full_name, ' ',-1) LIKE 'D%o';

-- Question 12
DELETE
FROM exam
WHERE created_date < '2019-12-20';

-- Question 13
DELETE
FROM question
WHERE SUBSTRING_INDEX(content, ' ',2) = 'Câu hỏi';

-- Question 15
UPDATE `group_account`
SET group_id = 4
WHERE account_id = 5;
