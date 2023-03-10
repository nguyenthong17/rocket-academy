-- Thing learned: CONSTRAINTS

-- -PRIMARY KEY = UNIQUE KEY + NOT NULL (together)
-- -UNIQUE KEY
-- -NOT NULL: cannot be empty
-- -CHECK: check the condition for a particular value
-- -DEFAULT: set the default value
-- FOREIGN KEY: 


DROP DATABASE IF EXISTS lesson_02;
CREATE DATABASE lesson_02;
USE lesson_02;

-- create table department
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    department_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) UNIQUE NOT NULL CHECK(LENGTH(department_name) >=4)
);

-- create table position
DROP TABLE IF EXISTS `position`;
CREATE TABLE IF NOT EXISTS `position` (
    position_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM('Dev', 'Test', 'Scrum Master', 'PM') UNIQUE KEY NOT NULL
);

-- create table account
DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
    account_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE KEY NOT NULL,
    username VARCHAR(50) UNIQUE KEY NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    department_id TINYINT UNSIGNED,
    position_id TINYINT UNSIGNED,
    created_date DATETIME DEFAULT NOW(),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (position_id) REFERENCES `position`(position_id)
);

-- create table group
DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group` (
    group_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) UNIQUE KEY NOT NULL,
    creator_id TINYINT UNSIGNED NOT NULL,
    created_date DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (creator_id) REFERENCES `account`(account_id)
);

-- create table group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE IF NOT EXISTS group_account (
    group_id TINYINT UNSIGNED,
    account_id TINYINT UNSIGNED,
    joined_date DATETIME NOT NULL,
    PRIMARY KEY(group_id, account_id),
    FOREIGN KEY(group_id) REFERENCES `group`(group_id),
    FOREIGN KEY(account_id) REFERENCES `account`(account_id)
);
-- create table type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE IF NOT EXISTS type_question (
    type_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('Essay', 'Multiple-Choice') UNIQUE KEY NOT NULL
);

-- create table category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE IF NOT EXISTS category_question (
    category_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE KEY NOT NULL
);

-- create table question
DROP TABLE IF EXISTS question;
CREATE TABLE IF NOT EXISTS question (
    question_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(255) UNIQUE KEY NOT NULL,
    category_id TINYINT UNSIGNED NOT NULL,
    type_id TINYINT UNSIGNED NOT NULL,
    creator_id TINYINT UNSIGNED NOT NULL,
    created_date DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY(category_id) REFERENCES category_question(category_id),
    FOREIGN KEY(type_id) REFERENCES type_question(type_id),
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);

-- create table answer
DROP TABLE IF EXISTS answer;
CREATE TABLE IF NOT EXISTS answer (
    answer_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(255),
    question_id TINYINT UNSIGNED,
    is_correct BIT NOT NULL,
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);

-- create table exam
DROP TABLE IF EXISTS exam;
CREATE TABLE IF NOT EXISTS exam (
    exam_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `code` CHAR(10) UNIQUE NOT NULL,
    title VARCHAR(50) NOT NULL,
    category_id TINYINT UNSIGNED NOT NULL,
    duration TINYINT UNSIGNED NOT NULL,
    creator_id TINYINT UNSIGNED NOT NULL,
    created_date DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY(category_id) REFERENCES category_question(category_id),
    FOREIGN KEY(creator_id) REFERENCES `account`(account_id)
);

-- create table exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE IF NOT EXISTS exam_question (
    exam_id TINYINT UNSIGNED,
    question_id TINYINT UNSIGNED,
    PRIMARY KEY(exam_id, question_id),
    FOREIGN KEY(exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);

-- ------------ Insert data into table -------------------
-- Th??m d??? li???u v??o b???ng department
INSERT INTO department  (department_name)
VALUES                  ('Marketing'    ),
                        ('Sale'         ),
                        ('B???o v???'       ),
                        ('Nh??n s???'      ),
                        ('K??? thu???t'     ),
                        ('T??i ch??nh'    ),
                        ('Ph?? gi??m ?????c' ),
                        ('Gi??m ?????c'     ),
                        ('Th?? k??'       ),
                        ('B??n h??ng'     ); 

-- Th??m d??? li???u v??o b???ng position
INSERT INTO `position`  (position_name    )
VALUES                  ('Dev'      ),
                        ('Test'         ),
                        ('Scrum Master'   ),
                        ('PM');

-- Th??m d??? li???u v??o b???ng account
INSERT INTO `account`   (email                           , username      , full_name           , department_id, position_id, created_date)
VALUES                  ('haidang29productions@gmail.com', 'dangblack'   , 'Nguyen Hai Dang'   , 5            , 1          , '2020-03-05'),
                        ('account1@gmail.com'            , 'quanganh'    , 'Tong Quang Anh'    , 1            , 2          , '2020-03-05'),
                        ('account2@gmail.com'            , 'vanchien'    , 'Nguyen Van Chien'  , 2            , 3          , '2020-03-07'),
                        ('account3@gmail.com'            , 'cocoduongqua', 'Duong Do'          , 3            , 4          , '2020-03-08'),
                        ('account4@gmail.com'            , 'doccocaubai' , 'Nguyen Chien Thang', 4            , 4          , '2020-03-10'),
                        ('dapphatchetngay@gmail.com'     , 'khabanh'     , 'Ngo Ba Kha'        , 6            , 3          , '2020-04-05'),
                        ('songcodaoly@gmail.com'         , 'huanhoahong' , 'Bui Xuan Huan'     , 7            , 2          , '2020-04-05'),
                        ('sontungmtp@gmail.com'          , 'tungnui'     , 'Nguyen Thanh Tung' , 8            , 1          , '2020-04-07'),
                        ('duongghuu@gmail.com'           , 'duongghuu'   , 'Duong Van Huu'     , 9            , 2          , '2020-04-07'),
                        ('vtiaccademy@gmail.com'         , 'vtiaccademy' , 'Vi Ti Ai'          , 10           , 1          , '2020-04-09');

-- Th??m d??? li???u v??o b???ng group
INSERT INTO `group` (group_name         , creator_id, created_date)
VALUES              ('Testing System'   , 5         , '2019-03-05'),
                    ('Developement'     , 1         , '2020-03-07'),
                    ('VTI Sale 01'      , 2         , '2020-03-09'),
                    ('VTI Sale 02'      , 3         , '2020-03-10'),
                    ('VTI Sale 03'      , 4         , '2020-03-28'),
                    ('VTI Creator'      , 6         , '2020-04-06'),
                    ('VTI Marketing 01' , 7         , '2020-04-07'),
                    ('Management'       , 8         , '2020-04-08'),
                    ('Chat with love'   , 9         , '2020-04-09'),
                    ('Vi Ti Ai'         , 10        , '2020-04-10');

-- Th??m d??? li???u v??o b???ng group_account
INSERT INTO group_account   (group_id, account_id, joined_date )
VALUES                      (1       , 1         , '2019-03-05'),
                            (2       , 2         , '2020-03-07'),
                            (3       , 3         , '2020-03-09'),
                            (4       , 4         , '2020-03-10'),
                            (5       , 5         , '2020-03-28'),
                            (6       , 6         , '2020-04-06'),
                            (7       , 7         , '2020-04-07'),
                            (8       , 8         , '2020-04-08'),
                            (9       , 9         , '2020-04-09'),
                            (10      , 10        , '2020-04-10');

-- Th??m d??? li???u v??o b???ng type_question
INSERT INTO type_question (type_name) VALUES ('Essay'), ('Multiple-Choice'); 

-- Th??m d??? li???u v??o b???ng category_question
INSERT INTO category_question   (category_name)
VALUES                          ('Java'       ),
                                ('ASP.NET'    ),
                                ('ADO.NET'    ),
                                ('SQL'        ),
                                ('Postman'    ),
                                ('Ruby'       ),
                                ('Python'     ),
                                ('C++'        ),
                                ('C Sharp'    ),
                                ('PHP'        ); 

-- Th??m d??? li???u v??o b???ng question
INSERT INTO question    (content          , category_id, type_id, creator_id, created_date)
VALUES                  ('C??u h???i v??? Java', 1          , 1      , 1         , '2020-04-05'),
						('C??u h???i v??? Java', 1          , 1      , 1         , '2020-04-05'),
						('C??u h???i v??? Java', 1          , 1      , 1         , '2020-04-05'),
                        ('C??u H???i v??? PHP' , 10         , 2      , 2         , '2020-04-05'),
                        ('H???i v??? C#'      , 9          , 2      , 3         , '2020-04-06'),
                        ('H???i v??? Ruby'    , 6          , 1      , 4         , '2020-04-06'),
                        ('H???i v??? Postman' , 5          , 1      , 5         , '2020-04-06'),
                        ('H???i v??? ADO.NET' , 3          , 2      , 6         , '2020-04-06'),
                        ('H???i v??? ASP.NET' , 2          , 1      , 7         , '2020-04-06'),
                        ('H???i v??? C++'     , 8          , 1      , 8         , '2020-04-07'),
                        ('H???i v??? SQL'     , 4          , 2      , 9         , '2020-04-07'),
                        ('H???i v??? Python'  , 7          , 1      , 10        , '2020-04-07');

-- Th??m d??? li???u v??o b???ng answer
INSERT INTO answer  (content     , question_id, is_correct)
VALUES              ('Tr??? l???i 01', 1          , 0         ),
                    ('Tr??? l???i 02', 1          , 1         ),
                    ('Tr??? l???i 03', 1          , 0         ),
                    ('Tr??? l???i 04', 1          , 1         ),
                    ('Tr??? l???i 05', 2          , 1         ),
                    ('Tr??? l???i 06', 3          , 1         ),
                    ('Tr??? l???i 07', 4          , 0         ),
                    ('Tr??? l???i 08', 8          , 0         ),
                    ('Tr??? l???i 09', 9          , 1         ),
                    ('Tr??? l???i 10', 10         , 1         );

-- Th??m d??? li???u v??o b???ng exam
INSERT INTO exam    (`code`   , title           , category_id, duration, creator_id, created_date)
VALUES              ('VTIQ001', '????? thi C#'     , 1          , 60      , 5         , '2019-04-05'),
                    ('VTIQ002', '????? thi PHP'    , 10         , 60      , 1         , '2019-04-05'),
                    ('VTIQ003', '????? thi C++'    , 9          , 120     , 2         , '2019-04-07'),
                    ('VTIQ004', '????? thi Java'   , 6          , 60      , 3         , '2020-04-08'),
                    ('VTIQ005', '????? thi Ruby'   , 5          , 120     , 4         , '2020-04-10'),
                    ('VTIQ006', '????? thi Postman', 3          , 60      , 6         , '2020-04-05'),
                    ('VTIQ007', '????? thi SQL'    , 2          , 60      , 7         , '2020-04-05'),
                    ('VTIQ008', '????? thi Python' , 8          , 60      , 8         , '2020-04-07'),
                    ('VTIQ009', '????? thi ADO.NET', 4          , 90      , 9         , '2020-04-07'),
                    ('VTIQ010', '????? thi ASP.NET', 7          , 90      , 10        , '2020-04-08');

-- Th??m d??? li???u v??o b???ng exam_question
INSERT INTO exam_question   (question_id, exam_id)
VALUES                      (1          , 1      ),
                            (2          , 2      ),
                            (3          , 3      ),
                            (4          , 4      ),
                            (5          , 5      ),
                            (6          , 6      ),
                            (7          , 7      ),
                            (8          , 8      ),
                            (9          , 9      ),
                            (10         , 10     );
