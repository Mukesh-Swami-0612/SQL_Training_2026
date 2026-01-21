/* ================================
   STUDENT MANAGEMENT DATABASE
   SQL Server (SSMS) Full Script
================================ */

CREATE DATABASE StudentDB;
GO

USE StudentDB;
GO

/* ===== 1) Students Table ===== */
CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    gender VARCHAR(10),
    dob DATE,
    department VARCHAR(50),
    address VARCHAR(200)
);
GO


/* ===== 2) Courses Table ===== */
CREATE TABLE Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    credits INT NOT NULL
);
GO


/* ===== 3) Teachers Table ===== */
CREATE TABLE Teachers (
    teacher_id INT IDENTITY(1,1) PRIMARY KEY,
    teacher_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    department VARCHAR(50)
);
GO


/* ===== 4) Enrollments Table (Student ↔ Course) ===== */
CREATE TABLE Enrollments (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT GETDATE(),

    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
GO


/* ===== 5) Marks Table ===== */
CREATE TABLE Marks (
    mark_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks INT CHECK (marks >= 0 AND marks <= 100),

    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
GO


/* ===== 6) Attendance Table ===== */
CREATE TABLE Attendance (
    attendance_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('Present', 'Absent')),

    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
GO


/* ===== 7) Course Assignment Table (Teacher ↔ Course) ===== */
CREATE TABLE Course_Assignment (
    assignment_id INT IDENTITY(1,1) PRIMARY KEY,
    teacher_id INT NOT NULL,
    course_id INT NOT NULL,

    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
GO


/* ================================
   SAMPLE DATA (Optional)
================================ */

/* Insert Students */
INSERT INTO Students (name, email, phone, gender, dob, department, address)
VALUES
('Mukesh Swami', 'mukesh@gmail.com', '9876543210', 'Male', '2003-06-12', 'CSE', 'Sirsa, Haryana'),
('Rachna Devi', 'rachna@gmail.com', '9123456780', 'Female', '2004-02-20', 'IT', 'Punjab'),
('Anish Sharma', 'anish@gmail.com', '9000000001', 'Male', '2003-01-10', 'CSE', 'Delhi'),
('Prashant Verma', 'prashant@gmail.com', '9000000002', 'Male', '2002-11-05', 'IT', 'Chandigarh');
GO


/* Insert Courses */
INSERT INTO Courses (course_name, course_code, credits)
VALUES
('Database Management System', 'DBMS101', 4),
('Java Programming', 'JAVA201', 3),
('Cloud Computing', 'CLOUD301', 4);
GO


/* Insert Teachers */
INSERT INTO Teachers (teacher_name, email, phone, department)
VALUES
('Rahul Kumar', 'rahul@gmail.com', '9991112223', 'CSE'),
('Neha Sharma', 'neha@gmail.com', '9991112224', 'IT');
GO


/* Insert Enrollments */
INSERT INTO Enrollments (student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(4, 3);
GO


/* Insert Marks */
INSERT INTO Marks (student_id, course_id, marks)
VALUES
(1, 1, 85),
(1, 2, 90),
(2, 2, 78),
(3, 1, 88),
(4, 3, 92);
GO


/* Insert Attendance */
INSERT INTO Attendance (student_id, course_id, attendance_date, status)
VALUES
(1, 1, '2026-01-20', 'Present'),
(1, 2, '2026-01-20', 'Absent'),
(2, 2, '2026-01-20', 'Present'),
(3, 1, '2026-01-20', 'Present'),
(4, 3, '2026-01-20', 'Absent');
GO


/* Assign Teachers to Courses */
INSERT INTO Course_Assignment (teacher_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 3);
GO


/* ================================
   DISPLAY DATA
================================ */
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Teachers;
SELECT * FROM Enrollments;
SELECT * FROM Marks;
SELECT * FROM Attendance;
SELECT * FROM Course_Assignment;
GO


SELECT 
fk.name AS ForeignKey,
tp.name AS ParentTable,
cp.name AS ParentColumn,
tr.name AS ReferencedTable,
cr.name AS ReferencedColumn
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id
INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id
INNER JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id;
GO




--CASE_1

SELECT
   student_id AS stud_id,
    phone AS stud_phone
FROM Students;


--CASE_2
SELECT
     * into tbl_student_backup from Students;    --create a new backup table


--CASE_4
SELECT * FROM dbo.Students FOR JSON AUTO;


--CASE_5
SELECT 10 + 400 AS RESULT;


--CASE_6
SELECT * FROM dbo.Students
WHERE department = 'CSE';

--CASE_7
SELECT *
FROM dbo.Attendance
WHERE status LIKE 'P%';

--CASE_8
SELECT * FROM 
dbo.MARKS
ORDER BY marks;

--CASE_9
SELECT * 
FROM dbo.Students
ORDER BY name ASC;

