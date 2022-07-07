--How many rows do we have in each table in the emplyees database
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;
--How many employees with the first name "Mark" do we have in our company?
SELECT COUNT(*) FROM `employees` WHERE first_name = "Mark"; 
--How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?
SELECT COUNT(*) FROM `employees` WHERE first_name = "Eric" AND last_name LIKE "A%"; 
-- How many employees do we have that are working for us since 1985 and who are they?
--only names no counting 
SELECT first_name, last_name FROM `employees` WHERE `hire_date` like "1985%"
--result
   Showing rows 0 - 24 (35316 total, Query took 0.0139 seconds.)
--names and counting
SELECT count(*) from employees UNION SELECT `first_name` FROM `employees` WHERE `hire_date` like "1985%"; 
--result
   Showing rows 0 - 24 (1276 total, Query took 0.1506 seconds.)





