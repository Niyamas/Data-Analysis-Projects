/* Create an SQL stored procedure that will allow you to obtain the average male and female salary per department within a certain salary range.alter
Let this range be defined by two values the user can insert when calling the procedure. Finally, visualize the obtained result-set in Tableau as a double bar chart. */

/* "There have not been many people who have earned less than $50,000 or more than $90,000"
To have data that is less skewed: exclude <$50,000 and exclude >$90,000 */

USE employees_mod;

SELECT * FROM t_employees;
SELECT * FROM t_dept_emp;
SELECT * FROM t_departments;
SELECT * FROM t_salaries;

-- My solution

DROP PROCEDURE IF EXISTS average_salary;

DELIMITER $$

CREATE PROCEDURE average_salary(IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN

	SELECT
		e.gender,
		d.dept_name,
		ROUND(AVG(s.salary), 2) AS average_salary
	FROM
		t_salaries s
			JOIN
		t_employees e ON s.emp_no = e.emp_no
			JOIN
		t_dept_emp de ON e.emp_no = de.emp_no
			JOIN
		t_departments d ON de.dept_no = d.dept_no
	WHERE s.salary BETWEEN p_min_salary AND p_max_salary
	GROUP BY e.gender, d.dept_name
	ORDER BY d.dept_name;

END$$

DELIMITER ;

CALL average_salary(50000, 90000);


-- Solution

DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$

CREATE PROCEDURE filter_salary(IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN

	SELECT
		e.gender,
		d.dept_name,
		AVG(s.salary) AS average_salary
	FROM
		t_salaries s
			JOIN
		t_employees e ON s.emp_no = e.emp_no
			JOIN
		t_dept_emp de ON e.emp_no = de.emp_no
			JOIN
		t_departments d ON de.dept_no = d.dept_no
	WHERE s.salary BETWEEN p_min_salary AND p_max_salary
	GROUP BY e.gender, d.dept_no
	ORDER BY d.dept_name;

END$$

DELIMITER ;

CALL filter_salary(50000, 90000);