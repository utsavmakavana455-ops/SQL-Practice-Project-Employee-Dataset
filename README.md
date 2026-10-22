# 🗄️ SQL Practice — Employee Dataset

A hands-on SQL practice project using a **200-row employee dataset**, covering beginner to advanced SQL concepts.



## 📊 Dataset

The `employees_200` table contains **200 employees**.

| Column | Description |
|---|---|
| `employee_id` | Unique employee ID |
| `name` | Employee name |
| `department_id` | Department ID |
| `salary` | Employee salary |
| `hire_date` | Hiring date |

Departments:

| ID | Department |
|---|---|
| 101 | Engineering |
| 102 | Sales |
| 103 | Finance |
| 104 | Human Resources |
| 105 | Marketing |

## 🛠️ Create Tables

```sql
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees_200 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

Import `departments.csv` first, followed by `employees_200.csv`.

Verify the data:

```sql
SELECT * FROM employees_200;

SELECT COUNT(*) AS total_employees
FROM employees_200;
```

Expected employee count: **200**

## 🟢 Basic SQL

```sql
-- All employees
SELECT * FROM employees_200;

-- Employees earning more than 70,000
SELECT *
FROM employees_200
WHERE salary > 70000;

-- Sort by highest salary
SELECT *
FROM employees_200
ORDER BY salary DESC;

-- Employees hired after 2023
SELECT *
FROM employees_200
WHERE hire_date > '2023-01-01';

-- Total employees
SELECT COUNT(*) AS total_employees
FROM employees_200;
```

## 🟡 Aggregate & GROUP BY

```sql
-- Highest, lowest and average salary
SELECT
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary,
    AVG(salary) AS average_salary
FROM employees_200;

-- Employees per department
SELECT department_id, COUNT(*) AS total_employees
FROM employees_200
GROUP BY department_id;

-- Average salary per department
SELECT department_id, AVG(salary) AS average_salary
FROM employees_200
GROUP BY department_id;

-- Departments with more than 35 employees
SELECT department_id, COUNT(*) AS total_employees
FROM employees_200
GROUP BY department_id
HAVING COUNT(*) > 35;
```

## 🔵 JOIN

```sql
SELECT
    e.name,
    d.department_name,
    e.salary
FROM employees_200 e
JOIN departments d
    ON e.department_id = d.department_id;
```

## 🟠 Subqueries

Employees earning more than the company average:

```sql
SELECT *
FROM employees_200
WHERE salary > (
    SELECT AVG(salary)
    FROM employees_200
);
```

Second-highest distinct salary:

```sql
SELECT MAX(salary) AS second_highest_salary
FROM employees_200
WHERE salary < (
    SELECT MAX(salary)
    FROM employees_200
);
```

## 🔴 Window Functions

Rank employees by salary:

```sql
SELECT
    name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees_200;
```

Rank employees within each department:

```sql
SELECT
    name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees_200;
```

Top 3 salaries in each department:

```sql
WITH ranked_employees AS (
    SELECT
        name,
        department_id,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees_200
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 3;
```

## 🚀 Practice Challenges

1. Find the second-highest-paid employee in each department.
2. Find the top 5 highest-paid employees.
3. Find the department with the highest average salary.
4. Find employees earning above the company average but below 100,000.
5. Count employees hired each year.
6. Find the highest-paid employee in each department.
7. Calculate the difference between each employee's salary and their department average.
8. Find employees in the top 10 distinct salaries.
9. Rank departments by average salary.

## 🧠 Skills Practiced

`SELECT` • `WHERE` • `ORDER BY` • `GROUP BY` • `HAVING` • `JOIN` • `COUNT()` • `AVG()` • `MIN()` • `MAX()` • Subqueries • CTEs • `RANK()` • `DENSE_RANK()` • Window Functions

## 💻 Technologies

- MySQL
- MySQL Workbench
- CSV
- Git
- GitHub

## 🎯 Goal

Build practical SQL and data-analysis skills by progressing from basic queries to interview-style problems involving **joins, subqueries, CTEs, and window functions**.

## ⭐ Support

If this project helps you practice SQL, consider giving the repository a ⭐.
