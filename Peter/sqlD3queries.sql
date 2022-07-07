-- Rep 1: How many rows do we have in each table in the emplyees database
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;
-- Rep 2: How many employees with the first name "Mark" do we have in our company?
SELECT COUNT(*) FROM `employees` WHERE first_name = "Mark"; 
-- Rep 3: How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?
SELECT COUNT(*) FROM `employees` WHERE first_name = "Eric" AND last_name LIKE "A%"; 
-- Rep 4: How many employees do we have that are working for us since 1985 and who are they?
--only names no counting 
SELECT first_name, last_name FROM `employees` WHERE `hire_date` like "1985%"
--result
   Showing rows 0 - 24 (35316 total, Query took 0.0139 seconds.)
--names and counting
SELECT count(*) from employees UNION SELECT `first_name` FROM `employees` WHERE `hire_date` like "1985%"; 
--result
   Showing rows 0 - 24 (1276 total, Query took 0.1506 seconds.)
-- Rep 5: How many employees got hired from 1990 until 1997 and who are they?
SELECT COUNT(*) FROM `employees` WHERE hire_date > '1990-01-01' AND hire_date < '1997-12-31' UNION SELECT first_name FROM `employees`; 
SELECT COUNT(*) FROM `employees` WHERE hire_date BETWEEN '1990-01-01' AND '1997-12-31'; 
--result
   Showing rows 0 - 24 (1276 total, Query took 0.2682 seconds.)
-- Rep 6:How many employees have salaries higher than EUR 70 000,00 and who are they? 
SELECT COUNT(*) FROM `employees` WHERE `emp_no` IN(SELECT emp_no from salaries WHERE salary > 70000); 
--result (same result with DISTINCT)
Your SQL query has been executed successfully.
135631	
--
SELECT `first_name`,`last_name` FROM `employees` WHERE `emp_no` IN(SELECT DISTINCT emp_no from salaries WHERE salary > 70000);
--result
   Showing rows 0 - 24 (135631 total, Query took 0.0003 seconds.)
-- Rep 7: How many employees do we have in the Research Department, who are working for us since 1992 and who are they?
-- TIP: You can use the CURRENT_DATE() FUNCTION to access today's date
--part1
SELECT COUNT(*) FROM `dept_emp` WHERE `dept_no` = "d008"; 
--full?
SELECT COUNT(*) FROM `employees` WHERE `emp_no` IN(SELECT emp_no from dept_emp WHERE dept_no ="d008"); 
--result
Your SQL query has been executed successfully.
21126	
--
SELECT `first_name`, `last_name` FROM `employees` WHERE `emp_no` IN(SELECT emp_no from dept_emp WHERE dept_no ="d008");
--result
   Showing rows 0 - 24 (21126 total, Query took 0.0058 seconds.)
-- Rep 8: How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?
-- part 1
SELECT COUNT(*) FROM `employees` WHERE `emp_no` IN(SELECT emp_no from dept_emp WHERE dept_no ="d002"AND `from_date`LIKE "1985%" AND to_date >= CURRENT_DATE() ); 
-----------------------wrong
-- SELECT COUNT(*) FROM `employees` WHERE `emp_no` IN
-- (SELECT dept_emp.emp_no, salaries.emp_no from dept_emp,salaries WHERE dept_no ="d002" 
--  AND `from_date`LIKE "1985%" AND to_date > CURRENT_DATE() 
-- AND salary > 75000 ) ; 
-------not working
-- SELECT COUNT(*) FROM `employees` WHERE `emp_no` IN
-- (SELECT dept_emp.emp_no, salaries.emp_no from dept_emp,salaries WHERE dept_emp.dept_no ="d002" 
--  AND dept_emp.from_date LIKE "1985%" AND dept_emp.to_date > CURRENT_DATE() 
-- AND salaries.salary > 75000 ) ; 
-------------------------------
--full
SELECT COUNT(*) FROM `employees` WHERE `emp_no` IN(SELECT emp_no from dept_emp WHERE dept_no ="d002"AND `from_date`LIKE "1985%" AND to_date >= CURRENT_DATE()) AND emp_no in (SELECT emp_no from salaries WHERE salary > 75000); 
-- Rep 9: We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.
--try 1
SELECT employees.first_name, employees.last_name, employees.birth_date, employees.gender, titles.title, salaries.salary 
FROM employees,titles,salaries
WHERE salaries.to_date > CURRENT_DATE
--try 2
SELECT DISTINCT `employees`.`first_name`, `employees`.`last_name`, `employees`.`birth_date`, `employees`.`gender`, `employees`.`hire_date`, `titles`.`title`, `salaries`.`salary`
FROM `employees` 
	LEFT JOIN `titles` ON `titles`.`emp_no` = `employees`.`emp_no` 
	LEFT JOIN `salaries` ON `salaries`.`emp_no` = `employees`.`emp_no`
WHERE `salaries`.`to_date` >= 'CURRENT_DATE';

-- Rep 10:  We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.

-- Bonus:   Create a query that will join all tables and show all data from all tables.

-- Next step:  Now you should create at least 5 queries on your own, try to use data from more than 2 tables.












