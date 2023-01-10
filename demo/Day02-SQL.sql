--Table nasıl oluşturulur?
--1. Yol: Sıfırdan table oluşturma:
CREATE TABLE students
(
    student_id SMALLINT,
    student_name VARCHAR(50),
    student_age SMALLINT,
    student_dob DATE
);
--2.Yol: Başka bir table kullanarak table oluşturma:
CREATE TABLE student_name_age
AS SELECT student_name, student_age
FROM students;
SELECT * FROM students;
SELECT * FROM student_name_age;
--Table oluştururken bazı "Constraints" atamaları yapabiliriz.
--Constraints:
--a)Unique
--b)Not Null
--c)Primary Key
--d)Foreign Key
--e)Check Constraint
--Primary Key oluşturmak için iki yol kullanırız:
--1.Yol:
CREATE TABLE students
(
    student_id SMALLINT PRIMARY KEY,--student_id tekrar eden data alamaz, null değer alamaz çünkü Primary Key ataması yaptık.
    student_name VARCHAR(50) NOT NULL,--student_name null değer alamaz
    student_age SMALLINT,
    student_dob DATE UNIQUE--student_id unique key ==> null değerden başka değerler tekrarsız olmalıdır. Çoklu null değer atanabilir.
);
--2.Yol:
CREATE TABLE students
(
    student_id SMALLINT,
    student_name VARCHAR(50),
    student_age SMALLINT,
    student_dob DATE,
    CONSTRAINT student_id_pk PRIMARY KEY(student_id)
);
--Foreign Key Constraint nasıl eklenir:
CREATE TABLE parents
(
    student_id SMALLINT,
    parent_name VARCHAR(50),
    phone_number CHAR(10),
    CONSTRAINT student_id_pk PRIMARY KEY(student_id)
);
CREATE TABLE students
(
    student_id SMALLINT,
    student_name VARCHAR(50),
    student_age SMALLINT,
    student_dob DATE,
    CONSTRAINT student_id_fk1 FOREIGN KEY(student_id) REFERENCES parents(student_id)
);
--"Check" constraint nasıl eklenir:
CREATE TABLE students
(
    student_id SMALLINT,
    student_name VARCHAR(50),
    student_age SMALLINT,
    student_dob DATE,
    CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 30),
    CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))
);
--Table'a veri nasıl girilir:
CREATE TABLE students
(
    student_id SMALLINT PRIMARY KEY,
    student_name VARCHAR(50) UNIQUE,
    student_age SMALLINT NOT NULL,
    student_dob DATE,
    CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 30),-- 0 ve 30 dahil
    CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))
);
--1.Yol: Tüm sütunlara veri girme:
INSERT INTO students VALUES('101', 'ALI CAN', 13, '10-Aug-2021');
INSERT INTO students VALUES('102', 'VELI HAN', 14, '10-Aug-2007');
--Integer değerler single quotes ile veya yalın kullanılabilir.
INSERT INTO students VALUES(103, 'AYSE TAN', 14, '08-Aug-2007');
INSERT INTO students VALUES(104, 'KEMAL KUZU', 15, null);
--VARCHAR, single quote ile kullanılmak zorundadır.
INSERT INTO students VALUES('105', 'TOM HANKS', 25, '12-Sep-1996');
INSERT INTO students VALUES('106', 'ANGELINA JULIE', 30, '12-Sep-1986');
INSERT INTO students VALUES('107', 'BRAD PITT', 0, '10-Aug-2021');
--2.Yol: Spesifik bir sütuna veri nasıl girilir:
c
INSERT INTO students(student_name, student_id, student_age) VALUES('JOHN WALKER', '109', 24);
--Varolan bir data nasıl değiştirilir:
UPDATE students
SET student_name = 'LEO OCEAN'
WHERE student_id = '108';
--John Walker, dob sütununu to 11-Dec-1997 değerine değiştirin.
UPDATE students
SET student_dob = '11-Dec-1997'
WHERE student_id = '109';
--Çok hücre(cell) nasıl değiştirilir:
--105 id'li dob hücresini 11-Apr-1996 değerine ve name hücresini  TOM HANKS değerine güncelle.
UPDATE students
SET student_dob = '11-Apr-1996',
    student_name = 'TOM HANKS'
WHERE student_id = '105';
--Çoklu satır(records) nasıl gücellenir:
--id'si 106 'dan küçük tüm dob değerlerini 01-Aug-2021'e güncelle.
UPDATE students
SET student_dob = '01-Aug-2021'
WHERE student_id < 106;
--Tüm age değerlerini en yüksek age değerine güncelle.
UPDATE students
SET student_age = (SELECT MAX(student_age) FROM students);
--Tüm dob değerlerini minimum dob değerine güncelle.
UPDATE students
SET student_dob = (SELECT MIN(student_dob) FROM students);
SELECT * FROM students