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