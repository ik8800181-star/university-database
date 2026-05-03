.mode tabel
.system cls

DROP TABLE IF EXISTS STUDENT_MAJOR;
DROP TABLE IF EXISTS ENROLLMENT;
DROP TABLE IF EXISTS SECTION;
DROP TABLE IF EXISTS PREREQUISITE;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS BENEFITS;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS INSTRUCTOR;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS SEMESTER;
DROP TABLE IF EXISTS TIME_SLOT;
DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE DEPARTMENT(
    dept_id VARCHAR(10) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    building VARCHAR(100),
    budget DECIMAL(15,2) CHECK(budget>=0),
    PRIMARY KEY(dept_id)
);

CREATE TABLE TIME_SLOT(
    time_slot_id VARCHAR(10) NOT NULL,
    day_of_week VARCHAR(10) NOT NULL CHECK(day_of_week IN('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    PRIMARY KEY(time_slot_id),
    CHECK(end_time>start_time)
);

CREATE TABLE SEMESTER(
    semester_id VARCHAR(10) NOT NULL,
    semester_name VARCHAR(20) NOT NULL CHECK(semester_name IN('Fall','Spring','Summer')),
    academic_year YEAR NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    PRIMARY KEY(semester_id),
    CHECK(end_date>start_date)
);

CREATE TABLE STUDENT(
    student_id VARCHAR(15) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    enrollment_date DATE NOT NULL,
    gpa DECIMAL(3,2) DEFAULT 0.00 CHECK(gpa BETWEEN 0.00 AND 4.00),
    dept_id VARCHAR(10),
    PRIMARY KEY(student_id),
    FOREIGN KEY(dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE INSTRUCTOR(
    instructor_id VARCHAR(15) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    salary DECIMAL(12,2) CHECK(salary>=0),
    hire_date DATE,
    dept_id VARCHAR(10),
    PRIMARY KEY(instructor_id),
    FOREIGN KEY(dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE EMPLOYEE(
    employee_id VARCHAR(15) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    role VARCHAR(50) NOT NULL,
    salary DECIMAL(12,2) CHECK(salary>=0),
    hire_date DATE,
    dept_id VARCHAR(10),
    PRIMARY KEY(employee_id),
    FOREIGN KEY(dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE COURSE(
    course_id VARCHAR(15) NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    credits TINYINT NOT NULL CHECK(credits BETWEEN 1 AND 6),
    description TEXT,
    dept_id VARCHAR(10),
    PRIMARY KEY(course_id),
    FOREIGN KEY(dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE PREREQUISITE(
    course_id VARCHAR(15) NOT NULL,
    prereq_id VARCHAR(15) NOT NULL,
    PRIMARY KEY(course_id,prereq_id),
    FOREIGN KEY(course_id) REFERENCES COURSE(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(prereq_id) REFERENCES COURSE(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK(course_id<>prereq_id)
);

CREATE TABLE SECTION(
    section_id VARCHAR(20) NOT NULL,
    course_id VARCHAR(15) NOT NULL,
    instructor_id VARCHAR(15),
    semester_id VARCHAR(10) NOT NULL,
    time_slot_id VARCHAR(10),
    location VARCHAR(100),
    capacity SMALLINT DEFAULT 40 CHECK(capacity>0),
    PRIMARY KEY(section_id),
    FOREIGN KEY(course_id) REFERENCES COURSE(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(instructor_id) REFERENCES INSTRUCTOR(instructor_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(semester_id) REFERENCES SEMESTER(semester_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY(time_slot_id) REFERENCES TIME_SLOT(time_slot_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE ENROLLMENT(
    enrollment_id INT NOT NULL AUTO_INCREMENT,
    student_id VARCHAR(15) NOT NULL,
    section_id VARCHAR(20) NOT NULL,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(5) CHECK(grade IN('A','A-','B+','B','B-','C+','C','C-','D+','D','F','W','I',NULL)),
    PRIMARY KEY(enrollment_id),
    UNIQUE(student_id,section_id),
    FOREIGN KEY(student_id) REFERENCES STUDENT(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(section_id) REFERENCES SECTION(section_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE STUDENT_MAJOR(
    student_id VARCHAR(15) NOT NULL,
    dept_id VARCHAR(10) NOT NULL,
    type VARCHAR(10) NOT NULL CHECK(type IN('MAJOR','MINOR')),
    declared_date DATE NOT NULL,
    PRIMARY KEY(student_id,dept_id,type),
    FOREIGN KEY(student_id) REFERENCES STUDENT(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE BENEFITS(
    benefit_id INT NOT NULL AUTO_INCREMENT,
    employee_id VARCHAR(15) NOT NULL,
    benefit_type VARCHAR(50) NOT NULL CHECK(benefit_type IN('Health','Dental','Vision','Pension','Life Insurance','Other')),
    coverage VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY(benefit_id),
    FOREIGN KEY(employee_id) REFERENCES EMPLOYEE(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK(end_date IS NULL OR end_date>=start_date)
);