-- Task 3:
-- a
SELECT *
FROM employees;
-- b
SELECT *
FROM employees
WHERE first_name = 'David';
-- c
SELECT *
FROM employees
WHERE job_id = 'IT_PROG';
-- d
SELECT *
FROM employees
WHERE department_id = 50
  AND salary > 4000;
-- e
SELECT *
FROM employees
WHERE department_id = 20
   OR department_id = 30;
-- f
SELECT *
FROM employees
WHERE first_name REGEXP 'a$';
-- g
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
  AND (department_id = 50 OR department_id = 80);
-- h
SELECT *
FROM employees
WHERE salary >= 8000
  AND salary <= 9000;
-- i
SELECT *
FROM employees
WHERE first_name REGEXP '%'
   OR last_name REGEXP '%';
-- j
-- based on employees
SELECT e.employee_id, e.first_name, e.last_name, e.job_id
FROM employees e
         JOIN employees e2 on e.employee_id = e2.manager_id
GROUP BY e2.manager_id;


-- based on departments
SELECT d.manager_id, e.first_name, e.last_name, e.job_id
FROM departments d
         JOIN employees e on e.employee_id = d.manager_id;

-- k
SELECT employee_id, CONCAT(first_name, '(', j.job_id, ')') AS position, last_name, email, salary
FROM employees e,
     jobs j
WHERE e.job_id = j.job_id
ORDER BY employee_id;

SELECT employee_id, CONCAT(first_name, '(', j.job_id, ')') AS position, last_name, email, salary
FROM jobs j
         JOIN employees e on e.job_id = j.job_id
ORDER BY employee_id;

-- l
SELECT *
FROM employees
WHERE LENGTH(first_name) > 10;

-- m
SELECT *
FROM employees e
WHERE DAYOFMONTH(hire_date) = 1;

-- n
SELECT *
FROM employees
WHERE YEAR(hire_date) = 2000;

-- o
-- Only one person with salary > 20000
SELECT *
FROM employees
WHERE salary > 15000
   OR (salary * (1 + commission_pct)) > 15000;

-- p
SELECT employee_id,
       first_name,
       last_name,
       job_id,
       commission_pct,
       CASE
           WHEN commission_pct IS NULL THEN 'no'
           WHEN commission_pct IS NOT NULL THEN 'yes'
           END AS bonus
FROM employees;

-- q
SELECT department_id,
       MIN(salary)        AS 'Min salary',
       MAX(salary)        AS 'Max salary',
       MIN(hire_date)     AS 'Earliest Date',
       MAX(hire_date)     AS 'Latest Date',
       count(employee_id) AS 'Employees Number'
FROM employees e
GROUP BY department_id
ORDER BY count(employee_id) DESC;

-- Verification
SELECT employee_id, department_id, hire_date, salary
FROM employees
WHERE department_id = 80;

-- r
SELECT YEAR(hire_date) as 'Year', count(*) AS 'Number of People Hired'
FROM employees
GROUP BY YEAR(hire_date);

-- s
SELECT department_id AS 'Department', count(*) AS 'Number of employees'
FROM employees
GROUP BY department_id
HAVING count(*) > 30;

-- t
SELECT manager_id, COUNT(employee_id) as 'Employee Number', SUM(salary) AS 'Sum salary'
FROM employees
GROUP BY manager_id
HAVING COUNT(employee_id) > 5
   AND SUM(salary) > 50000;

-- u
-- Max salary of all employees whose first/last name ends with 's' as there are no people whose name ends with 'clerk'
SELECT SUM(salary) AS 'Max salary'
FROM employees
WHERE first_name
   OR last_name REGEXP 's$';

-- v
SELECT c.country_id, c.country_name, r.region_name
FROM countries c
         JOIN regions r on r.region_id = c.region_id;

-- w
SELECT e.employee_id, e.first_name, e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e
         JOIN departments d on d.department_id = e.department_id
WHERE d.department_name = 'IT';

-- x
SELECT e.first_name,
       e.last_name,
       d.department_name,
       j.job_title,
       l.street_address,
       c.country_name,
       r.region_name
FROM employees e
         JOIN departments d on d.department_id = e.department_id
         JOIN jobs j on j.job_id = e.job_id
         JOIN locations l on d.location_id = l.location_id
         JOIN countries c on l.country_id = c.country_id
         JOIN regions r on c.region_id = r.region_id;

-- y
SELECT e2.employee_id, e2.first_name, e2.last_name, COUNT(*) as 'Employee Number'
FROM employees e
         JOIN employees e2 ON e2.employee_id = e.manager_id
GROUP BY e2.employee_id
HAVING COUNT(e2.employee_id) > 5;

-- z
SELECT *
FROM employees
WHERE manager_id IS NULL;

-- aa
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       jh.end_date,
       CASE
           WHEN jh.end_date IS NOT NULL THEN 'Left the company'
           WHEN jh.end_date IS NULL THEN 'Currently working'
           END AS 'status'
FROM employees e
         LEFT JOIN job_history jh
                   on e.employee_id = jh.employee_id
GROUP BY e.employee_id;

-- bb
SELECT e.employee_id, e.first_name, e.last_name, r.region_name
FROM employees e
         JOIN departments d on d.department_id = e.department_id
         JOIN locations l on l.location_id = d.location_id
         JOIN countries c on l.country_id = c.country_id
         JOIN regions r on c.region_id = r.region_id
WHERE r.region_name = 'Europe';

-- cc
SELECT e.department_id AS 'Department', d.department_name, count(*) AS 'Number of employees'
FROM employees e
         JOIN departments d on d.department_id = e.department_id
GROUP BY e.department_id
HAVING count(*) > 30;

-- dd
-- based on department_id is NULL
SELECT d.department_name, d.department_id, e.department_id
FROM departments d
         LEFT JOIN employees e on d.department_id = e.department_id
WHERE e.department_id IS NULL;

-- based on number of employees in dept
SELECT d.department_name, d.department_id, employee_id, count(employee_id) AS 'Number of Employees'
FROM departments d
         LEFT JOIN employees e on d.department_id = e.department_id
GROUP BY d.department_id
HAVING count(employee_id) = 0;

-- ee
SELECT employee_id, first_name, j.job_title, d.department_name
FROM employees e
         LEFT JOIN jobs j on j.job_id = e.job_id
         LEFT JOIN departments d on d.department_id = e.department_id
ORDER BY employee_id;

-- ff
SELECT employee_id, first_name, last_name, salary
FROM employees e
HAVING salary > (SELECT AVG(salary) FROM employees);

-- gg
-- Get all employees whose manager gets salary > 15000

SELECT e2.employee_id,
       e2.first_name,
       e2.last_name,
       e2.manager_id,
       e.salary AS 'Manager Salary'
FROM employees e
         JOIN employees e2 on e.employee_id = e2.manager_id
HAVING e.salary > 15000;

-- hh
SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE employee_id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);

