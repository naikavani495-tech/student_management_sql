CREATE DATABASE student_management;
USE student_management;
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY
KEY,
    name VARCHAR(50),
    age INT,
    email VARCHAR(100)
);
INSERT INTO students (name, age, email)
VALUES
('Avani', 20, 'avani@gmail.com'),
('Rahul', 22, 'rahul@gmail.com'),
('Priya', 21, 'priya@gmail.com');
CREATE TABLE courses (
	course_id INT AUTO_INCREMENT PRIMARY
KEY,
    course_name VARCHAR(100),
    duration_months int
);
INSERT INTO courses (course_name,
duration_months) VALUES
('SQL Basics', 3),
('Python', 6),
('Web Development', 5);
CREATE TABLE enrollments (
    enroll_id INT AUTO_INCREMENT PRIMARY
KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES
students(student_id),
    FOREIGN KEY (course_id) REFERENCES
courses(course_id)
);
INSERT INTO enrollments (student_id,
course_id) VALUES
(1,1),
(2,2),
(3,3),
(1,2);
SELECT
   students.name,
   courses.course_name
FROM enrollments
JOIN students ON enrollments.student_id = 
students.student_id
JOIN courses ON enrollments.course_id = 
courses.course_id;
SELECT * FROM students
WHERE age > 20;
SELECT * FROM students
WHERE name = 'Avani';
SELECT * FROM courses
WHERE duration_months >= 5;
SELECT
    students.name,
    courses.course_name
FROM enrollments
JOIN students ON enrollments.student_id =
students.student_id
JOIN courses ON enrollments.course_id =
courses.course_id
WHERE students.name = 'Avani';
UPDATE students
SET age = 21
WHERE name = 'Avani';
SELECT * FROM students;
UPDATE courses
SET duration_months = 4
WHERE course_id = 1;
SELECT * FROM courses;
SELECT * FROM students
WHERE age > 20 AND name = 'Avani';
SELECT * FROM students
WHERE name = 'Avani' OR name = 'Rahul';
SELECT * FROM students
WHERE name LIKE 'A%';
SELECT * FROM students
WHERE name LIKE '%a';
SELECT * FROM students
ORDER BY age ASC;
SELECT * FROM students
ORDER BY age DESC;
SELECT * FROM students
WHERE age >= 20 AND name LIKE 'A%'
ORDER BY age DESC;
SELECT COUNT(*) AS total_students
FROM students;
SELECT COUNT(*) AS total_enrollments
FROM enrollments;
SELECT AVG(age) AS avg_age
FROM students;
SELECT
	courses.course_name,
    COUNT(enrollments.student_id) AS
total_students
FROM enrollments
JOIN courses ON enrollments.course_id = 
courses.course_id
GROUP BY courses.course_name;
SELECT
    courses.course_name,
    COUNT(enrollments.student_id) AS
total_students
FROM enrollments
JOIN courses ON enrollments.course_id = 
courses.course_id
GROUP BY courses.course_name
ORDER BY total_students DESC;
SELECT
   courses.course_name,
   COUNT(enrollments.student_id) AS
total_students
FROM enrollments
JOIN courses ON enrollments.course_id =
courses.course_id
GROUP BY courses.course_name
HAVING total_students > 1;
SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = (
        SELECT course_id
        FROM courses
        WHERE course_name = 'Python'
	)
);
SELECT name
FROM students
WHERE student_id NOT IN (
    SELECT student_id FROM enrollments
);
SELECT *
FROM courses
WHERE duration_months = (
    SELECT MAX(duration_months) FROM
courses
);
SELECT *
FROM students
WHERE age > (
   SELECT AVG(age) FROM students
);
SELECT
    students.name,
    COUNT(enrollments.course_id) AS
total_courses
FROM students
LEFT JOIN enrollments
ON students.student_id =
enrollments.student_id
GROUP BY students.name;
SELECT
    courses.course_name,
    COUNT(enrollments.student_id) AS
total_students
FROM enrollments
JOIN courses ON enrollments.course_id = 
courses.course_id
GROUP BY courses.course_name
ORDER BY total_students DESC
LIMIT 1;
SELECT
    students.name,
    COUNT(enrollments.course_id) AS
total_courses
FROM students
JOIN enrollments
ON students.student_id =
enrollments.student_id
GROUP BY students.name
HAVING total_courses > 1;
CREATE VIEW student_courses AS 
SELECT
	students.name,
    courses.course_name
FROM enrollments
JOIN students
ON enrollments.student_id =
students.student_id
JOIN courses
ON enrollments.course_id =
courses.course_id;
SELECT * FROM student_courses;
SELECT * FROM student_courses
WHERE name = 'Avani';
CREATE VIEW course_popularity AS
SELECT
     courses.course_name,
     COUNT(enrollments.student_id) AS
total_students
FROM enrollments
JOIN courses
ON enrollments.course_id =
courses.course_id
GROUP BY courses.course_name;
SELECT * FROM course_popularity;
SELECT
    students.name,
    COUNT(enrollments.course_id) AS
total_courses
FROM students
LEFT JOIN enrollments
ON students.student_id =
enrollments.student_id
GROUP BY students.name
ORDER BY total_courses DESC
LIMIT 1;
SELECT
     courses.course_name,
     COUNT(enrollments.student_id) AS
total_students
FROM courses
LEFT JOIN enrollments
ON courses.course_id =
enrollments.course_id
GROUP BY courses.course_name
ORDER BY total_students ASC
LIMIT 1;
SELECT
    AVG(total_courses) AS avg_courses
FROM (
   SELECT
       students.student_id,
       COUNT(enrollments.course_id) AS
	total_courses
        FROM students
        LEFT JOIN enrollments
        ON students.student_id =
	enrollments.student_id
         GROUP BY students.student_id
	) AS subquery;
   SELECT
       students.name,
       COUNT(enrollments.course_id) AS
	total_courses
    FROM students
    JOIN enrollments
    ON students.student_id =
    enrollments.student_id
    GROUP BY students.name
    HAVING total_courses > 1;
    
