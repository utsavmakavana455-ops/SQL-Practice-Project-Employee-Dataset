
# 21. Find the second-highest distinct salary.

SELECT MAX(salary) AS second_highest_salary
FROM employees_200
WHERE salary < (
    SELECT MAX(salary)
    FROM employees_200
);


#22. Rank all employees by salary from highest to lowest.
SELECT name,
       salary,
       RANK() OVER (
           ORDER BY salary DESC
       ) AS salary_rank
FROM employees_200;

# 23. Rank employees by salary within their department.

SELECT name,
       department_id,
       salary,
       RANK() OVER (
           PARTITION BY department_id
           ORDER BY salary DESC
       ) AS salary_rank
FROM employees_200;

# 24. Find the top 3 salaries in each department.
WITH ranked_employees AS (
    SELECT name,
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

# 25. Find employees earning more than their own department's average salary.

SELECT e.name,
       e.department_id,
       e.salary
FROM employees_200 e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees_200 e2
    WHERE e2.department_id = e.department_id
);
