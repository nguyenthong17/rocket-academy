USE testing_system_02;

-- Quesiton 1
SELECT `account`.*, department.department_name
FROM `account`
INNER JOIN department
ON `account`.department_id = department.department_id;

-- Question 2
SELECT *
FROM `account`
WHERE created_date > '2010-12-20';

-- Question 3
SELECT acc.*, pos.position_name
FROM `account` acc
INNER JOIN `position` pos
ON acc.position_id = pos.position_id
WHERE pos.position_name = 'DEVELOPER';

-- Question 4
SELECT dept.department_name, COUNT(dept.department_name) AS num_account
FROM `account` acc
INNER JOIN department dept 
ON acc.department_id = dept.department_id
GROUP BY dept.department_name
HAVING num_account > 3