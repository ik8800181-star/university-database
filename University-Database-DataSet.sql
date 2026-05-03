-- ============================================================
--  UNIVERSITY DATABASE MANAGEMENT SYSTEM
--  File        : seed_data.sql
--  Description : Sample INSERT data for all 12 tables
--  Group       : 13  |  Ibrahim Khatak  &  Malik M. Sanaullah
--  Engine      : MySQL
-- ============================================================

-- ─────────────────────────────────────────
-- 1. DEPARTMENT
-- ─────────────────────────────────────────
INSERT INTO DEPARTMENT (dept_id, dept_name, building, budget) VALUES
('CS001',  'Computer Science',        'Block A', 500000.00),
('EE001',  'Electrical Engineering',  'Block B', 450000.00),
('ME001',  'Mechanical Engineering',  'Block C', 400000.00),
('BA001',  'Business Administration', 'Block D', 350000.00),
('MA001',  'Mathematics',             'Block E', 300000.00);

-- ─────────────────────────────────────────
-- 2. TIME_SLOT
-- ─────────────────────────────────────────
INSERT INTO TIME_SLOT (time_slot_id, day_of_week, start_time, end_time) VALUES
('TS001', 'Monday',    '08:00:00', '09:30:00'),
('TS002', 'Monday',    '10:00:00', '11:30:00'),
('TS003', 'Tuesday',   '08:00:00', '09:30:00'),
('TS004', 'Wednesday', '10:00:00', '11:30:00'),
('TS005', 'Thursday',  '14:00:00', '15:30:00'),
('TS006', 'Friday',    '08:00:00', '09:30:00'),
('TS007', 'Tuesday',   '12:00:00', '13:30:00'),
('TS008', 'Wednesday', '14:00:00', '15:30:00');

-- ─────────────────────────────────────────
-- 3. SEMESTER
-- ─────────────────────────────────────────
INSERT INTO SEMESTER (semester_id, semester_name, academic_year, start_date, end_date) VALUES
('SEM001', 'Fall',   2023, '2023-09-01', '2023-12-31'),
('SEM002', 'Spring', 2024, '2024-01-15', '2024-05-15'),
('SEM003', 'Fall',   2024, '2024-09-01', '2024-12-31'),
('SEM004', 'Spring', 2025, '2025-01-20', '2025-05-20');

-- ─────────────────────────────────────────
-- 4. STUDENT
-- ─────────────────────────────────────────
INSERT INTO STUDENT (student_id, first_name, last_name, date_of_birth, email, phone, address, enrollment_date, gpa, dept_id) VALUES
('24P-0001', 'Ali',     'Hassan',    '2003-03-12', 'ali.hassan@nu.edu.pk',     '0300-1234567', 'House 5, Peshawar',   '2023-09-01', 3.50, 'CS001'),
('24P-0002', 'Fatima',  'Khan',      '2003-07-22', 'fatima.khan@nu.edu.pk',    '0301-2345678', 'House 12, Islamabad', '2023-09-01', 3.75, 'CS001'),
('24P-0003', 'Usman',   'Tariq',     '2002-11-05', 'usman.tariq@nu.edu.pk',   '0302-3456789', 'House 8, Lahore',     '2023-09-01', 2.90, 'EE001'),
('24P-0004', 'Zainab',  'Malik',     '2003-01-18', 'zainab.malik@nu.edu.pk',  '0303-4567890', 'House 3, Karachi',    '2023-09-01', 3.20, 'ME001'),
('24P-0005', 'Ahmed',   'Siddiqui',  '2002-06-30', 'ahmed.sid@nu.edu.pk',     '0304-5678901', 'House 7, Multan',     '2023-09-01', 2.60, 'BA001'),
('24P-0006', 'Hira',    'Baig',      '2003-09-14', 'hira.baig@nu.edu.pk',     '0305-6789012', 'House 19, Quetta',    '2023-09-01', 3.90, 'CS001'),
('24P-0007', 'Bilal',   'Chaudhry',  '2002-04-02', 'bilal.ch@nu.edu.pk',      '0306-7890123', 'House 44, Faisalabad','2023-09-01', 3.10, 'MA001'),
('24P-0008', 'Ayesha',  'Rauf',      '2003-12-25', 'ayesha.rauf@nu.edu.pk',   '0307-8901234', 'House 2, Rawalpindi', '2024-01-15', 3.60, 'CS001'),
('24P-0009', 'Omar',    'Sheikh',    '2003-05-17', 'omar.sheikh@nu.edu.pk',   '0308-9012345', 'House 9, Hyderabad',  '2024-01-15', 2.80, 'EE001'),
('24P-0010', 'Sana',    'Afridi',    '2002-08-08', 'sana.afridi@nu.edu.pk',   '0309-0123456', 'House 33, Peshawar',  '2024-01-15', 3.40, 'MA001');

-- ─────────────────────────────────────────
-- 5. INSTRUCTOR
-- ─────────────────────────────────────────
INSERT INTO INSTRUCTOR (instructor_id, first_name, last_name, email, phone, salary, hire_date, dept_id) VALUES
('INS001', 'Dr. Kamran',  'Zafar',     'k.zafar@nu.edu.pk',    '0311-1111111', 120000.00, '2015-08-01', 'CS001'),
('INS002', 'Dr. Nadia',   'Hussain',   'n.hussain@nu.edu.pk',  '0312-2222222', 115000.00, '2016-02-15', 'CS001'),
('INS003', 'Prof. Asad',  'Gillani',   'a.gillani@nu.edu.pk',  '0313-3333333', 110000.00, '2014-09-01', 'EE001'),
('INS004', 'Dr. Rabia',   'Iqbal',     'r.iqbal@nu.edu.pk',    '0314-4444444', 105000.00, '2018-01-10', 'ME001'),
('INS005', 'Prof. Tariq', 'Mehmood',   't.mehmood@nu.edu.pk',  '0315-5555555', 100000.00, '2017-06-01', 'BA001'),
('INS006', 'Dr. Saima',   'Nawaz',     's.nawaz@nu.edu.pk',    '0316-6666666', 108000.00, '2019-03-20', 'MA001');

-- ─────────────────────────────────────────
-- 6. EMPLOYEE
-- ─────────────────────────────────────────
INSERT INTO EMPLOYEE (employee_id, first_name, last_name, email, phone, role, salary, hire_date, dept_id) VALUES
('EMP001', 'Rizwan',   'Qureshi',  'r.qureshi@nu.edu.pk',  '0321-1112233', 'Lab Engineer',       70000.00, '2018-05-01', 'CS001'),
('EMP002', 'Noman',    'Shah',     'n.shah@nu.edu.pk',     '0322-2223344', 'Admin Officer',      60000.00, '2019-07-15', 'EE001'),
('EMP003', 'Sumaira',  'Anwar',    's.anwar@nu.edu.pk',    '0323-3334455', 'Finance Officer',    65000.00, '2020-01-10', 'BA001'),
('EMP004', 'Faisal',   'Javed',    'f.javed@nu.edu.pk',    '0324-4445566', 'Lab Technician',     55000.00, '2021-03-01', 'ME001'),
('EMP005', 'Amna',     'Butt',     'a.butt@nu.edu.pk',     '0325-5556677', 'Academic Advisor',   72000.00, '2017-11-20', 'CS001');

-- ─────────────────────────────────────────
-- 7. COURSE
-- ─────────────────────────────────────────
INSERT INTO COURSE (course_id, course_title, credits, description, dept_id) VALUES
('CS101',  'Introduction to Programming',       3, 'Basics of programming using Python.',              'CS001'),
('CS201',  'Data Structures & Algorithms',      3, 'Arrays, linked lists, trees, sorting algorithms.', 'CS001'),
('CS301',  'Database Systems',                  3, 'Relational models, SQL, normalization.',            'CS001'),
('CS401',  'Operating Systems',                 3, 'Process management, memory, file systems.',         'CS001'),
('EE101',  'Circuit Analysis',                  3, 'Fundamentals of electrical circuits.',              'EE001'),
('EE201',  'Digital Logic Design',              3, 'Boolean algebra, logic gates, flip-flops.',         'EE001'),
('ME101',  'Engineering Mechanics',             3, 'Statics and dynamics of rigid bodies.',             'ME001'),
('BA101',  'Principles of Management',          3, 'Introduction to business management concepts.',     'BA001'),
('MA101',  'Calculus I',                        3, 'Limits, derivatives, and integration.',             'MA001'),
('MA201',  'Linear Algebra',                    3, 'Vectors, matrices, eigenvalues.',                   'MA001');

-- ─────────────────────────────────────────
-- 8. PREREQUISITE
-- ─────────────────────────────────────────
INSERT INTO PREREQUISITE (course_id, prereq_id) VALUES
('CS201', 'CS101'),   -- Data Structures requires Intro to Programming
('CS301', 'CS201'),   -- Database Systems requires Data Structures
('CS401', 'CS201'),   -- OS requires Data Structures
('EE201', 'EE101'),   -- Digital Logic requires Circuit Analysis
('MA201', 'MA101');   -- Linear Algebra requires Calculus I

-- ─────────────────────────────────────────
-- 9. SECTION
-- ─────────────────────────────────────────
INSERT INTO SECTION (section_id, course_id, instructor_id, semester_id, time_slot_id, location, capacity) VALUES
('SEC001', 'CS101',  'INS001', 'SEM001', 'TS001', 'Room A-101', 40),
('SEC002', 'CS201',  'INS001', 'SEM002', 'TS002', 'Room A-102', 35),
('SEC003', 'CS301',  'INS002', 'SEM003', 'TS003', 'Room A-103', 30),
('SEC004', 'CS401',  'INS002', 'SEM004', 'TS004', 'Room A-104', 30),
('SEC005', 'EE101',  'INS003', 'SEM001', 'TS005', 'Room B-101', 40),
('SEC006', 'EE201',  'INS003', 'SEM002', 'TS006', 'Room B-102', 35),
('SEC007', 'ME101',  'INS004', 'SEM001', 'TS007', 'Room C-101', 40),
('SEC008', 'BA101',  'INS005', 'SEM002', 'TS008', 'Room D-101', 45),
('SEC009', 'MA101',  'INS006', 'SEM001', 'TS001', 'Room E-101', 50),
('SEC010', 'MA201',  'INS006', 'SEM002', 'TS003', 'Room E-102', 40);

-- ─────────────────────────────────────────
-- 10. ENROLLMENT
-- ─────────────────────────────────────────
INSERT INTO ENROLLMENT (student_id, section_id, enrollment_date, grade) VALUES
-- SEM001 enrollments
('24P-0001', 'SEC001', '2023-09-01', 'A'),
('24P-0002', 'SEC001', '2023-09-01', 'A-'),
('24P-0003', 'SEC005', '2023-09-01', 'B+'),
('24P-0004', 'SEC007', '2023-09-01', 'B'),
('24P-0005', 'SEC001', '2023-09-01', 'C+'),
('24P-0006', 'SEC001', '2023-09-01', 'A'),
('24P-0007', 'SEC009', '2023-09-01', 'B+'),
('24P-0009', 'SEC005', '2023-09-01', 'B'),
('24P-0010', 'SEC009', '2023-09-01', 'A-'),
-- SEM002 enrollments
('24P-0001', 'SEC002', '2024-01-15', 'A'),
('24P-0002', 'SEC002', '2024-01-15', 'B+'),
('24P-0003', 'SEC006', '2024-01-15', 'B'),
('24P-0004', 'SEC008', '2024-01-15', 'B+'),
('24P-0005', 'SEC008', '2024-01-15', 'C'),
('24P-0006', 'SEC002', '2024-01-15', 'A'),
('24P-0007', 'SEC010', '2024-01-15', 'A-'),
('24P-0008', 'SEC002', '2024-01-15', 'B'),
('24P-0009', 'SEC006', '2024-01-15', 'C+'),
('24P-0010', 'SEC010', '2024-01-15', 'B+'),
-- SEM003 enrollments
('24P-0001', 'SEC003', '2024-09-01', 'A-'),
('24P-0002', 'SEC003', '2024-09-01', 'A'),
('24P-0006', 'SEC003', '2024-09-01', 'A'),
('24P-0008', 'SEC003', '2024-09-01', 'B+');

-- ─────────────────────────────────────────
-- 11. STUDENT_MAJOR
-- ─────────────────────────────────────────
INSERT INTO STUDENT_MAJOR (student_id, dept_id, type, declared_date) VALUES
('24P-0001', 'CS001', 'MAJOR', '2023-09-05'),
('24P-0001', 'MA001', 'MINOR', '2023-09-05'),
('24P-0002', 'CS001', 'MAJOR', '2023-09-05'),
('24P-0003', 'EE001', 'MAJOR', '2023-09-05'),
('24P-0004', 'ME001', 'MAJOR', '2023-09-05'),
('24P-0004', 'BA001', 'MINOR', '2023-09-05'),
('24P-0005', 'BA001', 'MAJOR', '2023-09-05'),
('24P-0006', 'CS001', 'MAJOR', '2023-09-05'),
('24P-0007', 'MA001', 'MAJOR', '2023-09-05'),
('24P-0007', 'CS001', 'MINOR', '2023-09-05'),
('24P-0008', 'CS001', 'MAJOR', '2024-01-20'),
('24P-0009', 'EE001', 'MAJOR', '2024-01-20'),
('24P-0010', 'MA001', 'MAJOR', '2024-01-20');

-- ─────────────────────────────────────────
-- 12. BENEFITS
-- ─────────────────────────────────────────
INSERT INTO BENEFITS (employee_id, benefit_type, coverage, start_date, end_date) VALUES
('EMP001', 'Health',        'Full Family Coverage',     '2018-05-01', NULL),
('EMP001', 'Dental',        'Employee Only',            '2018-05-01', NULL),
('EMP002', 'Health',        'Employee + Spouse',        '2019-07-15', NULL),
('EMP002', 'Pension',       '10% Salary Contribution',  '2019-07-15', NULL),
('EMP003', 'Health',        'Full Family Coverage',     '2020-01-10', NULL),
('EMP003', 'Vision',        'Employee Only',            '2020-01-10', NULL),
('EMP003', 'Life Insurance','PKR 5,000,000 Coverage',   '2020-01-10', NULL),
('EMP004', 'Health',        'Employee Only',            '2021-03-01', NULL),
('EMP004', 'Dental',        'Employee Only',            '2021-03-01', NULL),
('EMP005', 'Health',        'Full Family Coverage',     '2017-11-20', NULL),
('EMP005', 'Pension',       '12% Salary Contribution',  '2017-11-20', NULL),
('EMP005', 'Life Insurance','PKR 8,000,000 Coverage',   '2017-11-20', NULL);
