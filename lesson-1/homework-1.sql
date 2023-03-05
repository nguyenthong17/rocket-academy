DROP DATABASE lesson_01;

-- create new database
CREATE DATABASE lesson_01;

-- use database collection
USE lesson_01;

-- create table 'department'
CREATE TABLE department (
	department_id TINYINT UNSIGNED,
    department_name VARCHAR(50)
);

-- create table 'position'
CREATE TABLE `position`(
	position_id TINYINT UNSIGNED,
    position_name ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

-- create table 'account'
CREATE TABLE `account` (
	account_id INT UNSIGNED,
    email VARCHAR(200),
    username VARCHAR(100),
    fullname VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
	FOREIGN KEY (position_id) REFERENCES `position`(position_id),
    create_date DATE
);

-- create table 'group'
CREATE TABLE `group` (
	group_id TINYINT UNSIGNED,
    group_name VARCHAR(100),
    FOREIGN KEY (creator_id) REFERENCES `account`(account_id) ,
    create_date DATE
);

-- create table 'group-account'
CREATE TABLE `group-account` (
	FOREIGN KEY (group_id) REFERENCES `group`(group_id),
    FOREIGN KEY (account_id) REFERENCES `account`(account_id),
    join_date DATE
);

-- create table 'type-question'
CREATE TABLE type_question (
	type_id TINYINT UNSIGNED,
    type_name ENUM('essay', 'multiple-choice')
);

-- create table 'category-question'
CREATE TABLE category_question (
	category_id TINYINT UNSIGNED,
    category_name VARCHAR(50)
);

-- create table 'question'
CREATE TABLE question (
	question_id INT UNSIGNED,
    content VARCHAR(1000),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (type_id) REFERENCES type_question(type_id),
    FOREIGN KEY (creator_id) REFERENCES `account`(account_id),
    create_date DATE
);

-- create table 'answer'
CREATE TABLE answer (
	answer_id INT UNSIGNED,
    content VARCHAR(1000),
    FOREIGN KEY (question_id) REFERENCES question(question_id),
    is_correct BOOLEAN
);

-- create table 'exam'
CREATE TABLE exam (
	exam_id TINYINT UNSIGNED,
    `code` TINYINT UNSIGNED,
    title VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES category_question(category_id),
    duration TINYINT UNSIGNED,
    FOREIGN KEY (creator_id) REFERENCES `account`(account_id),
    create_date DATE
);

-- create table 'exam_question'
CREATE TABLE exam_question(
	FOREIGN KEY (exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY (question_id) REFERENCES quesion(question_id)
);

