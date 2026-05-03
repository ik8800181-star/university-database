-- ============================================================
--  UNIVERSITY DATABASE MANAGEMENT SYSTEM
--  File        : queries.sql
--  Description : 15 Sample Queries — JOINs, Subqueries, Aggregates
--  Group       : 13  |  Ibrahim Khatak  &  Malik M. Sanaullah
--  Engine      : MySQL
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- Q1: List all students with their department name
-- ─────────────────────────────────────────────────────────────
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email,
    s.gpa,
    d.dept_name
FROM STUDENT s
LEFT JOIN DEPARTMENT d ON s.dept_id = d.dept_id
ORDER BY s.gpa DESC;

-- ─────────────────────────────────────────────────────────────
-- Q2: Full course schedule — course, section, instructor,
--     semester, day and time, room
-- ─────────────────────────────────────────────────────────────
SELECT
    c.course_id,
    c.course_title,
    c.credits,
    sec.section_id,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor,
    sm.semester_name,
    sm.academic_year,
    ts.day_of_week,
    ts.start_time,
    ts.end_time,
    sec.location,
    sec.capacity
FROM SECTION sec
JOIN COURSE c      ON sec.course_id     = c.course_id
JOIN SEMESTER sm   ON sec.semester_id   = sm.semester_id
LEFT JOIN INSTRUCTOR i  ON sec.instructor_id = i.instructor_id
LEFT JOIN TIME_SLOT ts  ON sec.time_slot_id  = ts.time_slot_id
ORDER BY sm.academic_year, sm.semester_name, ts.day_of_week, ts.start_time;

-- ─────────────────────────────────────────────────────────────
-- Q3: Student transcript — all grades per student
-- ─────────────────────────────────────────────────────────────
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.student_id,
    c.course_id,
    c.course_title,
    c.credits,
    sm.semester_name,
    sm.academic_year,
    e.grade
FROM ENROLLMENT e
JOIN STUDENT  s   ON e.student_id  = s.student_id
JOIN SECTION  sec ON e.section_id  = sec.section_id
JOIN COURSE   c   ON sec.course_id = c.course_id
JOIN SEMESTER sm  ON sec.semester_id = sm.semester_id
ORDER BY s.student_id, sm.academic_year, sm.semester_name;

-- ─────────────────────────────────────────────────────────────
-- Q4: Number of students enrolled per section
-- ─────────────────────────────────────────────────────────────
SELECT
    sec.section_id,
    c.course_title,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor,
    sm.semester_name,
    sm.academic_year,
    sec.capacity,
    COUNT(e.enrollment_id)                  AS enrolled_count,
    (sec.capacity - COUNT(e.enrollment_id)) AS seats_remaining
FROM SECTION sec
JOIN COURSE   c   ON sec.course_id    = c.course_id
JOIN SEMESTER sm  ON sec.semester_id  = sm.semester_id
LEFT JOIN INSTRUCTOR i  ON sec.instructor_id = i.instructor_id
LEFT JOIN ENROLLMENT e  ON sec.section_id    = e.section_id
GROUP BY sec.section_id, c.course_title, instructor, sm.semester_name, sm.academic_year, sec.capacity
ORDER BY enrolled_count DESC;

-- ─────────────────────────────────────────────────────────────
-- Q5: All courses with their prerequisites
-- ─────────────────────────────────────────────────────────────
SELECT
    c.course_id,
    c.course_title       AS course,
    p.prereq_id,
    pre.course_title     AS prerequisite_course
FROM COURSE c
LEFT JOIN PREREQUISITE p   ON c.course_id   = p.course_id
LEFT JOIN COURSE       pre ON p.prereq_id   = pre.course_id
ORDER BY c.course_id;

-- ─────────────────────────────────────────────────────────────
-- Q6: Students with GPA above the average GPA
-- ─────────────────────────────────────────────────────────────
SELECT
    student_id,
    CONCAT(first_name, ' ', last_name) AS student_name,
    gpa,
    dept_id
FROM STUDENT
WHERE gpa > (SELECT AVG(gpa) FROM STUDENT)
ORDER BY gpa DESC;

-- ─────────────────────────────────────────────────────────────
-- Q7: Instructor workload — how many sections each instructor
--     teaches per semester
-- ─────────────────────────────────────────────────────────────
SELECT
    i.instructor_id,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,
    d.dept_name,
    sm.semester_name,
    sm.academic_year,
    COUNT(sec.section_id)                   AS sections_taught
FROM INSTRUCTOR i
JOIN DEPARTMENT d   ON i.dept_id      = d.dept_id
LEFT JOIN SECTION sec ON i.instructor_id = sec.instructor_id
LEFT JOIN SEMESTER sm ON sec.semester_id = sm.semester_id
GROUP BY i.instructor_id, instructor_name, d.dept_name, sm.semester_name, sm.academic_year
ORDER BY sections_taught DESC;

-- ─────────────────────────────────────────────────────────────
-- Q8: Department summary — number of students, instructors,
--     courses and total budget
-- ─────────────────────────────────────────────────────────────
SELECT
    d.dept_id,
    d.dept_name,
    d.building,
    d.budget,
    COUNT(DISTINCT s.student_id)    AS total_students,
    COUNT(DISTINCT i.instructor_id) AS total_instructors,
    COUNT(DISTINCT c.course_id)     AS total_courses
FROM DEPARTMENT d
LEFT JOIN STUDENT    s ON d.dept_id = s.dept_id
LEFT JOIN INSTRUCTOR i ON d.dept_id = i.dept_id
LEFT JOIN COURSE     c ON d.dept_id = c.dept_id
GROUP BY d.dept_id, d.dept_name, d.building, d.budget
ORDER BY d.budget DESC;

-- ─────────────────────────────────────────────────────────────
-- Q9: Students who have NOT enrolled in any course (yet)
-- ─────────────────────────────────────────────────────────────
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email,
    d.dept_name
FROM STUDENT s
LEFT JOIN DEPARTMENT d ON s.dept_id = d.dept_id
WHERE s.student_id NOT IN (
    SELECT DISTINCT student_id FROM ENROLLMENT
);

-- ─────────────────────────────────────────────────────────────
-- Q10: Grade distribution per course
--      (how many A, B, C, etc. were awarded)
-- ─────────────────────────────────────────────────────────────
SELECT
    c.course_id,
    c.course_title,
    e.grade,
    COUNT(*) AS count
FROM ENROLLMENT e
JOIN SECTION sec ON e.section_id  = sec.section_id
JOIN COURSE   c  ON sec.course_id = c.course_id
WHERE e.grade IS NOT NULL
GROUP BY c.course_id, c.course_title, e.grade
ORDER BY c.course_id, e.grade;

-- ─────────────────────────────────────────────────────────────
-- Q11: Student majors and minors with department info
-- ─────────────────────────────────────────────────────────────
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.student_id,
    sm.type,
    d.dept_name,
    sm.declared_date
FROM STUDENT_MAJOR sm
JOIN STUDENT    s ON sm.student_id = s.student_id
JOIN DEPARTMENT d ON sm.dept_id    = d.dept_id
ORDER BY s.student_id, sm.type;

-- ─────────────────────────────────────────────────────────────
-- Q12: Employee benefits summary — all benefits per employee
-- ─────────────────────────────────────────────────────────────
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.role,
    d.dept_name,
    b.benefit_type,
    b.coverage,
    b.start_date,
    IFNULL(CAST(b.end_date AS CHAR), 'Active') AS status
FROM BENEFITS b
JOIN EMPLOYEE   e ON b.employee_id = e.employee_id
JOIN DEPARTMENT d ON e.dept_id     = d.dept_id
ORDER BY e.employee_id, b.benefit_type;

-- ─────────────────────────────────────────────────────────────
-- Q13: Top performing student per department
--      (student with highest GPA in each dept)
-- ─────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    CONCAT(s.first_name, ' ', s.last_name) AS top_student,
    s.student_id,
    s.gpa
FROM STUDENT s
JOIN DEPARTMENT d ON s.dept_id = d.dept_id
WHERE s.gpa = (
    SELECT MAX(s2.gpa)
    FROM STUDENT s2
    WHERE s2.dept_id = s.dept_id
)
ORDER BY s.gpa DESC;

-- ─────────────────────────────────────────────────────────────
-- Q14: Courses that have never been enrolled in
-- ─────────────────────────────────────────────────────────────
SELECT
    c.course_id,
    c.course_title,
    c.credits,
    d.dept_name
FROM COURSE c
JOIN DEPARTMENT d ON c.dept_id = d.dept_id
WHERE c.course_id NOT IN (
    SELECT DISTINCT sec.course_id
    FROM SECTION  sec
    JOIN ENROLLMENT e ON sec.section_id = e.section_id
);

-- ─────────────────────────────────────────────────────────────
-- Q15: Instructor salary vs department average salary
-- ─────────────────────────────────────────────────────────────
SELECT
    i.instructor_id,
    CONCAT(i.first_name, ' ', i.last_name)                    AS instructor_name,
    d.dept_name,
    i.salary                                                   AS instructor_salary,
    ROUND(AVG(i2.salary) OVER (PARTITION BY i.dept_id), 2)    AS dept_avg_salary,
    ROUND(i.salary - AVG(i2.salary) OVER (PARTITION BY i.dept_id), 2) AS diff_from_avg
FROM INSTRUCTOR i
JOIN DEPARTMENT d  ON i.dept_id = d.dept_id
JOIN INSTRUCTOR i2 ON i.dept_id = i2.dept_id
GROUP BY i.instructor_id, instructor_name, d.dept_name, i.salary
ORDER BY d.dept_name, instructor_salary DESC;
