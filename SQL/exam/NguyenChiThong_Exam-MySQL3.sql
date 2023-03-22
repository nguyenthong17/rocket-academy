DROP DATABASE IF EXISTS sqlExam;
CREATE DATABASE IF NOT EXISTS sqlExam;

USE sqlExam;

-- Question 1:
DROP TABLE IF EXISTS Student;
CREATE TABLE IF NOT EXISTS Student(
	ID MEDIUMINT UNSIGNED PRIMARY KEY UNIQUE AUTO_INCREMENT,
    `Name` VARCHAR(50) NOT NULL,
    Age TINYINT UNSIGNED,
    Gender ENUM('Female','Male','Others')
);

DROP TABLE IF EXISTS `Subject`;
CREATE TABLE IF NOT EXISTS `Subject`(
	ID SMALLINT UNSIGNED PRIMARY KEY UNIQUE AUTO_INCREMENT,
    `Name` VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS StudentSubject;
CREATE TABLE IF NOT EXISTS StudentSubject(
	StudentID MEDIUMINT UNSIGNED NOT NULL,
    SubjectID SMALLINT UNSIGNED NOT NULL,
    Mark TINYINT UNSIGNED NOT NULL,
    `Date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (StudentID, SubjectID),
    FOREIGN KEY (StudentID)
		REFERENCES Student (ID),
     -- ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (SubjectID)
		REFERENCES Subject (ID)
       -- ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Student(ID, `Name`, Age, Gender)
	VALUES 	(1, 'Nguyen Van A', 19, 'Male'),
			(2, 'Dang Thi B', 18, 'Female'),
			(3, 'Truong Ngoc C', 20, 'Female');

INSERT INTO `Subject` (ID, `Name`)
	VALUES 	(1, 'Toan Cao cap'),
			(2, 'Lap trinh co ban'),
            (3, 'Phan tich du lieu'),
            (4, 'Quantum Physics');

INSERT INTO StudentSubject (StudentID, SubjectID, Mark,`Date`)
	VALUES 	(1,1,90,'2023-03-15'),
			(3,1,70,'2023-03-16'),
			(1,3,50,'2023-03-16'),
            (2,1,78,'2023-03-14'),
            (3,3,86,'2023-03-10'),
            (2,2,100,'2023-03-01');

-- Question 2:
-- a)Lấy tất cả các môn học không có bất kì điểm nào
SELECT * FROM `Subject`
WHERE ID NOT IN (SELECT SubjectID FROM StudentSubject GROUP BY SubjectID);
-- b) Lấy danh sách các môn học có ít nhất 2 điểm
SELECT * FROM `Subject`
WHERE ID IN (SELECT SubjectID FROM StudentSubject
GROUP BY SubjectID
HAVING COUNT(SubjectID) >= 2);

-- Question 3:
CREATE OR REPLACE VIEW StudentInfo AS
	SELECT 	ss.StudentID AS `Student ID`, 
			ss.SubjectID AS `Subject ID`, 
            st.`Name`, st.Age, 
            CASE 
				WHEN st.Gender = 'Male' THEN '0'
                WHEN st.Gender = 'Female' THEN '1'
                ELSE 'Unknown'
            END AS `Student Gender`,
            sbj.`Name` AS `Subject Name`,
            ss.Mark,
            ss.`Date`
    FROM StudentSubject ss
    JOIN Student st ON ss.StudentID = st.ID
    JOIN `Subject` sbj ON ss.SubjectId = sbj.ID;

-- Question 4a:
DROP TRIGGER IF EXISTS SubjectUpdateID;
DELIMITER $$
CREATE TRIGGER SubjectUpdateID
BEFORE UPDATE ON `Subject`
FOR EACH ROW
BEGIN
	UPDATE `StudentSubject`
    SET SubjectID = NEW.ID
    WHERE SubjectID = OLD.ID;
END $$
DELIMITER ;

-- Question 4b:
DROP TRIGGER IF EXISTS StudentDeleteID;
DELIMITER $$
CREATE TRIGGER StudentDeleteID
BEFORE DELETE ON `Student`
FOR EACH ROW
BEGIN
	DELETE
    FROM StudentSubject
    WHERE StudentID = OLD.ID;
END $$
DELIMITER ;

-- Question 5:
DROP PROCEDURE IF EXISTS StudentDelete;
DELIMITER $$
CREATE PROCEDURE StudentDelete (IN studentName VARCHAR(50))
BEGIN
	IF studentName = '*' THEN
		DELETE
        FROM Student;
    ELSE
		DELETE
		FROM Student
		WHERE `Name` = studentName;
	END IF;
END $$
DELIMITER ;