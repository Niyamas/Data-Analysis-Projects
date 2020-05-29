/* Create a visualization that provides a breakdown between the male and female employyes working in the company each year, starting from 1990 */

USE employees_mod;

SELECT * FROM t_employees;
SELECT * FROM t_dept_emp;

# The following shows whether there are the same number of distinct values in the query

SELECT 
    emp_no, from_date, to_date
FROM
    t_dept_emp;

SELECT DISTINCT
    emp_no, from_date, to_date
FROM
    t_dept_emp;

-- My solution

SELECT
	YEAR(de.from_date) AS calendar_year,
    e.gender,
    COUNT(e.emp_no) AS num_of_employees
FROM
	t_dept_emp de
		JOIN
	t_employees e ON de.emp_no = e.emp_no
GROUP BY calendar_year, e.gender
HAVING calendar_year >= 1990
ORDER BY calendar_year;