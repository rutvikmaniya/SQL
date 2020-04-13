--1
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM employees 
WHERE SALARY > 
(SELECT salary FROM employees WHERE last_name = 'Bull')

--2
SELECT first_name, last_name 
FROM employees 
WHERE department_id 
IN (SELECT department_id FROM departments WHERE department_name='IT')

--3
SELECT first_name, last_name FROM employees 
WHERE manager_id in (select employee_id 
FROM employees WHERE department_id 
IN (SELECT department_id FROM departments WHERE location_id 
IN (select location_id from locations where country_name='United States')));

--4
--self refferance
SELECT first_name, last_name 
FROM employees 
WHERE (employee_id IN (SELECT manager_id FROM employees));

--5
SELECT first_name, last_name, salary FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

--6
SELECT first_name, last_name, salary 
FROM employees 
WHERE employees.salary = (SELECT min_salary
FROM jobs
WHERE employees.job_id = jobs.job_id);

--7
SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id IN 
(SELECT department_id FROM departments WHERE department_name LIKE 'IT%') 
AND salary > (SELECT avg(salary) FROM employees);

--8
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 
(SELECT salary FROM employees WHERE last_name = 'Bell') ORDER BY first_name;

--9
SELECT * FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees);

--10
SELECT * FROM employees 
WHERE salary > 
ALL(SELECT avg(salary)FROM employees GROUP BY department_id);

--11
SELECT first_name,last_name, job_id, salary 
FROM employees 
WHERE salary > 
ALL (SELECT salary FROM employees WHERE job_id = 'SH_CLERK') ORDER BY salary;

--12
SELECT b.first_name,b.last_name 
FROM employees b 
WHERE NOT EXISTS (SELECT 'X' FROM employees a WHERE a.manager_id = b.employee_id);

--13
SELECT employee_id, first_name, last_name, 
(SELECT department_name FROM departments d
 WHERE e.department_id = d.department_id) department 
 FROM employees e ORDER BY department;

--14
SELECT employee_id, first_name 
FROM employees AS A 
WHERE salary > 
(SELECT AVG(salary) FROM employees WHERE department_id = A.department_id);

--15
SET @i = 0; 
SELECT i, employee_id 
FROM (SELECT @i := @i + 1 AS i, employee_id FROM employees)
a WHERE MOD(a.i, 2) = 0;

--16
SELECT DISTINCT salary 
FROM employees e1 
WHERE 5 = (SELECT COUNT(DISTINCT salary) 
FROM employees  e2 
WHERE e2.salary >= e1.salary);

--17
SELECT DISTINCT salary 
FROM employees e1 
WHERE 4 = (SELECT COUNT(DISTINCT salary) 
FROM employees  e2 
WHERE e2.salary <= e1.salary);

--18
SELECT * FROM (
SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10) sub 
ORDER BY employee_id ASC;

--19
SELECT * FROM departments 
WHERE department_id 
NOT IN (select department_id FROM employees);

--20
SELECT DISTINCT salary 
FROM employees a 
WHERE 3 >= (SELECT COUNT(DISTINCT salary) 
FROM employees b 
WHERE b.salary >= a.salary) 
ORDER BY a.salary DESC;

--21
SELECT DISTINCT salary 
FROM employees a 
WHERE  3 >= (SELECT COUNT(DISTINCT salary) 
FROM employees b 
WHERE b.salary <= a.salary) 
ORDER BY a.salary DESC;

--22


