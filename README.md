<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&height=260&color=0:2563eb,50:7c3aed,100:9333ea&text=University%20Database%20Management%20System&fontColor=ffffff&fontSize=42&fontAlignY=38&desc=Full-Stack%20Academic%20Information%20Platform&descAlignY=58&animation=fadeIn" width="100%" />

<br/>

<img src="https://readme-typing-svg.herokuapp.com?font=Inter&weight=600&size=24&duration=3000&pause=1000&color=7C3AED&center=true&vCenter=true&width=900&lines=Relational+Database+Design;Node.js+%2B+Express+REST+API;MySQL+Database+with+Triggers+%26+Views;Full-Stack+University+Management+System;FAST+Database+Systems+Lab+Project" />

<br/><br/>

<img src="https://img.shields.io/badge/MySQL-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white"/>
<img src="https://img.shields.io/badge/Node.js-Backend-339933?style=for-the-badge&logo=nodedotjs&logoColor=white"/>
<img src="https://img.shields.io/badge/Express.js-REST_API-black?style=for-the-badge&logo=express&logoColor=white"/>
<img src="https://img.shields.io/badge/Frontend-HTML%2FCSS%2FJS-E34F26?style=for-the-badge&logo=html5&logoColor=white"/>
<img src="https://img.shields.io/badge/MySQL-XAMPP-FB7A24?style=for-the-badge&logo=xampp&logoColor=white"/>
<img src="https://img.shields.io/badge/Status-Complete-success?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Academic-Project-blueviolet?style=for-the-badge"/>

<br/><br/>

# 🎓 University Database Management System

### ⚡ A Complete Full-Stack Academic Information Platform

<p align="center">
A professionally designed university management platform featuring normalized relational database architecture, REST APIs, stored procedures, triggers, views, and a modern frontend interface.
</p>

<br/>

<table>
<tr>
<td align="center" width="33%">

### 🏫 Institution
National University of Computer  
& Emerging Sciences (FAST-NUCES)

</td>

<td align="center" width="33%">

### 📘 Course
Database Systems Lab  
Spring 2025

<br/>

**Theory Instructor**  
Sir Shoaib Khan

<br/>

**Lab Instructor**  
Muhammad Mehdi

</td>

<td align="center" width="33%">

### 👥 Group
Group #13

</td>
</tr>
</table>

---

## 👨‍💻 Developers

<table>
<tr>
<td align="center">

<img src="https://avatars.githubusercontent.com/u/9919?s=200&v=4" width="90"/>

### Muhammad Ibrahim Khatak
`24P-0648`

</td>

<td align="center">

<img width="102" height="102" alt="WhatsApp Image 2026-05-03 at 4 35 08 AM" src="https://github.com/user-attachments/assets/641d0501-db2a-4bcc-ae2d-aec3719de333" />

### Malik Muhammad Sanaullah
`24P-0554`

</td>
</tr>
</table>

</div>

---

# 📋 Table of Contents

- [📌 Project Overview](#-project-overview)
- [📊 Project Snapshot](#-project-snapshot)
- [✨ Core Features](#-core-features)
- [🏗 System Architecture](#-system-architecture)
- [🗃 Database Design](#-database-design)
- [📁 File Structure](#-file-structure)
- [⚙ Backend API](#-backend-api)
- [🖥 Frontend Pages](#-frontend-pages)
- [🚀 Getting Started](#-getting-started)
- [🧠 Stored Procedures](#-stored-procedures)
- [👁 Views](#-views)
- [⚡ Triggers](#-triggers)
- [🔍 Sample Queries](#-sample-queries)
- [📸 Application Preview](#-application-preview)
- [🛠 Tech Stack](#-tech-stack)
- [🤝 Contribution](#-contribution)
- [📜 License](#-license)

---

# 📌 Project Overview

The **University Database Management System (UDBMS)** is a fully functional, full-stack academic information platform designed to manage all core operations of a university.

It handles:

- 👨‍🎓 Students
- 👩‍🏫 Instructors
- 🏢 Employees
- 📚 Courses
- 🗓 Semesters
- 🧾 Enrollments
- 📊 Grades
- 🏫 Sections
- 🎁 Employee Benefits
- 🧠 Prerequisites

The project demonstrates real-world database design principles including:

- Relational Database Modeling
- Normalization
- Referential Integrity
- Stored Procedures
- Triggers
- Views
- REST APIs
- Full-Stack Integration

---

# 📊 Project Snapshot

<div align="center">

| Component | Count |
|---|---|
| 🗃️ Database Tables | 12 |
| 👁️ Database Views | 6 |
| ⚡ Triggers | 3 |
| 🧠 Stored Procedures | 4 |
| 🌐 REST API Routes | 10 |
| 🖥️ Frontend Pages | 4 |
| 🔍 SQL Queries | 15 |

</div>

---

# ✨ Core Features

<div align="center">

| 🎓 Academic Features | ⚙️ Database Features | 🌐 Full Stack Features |
|---|---|---|
| Student Management | Triggers | REST API |
| Transcript System | Stored Procedures | Live Dashboard |
| Course Registration | Views | Search & Filters |
| GPA Calculation | Constraints | Responsive UI |
| Semester Tracking | Normalization | Dynamic Frontend |
| Enrollment System | Complex Queries | Real-Time Data |

</div>

---

# 🏗 System Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                        FRONTEND                             │
│         HTML5 + CSS3 + Vanilla JavaScript                   │
│   Dashboard │ Students │ Courses │ Transcript               │
└──────────────────────┬──────────────────────────────────────┘
                       │ HTTP Requests (fetch API)
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                     BACKEND API                             │
│                 Node.js + Express.js                        │
│    /api/students  /api/courses  /api/transcript            │
│    /api/enrollments  /api/schedule  /api/employees         │
└──────────────────────┬──────────────────────────────────────┘
                       │ SQL Queries via mysql2
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                        DATABASE                             │
│               MySQL (XAMPP/phpMyAdmin)                      │
│     12 Tables │ 6 Views │ 4 Procedures │ 3 Triggers        │
└─────────────────────────────────────────────────────────────┘
````

---

# 🗃 Database Design

## 📌 Main Entities

| Entity        | Description                |
| ------------- | -------------------------- |
| STUDENT       | Stores student information |
| INSTRUCTOR    | Faculty records            |
| EMPLOYEE      | Non-teaching staff         |
| COURSE        | Course catalog             |
| SECTION       | Course offerings           |
| ENROLLMENT    | Student registrations      |
| SEMESTER      | Academic semesters         |
| DEPARTMENT    | University departments     |
| BENEFITS      | Employee benefits          |
| TIME_SLOT     | Class timings              |
| PREREQUISITE  | Course prerequisites       |
| STUDENT_MAJOR | Student majors/minors      |

---

## 🔗 Relationships

| Relationship         | Type              |
| -------------------- | ----------------- |
| STUDENT → ENROLLMENT | One-to-Many       |
| COURSE → SECTION     | One-to-Many       |
| STUDENT ↔ SECTION    | Many-to-Many      |
| COURSE ↔ COURSE      | Self Relationship |
| EMPLOYEE → BENEFITS  | One-to-Many       |
| DEPARTMENT → COURSE  | One-to-Many       |

---

# 📁 File Structure

```text
📦 University-Database-Management/
│
├── 📂 backend/
│   ├── server.js
│   ├── package.json
│   └── node_modules/
│
├── 📂 database/
│   ├── University_Database.sql
│   ├── seed_data.sql
│   ├── views.sql
│   ├── procedures.sql
│   └── queries.sql
│
├── 📂 frontend/
│   ├── index.html
│   ├── students.html
│   ├── courses.html
│   ├── transcript.html
│   └── style.css
│
├── 📂 screenshots/
│   ├── dashboard.png
│   ├── students.png
│   ├── courses.png
│   └── transcript.png
│
├── 📂 diagrams/
│   └── University_Database.drawio
│
└── README.md
```

---

# ⚙ Backend API

| Method | Endpoint                      | Description             |
| ------ | ----------------------------- | ----------------------- |
| GET    | `/api/students`               | Retrieve all students   |
| GET    | `/api/courses`                | Retrieve all courses    |
| GET    | `/api/departments`            | Retrieve departments    |
| GET    | `/api/enrollments`            | Retrieve enrollments    |
| GET    | `/api/instructors`            | Retrieve instructors    |
| GET    | `/api/employees`              | Retrieve employees      |
| GET    | `/api/schedule`               | Retrieve class schedule |
| GET    | `/api/transcript/:student_id` | Student transcript      |
| POST   | `/api/enroll`                 | Enroll student          |
| PUT    | `/api/grade`                  | Update student grade    |

---

# 🖥 Frontend Pages

| Page       | Features                                   |
| ---------- | ------------------------------------------ |
| Dashboard  | Live stats, top students, quick navigation |
| Students   | Search, enrollments, GPA updates           |
| Courses    | Course catalog and schedule                |
| Transcript | Full academic transcript viewer            |

---

# 🚀 Getting Started

## 📌 Prerequisites

Install the following:

* XAMPP
* Node.js
* VS Code
* Modern Web Browser

---

## ⚡ Installation

### 1️⃣ Clone Repository

```bash
git clone https://github.com/Malik-Sanaullah/University-Database-Management-.git
cd University-Database-Management-
```

---

### 2️⃣ Setup Database

* Open XAMPP
* Start Apache and MySQL
* Open phpMyAdmin
* Create database:

```sql
university-database-management
```

Import SQL files in this order:

```text
1. University_Database.sql
2. seed_data.sql
3. views.sql
4. procedures.sql
```

---

### 3️⃣ Setup Backend

```bash
cd backend
npm install
```

---

### 4️⃣ Run Backend

```bash
node server.js
```

Expected Output:

```text
🚀 Server running at http://localhost:3000
✅ Connected to MySQL database!
```

---

### 5️⃣ Run Frontend

Open:

```text
frontend/index.html
```

---

# 🧠 Stored Procedures

| Procedure                 | Purpose                     |
| ------------------------- | --------------------------- |
| sp_enroll_student         | Enroll student into section |
| sp_get_student_transcript | Generate transcript         |
| sp_department_report      | Department statistics       |
| sp_update_grade           | Update grade & GPA          |

---

# 👁 Views

| View                         | Description              |
| ---------------------------- | ------------------------ |
| vw_student_transcript        | Student academic history |
| vw_section_schedule          | Full timetable           |
| vw_department_roster         | Department overview      |
| vw_student_majors            | Majors & minors          |
| vw_employee_benefits         | Benefits overview        |
| vw_course_enrollment_summary | Enrollment analytics     |

---

# ⚡ Triggers

| Trigger                       | Purpose                       |
| ----------------------------- | ----------------------------- |
| trg_after_grade_update        | Recalculate GPA automatically |
| trg_check_enrollment_capacity | Prevent over-enrollment       |
| trg_log_benefit_end           | Validate benefit dates        |

---

# 🔍 Sample Queries

The project contains 15 SQL queries demonstrating:

* JOINs
* GROUP BY
* Subqueries
* Window Functions
* Aggregates
* Self Joins
* Correlated Queries

---

# 📸 Application Preview

## 🏠 Dashboard

<p align="center">
  <img width="419" height="419" alt="Dashboard" src="https://github.com/user-attachments/assets/af2f3cb5-a141-475b-85fb-df80b5c0007f" />

</p>

---

## 👨‍🎓 Students Management

<p align="center">
  <img width="334" height="410" alt="Students" src="https://github.com/user-attachments/assets/64f9b253-8eb4-4641-b8e3-fdb916899d54" />

</p>

---

## 📚 Courses & Schedule

<p align="center">
<img width="700" alt="Course-Catalogue" src="https://github.com/user-attachments/assets/de4f8eab-cac1-40c6-8646-7dd7513f027a" />
</p>

<br/>

<p align="center">
<img width="420" alt="Class-Schedule" src="https://github.com/user-attachments/assets/31feee3d-85da-4706-8cdf-afdff67e9bf9" />
&nbsp;&nbsp;&nbsp;&nbsp;
<img width="420" alt="All-Courses" src="https://github.com/user-attachments/assets/495eb1ad-b97d-4a33-ab6e-5278d4c76be8" />
</p>

---

## 📄 Transcript Viewer

<p align="center">
  <img width="428" height="361" alt="Transcript" src="https://github.com/user-attachments/assets/89040b62-304f-4395-88e6-14a3492e0805" />

</p>

---

# 🛠 Tech Stack

<div align="center">

| Layer          | Technologies              |
| -------------- | ------------------------- |
| 🎨 Frontend    | HTML5 • CSS3 • JavaScript |
| ⚙️ Backend     | Node.js • Express.js      |
| 🗄️ Database   | MySQL • phpMyAdmin        |
| 🔌 API Testing | Postman                   |
| 🧠 ER Modeling | draw.io                   |
| 💻 Development | VS Code                   |

<br/>

<img src="https://skillicons.dev/icons?i=html,css,js,nodejs,express,mysql,vscode,github" />

</div>

---

# 🤝 Contribution

This project was developed as part of the **Database Systems Lab** course at **FAST-NUCES**.

Contributions and suggestions are welcome for educational purposes.

```bash
Fork the repository
Create a feature branch
Commit changes
Open a pull request
```

---

# 📜 License

This project is developed strictly for academic and educational purposes.

© 2025 FAST-NUCES — Group 13

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&height=140&color=0:9333ea,50:7c3aed,100:2563eb&section=footer"/>

# ⭐ If you found this project helpful, consider starring the repository!

### Made with ❤️ by Group 13 — FAST-NUCES

**Ibrahim Khatak** • **Malik Muhammad Sanaullah**

<br/>

<img src="https://img.shields.io/badge/Database%20Systems-Lab-blueviolet?style=for-the-badge"/>
<img src="https://img.shields.io/badge/FAST--NUCES-Spring%202025-2563eb?style=for-the-badge"/>

</div>
```
