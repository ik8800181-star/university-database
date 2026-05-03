-- ============================================================
--  UNIVERSITY DATABASE MANAGEMENT SYSTEM
--  File        : views.sql
--  Description : Reusable Database Views (6 views)
--  Group       : 13  |  Ibrahim Khatak  &  Malik M. Sanaullah
--  Engine      : MySQL
-- ============================================================

-- Drop views if they already exist
DROP VIEW IF EXISTS vw_student_transcript;
DROP VIEW IF EXISTS vw_section_schedule;
DROP VIEW IF EXISTS vw_department_roster;
DROP VIEW IF EXISTS vw_student_majors;
DROP VIEW IF EXISTS vw_employee_benefits;
DROP VIEW IF EXISTS vw_course_enrollment_summary;


-- ─────────────────────────────────────────────────────────────
-- VIEW 1: Student Transcript
-- Shows every student's complete academic record —
-- course, credits, semester and grade earned.
-- Usage: SELECT * FROM vw_student_transcript WHERE student_id = '24P-0001';
-- ─────────────────────────────────────────────────────────────
CREATE VIEW vw_student_transcript AS
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name)  AS student_name,
    d.dept_name                              AS student_department,
    s.gpa                                    AS cumulative_gpa,
    c.course_id,
    c.course_title,
    c.credits,
    sm.semester_name,
    sm.academic_year,
    e.grade,
    e.enrollment_date
FROM ENROLLMENT e
JOIN STUDENT   s   ON e.student_id   = s.student_id
JOIN SECTION   sec ON e.section_id   = sec.section_id
JOIN COURSE    c   ON sec.course_id  = c.course_id
JOIN SEMESTER  sm  ON sec.semester_id = sm.semester_id
LEFT JOIN DEPARTMENT d ON s.dept_id  = d.dept_id
ORDER BY s.student_id, sm.academic_year, sm.semester_name;


-- ─────────────────────────────────────────────────────────────
-- VIEW 2: Full Section Schedule
-- Shows the complete timetable: course, instructor, room,
-- day, time and semester for every section.
-- Usage: SELECT * FROM vw_section_schedule WHERE semester_name = 'Fall';
-- ─────────────────────────────────────────────────────────────
CREATE VIEW vw_section_schedule AS
SELECT
    sec.section_id,
    c.course_id,
    c.course_title,
    c.credits,
    CONCAT(i.first_name, ' ', i.last_name)  AS instructor_name,
    i.email                                  AS instructor_email,
    sm.semester_name,
    sm.academic_year,
    ts.day_of_week,
    ts.start_time,
    ts.end_time,
    sec.location,
    sec.capacity
FROM SECTION   sec
JOIN COURSE    c   ON sec.course_id     = c.course_id
JOIN SEMESTER  sm  ON sec.semester_id   = sm.semester_id
LEFT JOIN INSTRUCTOR i  ON sec.instructor_id = i.instructor_id
LEFT JOIN TIME_SLOT  ts ON sec.time_slot_id  = ts.time_slot_id
ORDER BY sm.academic_year, sm.semester_name, ts.day_of_week, ts.start_time;


-- ─────────────────────────────────────────────────────────────
-- VIEW 3: Department Roster
-- Lists all students, instructors and employees per department.
-- Usage: SELECT * FROM vw_department_roster WHERE dept_name = 'Computer Science';
-- ─────────────────────────────────────────────────────────────
CREATE VIEW vw_department_roster AS
-- Students
SELECT
    d.dept_name,
    'Student'                               AS person_type,
    s.student_id                            AS person_id,
    CONCAT(s.first_name,' ',s.last_name)    AS full_name,
    s.email,
    NULL                                    AS role_or_gpa
FROM STUDENT s
JOIN DEPARTMENT d ON s.dept_id = d.dept_id

UNION ALL

-- Instructors
SELECT
    d.dept_name,
    'Instructor'                            AS person_type,
    i.instructor_id                         AS person_id,
    CONCAT(i.first_name,' ',i.last_name)    AS full_name,
    i.email,
    CONCAT('Salary: PKR ', i.salary)        AS role_or_gpa
FROM INSTRUCTOR i
JOIN DEPARTMENT d ON i.dept_id = d.dept_id

UNION ALL

-- Employees
SELECT
    d.dept_name,
    'Employee'                              AS person_type,
    e.employee_id                           AS person_id,
    CONCAT(e.first_name,' ',e.last_name)    AS full_name,
    e.email,
    e.role                                  AS role_or_gpa
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.dept_id = d.dept_id

ORDER BY dept_name, person_type, full_name;


-- ─────────────────────────────────────────────────────────────
-- VIEW 4: Student Majors and Minors
-- Shows declared majors/minors with department details.
-- Usage: SELECT * FROM vw_student_majors WHERE type = 'MAJOR';
-- ─────────────────────────────────────────────────────────────
CREATE VIEW vw_student_majors AS
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name)  AS student_name,
    s.email,
    s.gpa,
    sm.type                                  AS declaration_type,
    d.dept_id,
    d.dept_name,
    sm.declared_date
FROM STUDENT_MAJOR sm
JOIN STUDENT     s ON sm.student_id = s.student_id
JOIN DEPARTMENT  d ON sm.dept_id    = d.dept_id
ORDER BY s.student_id, sm.type;


-- ─────────────────────────────────────────────────────────────
-- VIEW 5: Employee Benefits Summary
-- Shows all active and past benefits per employee.
-- Usage: SELECT * FROM vw_employee_benefits WHERE status = 'Active';
-- ─────────────────────────────────────────────────────────────
CREATE VIEW vw_employee_benefits AS
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name)     AS employee_name,
    e.role,
    d.dept_name,
    e.salary,
    b.benefit_id,
    b.benefit_type,
    b.coverage,
    b.start_date,
    b.end_date,
    IF(b.end_date IS NULL, 'Active', 'Expired') AS status
FROM BENEFITS   b
JOIN EMPLOYEE   e ON b.employee_id = e.employee_id
JOIN DEPARTMENT d ON e.dept_id     = d.dept_id
ORDER BY e.employee_id, b.benefit_type;


-- ─────────────────────────────────────────────────────────────
-- VIEW 6: Course Enrollment Summary
-- Shows each course's total enrollments, pass rate,
-- and average grade points.
-- Usage: SELECT * FROM vw_course_enrollment_summary ORDER BY enrollment_count DESC;
-- ─────────────────────────────────────────────────────────────
CREATE VIEW vw_course_enrollment_summary AS
SELECT
    c.course_id,
    c.course_title,
    c.credits,
    d.dept_name,
    COUNT(e.enrollment_id)  AS enrollment_count,
    SUM(CASE WHEN e.grade NOT IN ('F','W') AND e.grade IS NOT NULL THEN 1 ELSE 0 END) AS passed_count,
    SUM(CASE WHEN e.grade = 'F' THEN 1 ELSE 0 END)                                   AS failed_count,
    ROUND(
        AVG(CASE e.grade
            WHEN 'A'  THEN 4.0  WHEN 'A-' THEN 3.7
            WHEN 'B+' THEN 3.3  WHEN 'B'  THEN 3.0
            WHEN 'B-' THEN 2.7  WHEN 'C+' THEN 2.3
            WHEN 'C'  THEN 2.0  WHEN 'C-' THEN 1.7
            WHEN 'D+' THEN 1.3  WHEN 'D'  THEN 1.0
            WHEN 'F'  THEN 0.0  ELSE NULL
        END), 2
    )                        AS avg_grade_points
FROM COURSE c
LEFT JOIN DEPARTMENT d   ON c.dept_id    = d.dept_id
LEFT JOIN SECTION    sec ON c.course_id  = sec.course_id
LEFT JOIN ENROLLMENT e   ON sec.section_id = e.section_id
GROUP BY c.course_id, c.course_title, c.credits, d.dept_name
ORDER BY enrollment_count DESC;
