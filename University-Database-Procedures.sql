-- ============================================================
--  UNIVERSITY DATABASE MANAGEMENT SYSTEM
--  File        : procedures.sql
--  Description : Stored Procedures & Triggers (4 procedures + 3 triggers)
--  Group       : 13  |  Ibrahim Khatak  &  Malik M. Sanaullah
--  Engine      : MySQL
-- ============================================================

DELIMITER $$

-- ============================================================
--  STORED PROCEDURE 1: sp_enroll_student
--  Safely enroll a student into a section.
--  Checks:
--    (a) Section exists
--    (b) Student is not already enrolled in this section
--    (c) Section has available capacity
--  Usage:
--    CALL sp_enroll_student('24P-0001', 'SEC005', '2024-09-01');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_enroll_student $$

CREATE PROCEDURE sp_enroll_student(
    IN  p_student_id     VARCHAR(15),
    IN  p_section_id     VARCHAR(20),
    IN  p_enroll_date    DATE
)
BEGIN
    DECLARE v_capacity      SMALLINT DEFAULT 0;
    DECLARE v_enrolled      INT      DEFAULT 0;
    DECLARE v_already       INT      DEFAULT 0;

    -- Check if section exists and get its capacity
    SELECT capacity INTO v_capacity
    FROM SECTION
    WHERE section_id = p_section_id;

    IF v_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Section does not exist.';
    END IF;

    -- Check if student is already enrolled
    SELECT COUNT(*) INTO v_already
    FROM ENROLLMENT
    WHERE student_id = p_student_id
      AND section_id = p_section_id;

    IF v_already > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Student is already enrolled in this section.';
    END IF;

    -- Check current enrollment count vs capacity
    SELECT COUNT(*) INTO v_enrolled
    FROM ENROLLMENT
    WHERE section_id = p_section_id;

    IF v_enrolled >= v_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Section is full. No seats remaining.';
    END IF;

    -- All checks passed — insert enrollment
    INSERT INTO ENROLLMENT (student_id, section_id, enrollment_date, grade)
    VALUES (p_student_id, p_section_id, p_enroll_date, NULL);

    SELECT CONCAT('SUCCESS: Student ', p_student_id,
                  ' enrolled in section ', p_section_id,
                  '. Seats remaining: ', (v_capacity - v_enrolled - 1)) AS result;
END $$


-- ============================================================
--  STORED PROCEDURE 2: sp_get_student_transcript
--  Retrieves the full academic transcript for a student,
--  including credit-weighted GPA calculation.
--  Usage:
--    CALL sp_get_student_transcript('24P-0001');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_get_student_transcript $$

CREATE PROCEDURE sp_get_student_transcript(
    IN p_student_id VARCHAR(15)
)
BEGIN
    -- Full transcript rows
    SELECT
        CONCAT(s.first_name, ' ', s.last_name)  AS student_name,
        s.student_id,
        sm.semester_name,
        sm.academic_year,
        c.course_id,
        c.course_title,
        c.credits,
        e.grade,
        CASE e.grade
            WHEN 'A'  THEN 4.0  WHEN 'A-' THEN 3.7
            WHEN 'B+' THEN 3.3  WHEN 'B'  THEN 3.0
            WHEN 'B-' THEN 2.7  WHEN 'C+' THEN 2.3
            WHEN 'C'  THEN 2.0  WHEN 'C-' THEN 1.7
            WHEN 'D+' THEN 1.3  WHEN 'D'  THEN 1.0
            WHEN 'F'  THEN 0.0  ELSE NULL
        END AS grade_points
    FROM ENROLLMENT e
    JOIN STUDENT  s   ON e.student_id   = s.student_id
    JOIN SECTION  sec ON e.section_id   = sec.section_id
    JOIN COURSE   c   ON sec.course_id  = c.course_id
    JOIN SEMESTER sm  ON sec.semester_id = sm.semester_id
    WHERE s.student_id = p_student_id
    ORDER BY sm.academic_year, sm.semester_name, c.course_id;

    -- Summary row: total credits and calculated GPA
    SELECT
        SUM(c.credits)  AS total_credits_attempted,
        ROUND(
            SUM(
                CASE e.grade
                    WHEN 'A'  THEN 4.0 * c.credits  WHEN 'A-' THEN 3.7 * c.credits
                    WHEN 'B+' THEN 3.3 * c.credits  WHEN 'B'  THEN 3.0 * c.credits
                    WHEN 'B-' THEN 2.7 * c.credits  WHEN 'C+' THEN 2.3 * c.credits
                    WHEN 'C'  THEN 2.0 * c.credits  WHEN 'C-' THEN 1.7 * c.credits
                    WHEN 'D+' THEN 1.3 * c.credits  WHEN 'D'  THEN 1.0 * c.credits
                    WHEN 'F'  THEN 0.0              ELSE 0
                END
            ) / NULLIF(SUM(c.credits), 0), 2
        )               AS calculated_gpa
    FROM ENROLLMENT e
    JOIN SECTION  sec ON e.section_id   = sec.section_id
    JOIN COURSE   c   ON sec.course_id  = c.course_id
    WHERE e.student_id = p_student_id
      AND e.grade IS NOT NULL
      AND e.grade NOT IN ('W', 'I');
END $$


-- ============================================================
--  STORED PROCEDURE 3: sp_department_report
--  Generates a full summary report for a given department:
--  students, instructors, courses, and budget.
--  Usage:
--    CALL sp_department_report('CS001');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_department_report $$

CREATE PROCEDURE sp_department_report(
    IN p_dept_id VARCHAR(10)
)
BEGIN
    -- Department info
    SELECT dept_id, dept_name, building, budget
    FROM DEPARTMENT
    WHERE dept_id = p_dept_id;

    -- Students in this department
    SELECT
        student_id,
        CONCAT(first_name,' ',last_name) AS student_name,
        gpa,
        enrollment_date
    FROM STUDENT
    WHERE dept_id = p_dept_id
    ORDER BY gpa DESC;

    -- Instructors in this department
    SELECT
        instructor_id,
        CONCAT(first_name,' ',last_name) AS instructor_name,
        email,
        salary,
        hire_date
    FROM INSTRUCTOR
    WHERE dept_id = p_dept_id
    ORDER BY salary DESC;

    -- Courses offered by this department
    SELECT
        course_id,
        course_title,
        credits,
        description
    FROM COURSE
    WHERE dept_id = p_dept_id
    ORDER BY course_id;
END $$


-- ============================================================
--  STORED PROCEDURE 4: sp_update_grade
--  Update a student's grade for a specific section and
--  automatically recalculate + update their GPA.
--  Usage:
--    CALL sp_update_grade('24P-0001', 'SEC001', 'A');
-- ============================================================
DROP PROCEDURE IF EXISTS sp_update_grade $$

CREATE PROCEDURE sp_update_grade(
    IN p_student_id  VARCHAR(15),
    IN p_section_id  VARCHAR(20),
    IN p_grade       VARCHAR(5)
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;

    -- Verify enrollment record exists
    SELECT COUNT(*) INTO v_exists
    FROM ENROLLMENT
    WHERE student_id = p_student_id
      AND section_id = p_section_id;

    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: No enrollment record found for this student and section.';
    END IF;

    -- Update the grade
    UPDATE ENROLLMENT
    SET grade = p_grade
    WHERE student_id = p_student_id
      AND section_id = p_section_id;

    -- Recalculate and update student's cumulative GPA
    UPDATE STUDENT
    SET gpa = (
        SELECT ROUND(
            SUM(
                CASE e.grade
                    WHEN 'A'  THEN 4.0 * c.credits  WHEN 'A-' THEN 3.7 * c.credits
                    WHEN 'B+' THEN 3.3 * c.credits  WHEN 'B'  THEN 3.0 * c.credits
                    WHEN 'B-' THEN 2.7 * c.credits  WHEN 'C+' THEN 2.3 * c.credits
                    WHEN 'C'  THEN 2.0 * c.credits  WHEN 'C-' THEN 1.7 * c.credits
                    WHEN 'D+' THEN 1.3 * c.credits  WHEN 'D'  THEN 1.0 * c.credits
                    WHEN 'F'  THEN 0.0              ELSE 0
                END
            ) / NULLIF(SUM(c.credits), 0), 2
        )
        FROM ENROLLMENT e
        JOIN SECTION  sec ON e.section_id  = sec.section_id
        JOIN COURSE   c   ON sec.course_id = c.course_id
        WHERE e.student_id = p_student_id
          AND e.grade IS NOT NULL
          AND e.grade NOT IN ('W', 'I')
    )
    WHERE student_id = p_student_id;

    SELECT CONCAT('SUCCESS: Grade updated to ', p_grade,
                  ' for student ', p_student_id,
                  '. GPA has been recalculated.') AS result;
END $$


-- ============================================================
--  TRIGGER 1: trg_after_grade_update
--  Automatically recalculates a student's GPA every time
--  a grade is updated in the ENROLLMENT table.
-- ============================================================
DROP TRIGGER IF EXISTS trg_after_grade_update $$

CREATE TRIGGER trg_after_grade_update
AFTER UPDATE ON ENROLLMENT
FOR EACH ROW
BEGIN
    IF NEW.grade IS NOT NULL AND NEW.grade != OLD.grade THEN
        UPDATE STUDENT
        SET gpa = (
            SELECT ROUND(
                SUM(
                    CASE e.grade
                        WHEN 'A'  THEN 4.0 * c.credits  WHEN 'A-' THEN 3.7 * c.credits
                        WHEN 'B+' THEN 3.3 * c.credits  WHEN 'B'  THEN 3.0 * c.credits
                        WHEN 'B-' THEN 2.7 * c.credits  WHEN 'C+' THEN 2.3 * c.credits
                        WHEN 'C'  THEN 2.0 * c.credits  WHEN 'C-' THEN 1.7 * c.credits
                        WHEN 'D+' THEN 1.3 * c.credits  WHEN 'D'  THEN 1.0 * c.credits
                        WHEN 'F'  THEN 0.0              ELSE 0
                    END
                ) / NULLIF(SUM(c.credits), 0), 2
            )
            FROM ENROLLMENT e
            JOIN SECTION  sec ON e.section_id  = sec.section_id
            JOIN COURSE   c   ON sec.course_id = c.course_id
            WHERE e.student_id = NEW.student_id
              AND e.grade IS NOT NULL
              AND e.grade NOT IN ('W', 'I')
        )
        WHERE student_id = NEW.student_id;
    END IF;
END $$


-- ============================================================
--  TRIGGER 2: trg_check_enrollment_capacity
--  Prevents inserting a new enrollment if the section
--  has already reached its maximum capacity.
-- ============================================================
DROP TRIGGER IF EXISTS trg_check_enrollment_capacity $$

CREATE TRIGGER trg_check_enrollment_capacity
BEFORE INSERT ON ENROLLMENT
FOR EACH ROW
BEGIN
    DECLARE v_capacity SMALLINT;
    DECLARE v_enrolled INT;

    SELECT capacity INTO v_capacity
    FROM SECTION
    WHERE section_id = NEW.section_id;

    SELECT COUNT(*) INTO v_enrolled
    FROM ENROLLMENT
    WHERE section_id = NEW.section_id;

    IF v_enrolled >= v_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ENROLLMENT BLOCKED: This section has reached maximum capacity.';
    END IF;
END $$


-- ============================================================
--  TRIGGER 3: trg_log_benefit_end
--  Ensures that whenever a BENEFITS record is updated,
--  if an end_date is set, it cannot be earlier than start_date.
--  Acts as an extra safety guard beyond the CHECK constraint.
-- ============================================================
DROP TRIGGER IF EXISTS trg_log_benefit_end $$

CREATE TRIGGER trg_log_benefit_end
BEFORE UPDATE ON BENEFITS
FOR EACH ROW
BEGIN
    IF NEW.end_date IS NOT NULL AND NEW.end_date < NEW.start_date THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Benefit end_date cannot be earlier than start_date.';
    END IF;
END $$

DELIMITER ;

-- ============================================================
--  QUICK TEST CALLS (uncomment to test after running schema
--  and seed_data first)
-- ============================================================

-- CALL sp_enroll_student('24P-0010', 'SEC003', '2024-09-01');
-- CALL sp_get_student_transcript('24P-0001');
-- CALL sp_department_report('CS001');
-- CALL sp_update_grade('24P-0001', 'SEC001', 'A');
