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
