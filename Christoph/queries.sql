--1. Report: How many rows do we have in each table in the employees database?--

SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;

--these queries return the amount of rows in each table
--departments: 9
--dept_emp: 331603
--dept_manager: 24
--employees: 300024
--salaries: 2844047
--titles: 443308

--2. Report: How many employees with the first name "Mark" do we have in our company?

SELECT COUNT(*) FROM `employees` 
WHERE first_name = "Mark";

--this query returns the number of rows that contain the first Name "Mark"
--running this query will give us the result 230

--3. Report: How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?

SELECT COUNT(*) FROM `employees` 
WHERE first_name = "Eric" 
AND last_name LIKE 'A%';

--this time we need a 2nd condition that we can link with the AND clause to the first one
--running this query will give us a count of 13 Erics whose last name starts with an A

--4. Report: How many employees do we have that are working for us since 1985 and who are they?

SELECT COUNT(*) FROM `employees` 
WHERE hire_date < '1985-12-31';

--shows us the count of employees hired in 1985 or earlier
--the returned value is 35225

SELECT first_name, last_name FROM `employees` 
WHERE hire_date < '1985-12-31';

--same query as before, except this time we return the employees first and last names instead of the count

--5. Report: How many employees got hired from 1990 to 1997 and who are they?

SELECT COUNT(*) FROM `employees` 
WHERE hire_date > '1990-01-01' 
AND hire_date < '1997-12-31';

--very similar to the last one, except this time we need an AND clause to narrow down the timeframe
--the returned count is 129470


SELECT first_name, last_name FROM `employees` 
WHERE hire_date > '1990-01-01' 
AND hire_date < '1997-12-31';

--we run the same query again and choose to return the first and last name this time to get a list of these employees

--6. Report: How many employees have salaries higher than 70000 EUR and who are they?

SELECT COUNT(*) FROM employees
WHERE emp_no IN (SELECT emp_no FROM salaries
                 WHERE salary > 70000);

--with a subquery we can check the salaries table for employees with salaries higher than 70000 and only return those
--135631 employees have earned a salary of higher than 70000
--using the same subquery with a different SELECT will give us a list of these employees again

SELECT first_name, last_name FROM employees
WHERE emp_no IN (SELECT emp_no FROM salaries
                 WHERE salary > 70000);


--7. Report: How many employees do we have in the Research Department, who are working for us since 1992 and who are they?


SELECT COUNT(*) FROM `employees` 
WHERE emp_no IN (SELECT emp_no FROM dept_emp 
                WHERE dept_no = 'd008' 
                AND from_date < '1993-01-01' 
                AND to_date > CURRENT_DATE() 
                );

SELECT first_name, last_name FROM `employees`
WHERE emp_no IN (SELECT emp_no FROM dept_emp
                 WHERE dept_no = 'd008' AND from_date < '1993-01-01' AND to_date > CURRENT_DATE()
                 );

--8. Report: How many employees do we have in the Finance Department, who are working for us since 1985 until now and have salaries higher than EUR 75,000 - who are they?

SELECT COUNT(*) FROM `employees`
WHERE emp_no IN (SELECT emp_no FROM `dept_emp`
                 WHERE from_date LIKE '1985%'
                 AND to_date > CURRENT_DATE)
=
emp_no IN (SELECT DISTINCT emp_no FROM salaries
           WHERE salary > 7500);

SELECT first_name, last_name FROM `employees`
WHERE emp_no IN (SELECT emp_no FROM `dept_emp`
                 WHERE from_date LIKE '1985%'
                 AND to_date > CURRENT_DATE)
=
emp_no IN (SELECT DISTINCT emp_no FROM salaries
           WHERE salary > 7500);

--9. Report:  We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.

SELECT DISTINCT first_name, last_name, birth_date, gender, hire_date, title, salary FROM `employees`
INNER JOIN `titles` ON titles.emp_no = employees.emp_no
INNER JOIN `salaries` ON salaries.emp_no = employees.emp_no
WHERE employees.emp_no IN (SELECT dept_emp.emp_no FROM `dept_emp`
                 WHERE to_date > CURRENT_DATE);

--not a very pretty solution, since this will give out multiple entries per employee for ALL their salaries they have received so far

--10. Report:  We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.

SELECT first_name, last_name, birth_date, gender, hire_date, title, dept_name, salary
FROM `employees`
INNER JOIN `titles` ON employees.emp_no = titles.emp_no
INNER JOIN `salaries` ON employees.emp_no = salaries.emp_no
INNER JOIN `dept_manager` ON employees.emp_no = dept_manager.emp_no
INNER JOIN `departments` ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date > CURRENT_DATE;

--same problem as before, we get multiple entries per person for each salary they have received
