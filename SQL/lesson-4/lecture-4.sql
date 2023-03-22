-- JOIN: Join 

DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management;
USE student_management;

DROP TABLE IF EXISTS boy;
CREATE TABLE boy (
    id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS girl;
CREATE TABLE girl (
    id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

INSERT INTO boy (id, `name` )
VALUES          (1 , 'Khoa' ),
                (2 , 'Duy'  ),
                (3 , 'Hùng' ),
                (4 , 'Cường'),
                (6 , 'Linh' );

INSERT INTO girl (id, `name`    )
VALUES           (1 , 'Thương'  ),
                 (2 , 'Ngọc Anh'),
                 (5 , 'Trang'   ),
                 (6 , 'Linh'    );

-- JOIN

-- RIGHT/ LEFT JOIN
SELECT * FROM boy
LEFT JOIN girl USING (id);

SELECT * FROM boy
RIGHT JOIN girl USING (id);

-- LEFT EXCLUDING
SELECT * FROM boy
LEFT JOIN girl USING (id)
WHERE girl.id IS NULL;

-- CROSS JOIN
SELECT * FROM boy
CROSS JOIN girl;

-- UNION
SELECT id, `name` FROM boy;
SELECT id, `name` FROM girl;

SELECT id, `name` FROM boy
UNION
SELECT id,`name` FROM girl;

-- UNION ALL
SELECT id, `name` FROM boy
UNION ALL
SELECT id,`name` FROM girl;

-- UNION ALL
SELECT id, `name` FROM boy

SELECT id,`name` FROM girl;