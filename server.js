const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database : 'university-database-management'
});

db.connect((err) => {
    if (err) {
        console.log('❌ Database connection failed:', err.message);
        return;
    }
    console.log('✅ Connected to MySQL database!');
});

app.get('/api/students', (req, res) => {
    const sql = `
        SELECT s.student_id, CONCAT(s.first_name,' ',s.last_name) AS name,
               s.email, s.gpa, d.dept_name
        FROM STUDENT s
        LEFT JOIN DEPARTMENT d ON s.dept_id = d.dept_id
        ORDER BY s.gpa DESC`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/courses', (req, res) => {
    const sql = `
        SELECT c.course_id, c.course_title, c.credits,
               d.dept_name
        FROM COURSE c
        LEFT JOIN DEPARTMENT d ON c.dept_id = d.dept_id`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/departments', (req, res) => {
    db.query('SELECT * FROM DEPARTMENT', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/transcript/:student_id', (req, res) => {
    const sql = `SELECT * FROM vw_student_transcript WHERE student_id = ?`;
    db.query(sql, [req.params.student_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/enrollments', (req, res) => {
    const sql = `
        SELECT e.enrollment_id,
               CONCAT(s.first_name,' ',s.last_name) AS student_name,
               c.course_title, e.grade, e.enrollment_date
        FROM ENROLLMENT e
        JOIN STUDENT s   ON e.student_id  = s.student_id
        JOIN SECTION sec ON e.section_id  = sec.section_id
        JOIN COURSE c    ON sec.course_id = c.course_id`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/instructors', (req, res) => {
    const sql = `
        SELECT i.instructor_id,
               CONCAT(i.first_name,' ',i.last_name) AS name,
               i.email, i.salary, d.dept_name
        FROM INSTRUCTOR i
        LEFT JOIN DEPARTMENT d ON i.dept_id = d.dept_id`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/employees', (req, res) => {
    db.query('SELECT * FROM vw_employee_benefits', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/schedule', (req, res) => {
    db.query('SELECT * FROM vw_section_schedule', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.post('/api/enroll', (req, res) => {
    const { student_id, section_id, enrollment_date } = req.body;
    db.query('CALL sp_enroll_student(?, ?, ?)',
        [student_id, section_id, enrollment_date],
        (err, results) => {
            if (err) return res.status(500).json({ error: err.message });
            res.json({ message: 'Student enrolled successfully!' });
        });
});

app.put('/api/grade', (req, res) => {
    const { student_id, section_id, grade } = req.body;
    db.query('CALL sp_update_grade(?, ?, ?)',
        [student_id, section_id, grade],
        (err, results) => {
            if (err) return res.status(500).json({ error: err.message });
            res.json({ message: 'Grade updated and GPA recalculated!' });
        });
});

app.listen(3000, () => {
    console.log('🚀 Server running at http://localhost:3000');
});