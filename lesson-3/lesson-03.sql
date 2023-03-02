-- Topic covered
-- 1) Query data
--

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