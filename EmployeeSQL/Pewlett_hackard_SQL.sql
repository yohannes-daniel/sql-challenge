DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;


CREATE TABLE IF NOT EXISTS "departments" (
    "dept_no" varchar(50)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);
SELECT * FROM departments;

CREATE TABLE IF NOT EXISTS "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(50)   NOT NULL
);
SELECT * FROM dept_emp;

CREATE TABLE IF NOT EXISTS "dept_manager" (
    "dept_no" varchar(50)   NOT NULL,
    "emp_no" int   NOT NULL
);
SELECT * FROM dept_manager;

CREATE TABLE IF NOT EXISTS "employees" (
    "emp_no" int   NOT NULL,
    "title_id" varchar(50)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
SELECT * FROM employees;
-- If there's an error importing the employee dataset, use the 'ALTER DATABASE' line to accept format of the employees csv.
-- SHOW datestyle;
-- ALTER DATABASE mod_9_assignment SET datestyle to "ISO, MDY";

CREATE TABLE IF NOT EXISTS "salaries" (
    "emp_no" int   NOT NULL,
    "salary" money   NOT NULL
);
SELECT * FROM salaries;

CREATE TABLE IF NOT EXISTS "titles" (
    "title_id" varchar(50)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);
SELECT * FROM titles;


-- Data Analysis
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT 
e.emp_no,
e.last_name,
e.first_name,
e.sex,
s.salary
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT
first_name,
last_name,
hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department along with their department number, department name, employee number, last name,
-- and first name.
SELECT
d.dept_no,
d.dept_name,
e.emp_no,
e.last_name,
e.first_name

FROM employees as e
INNER JOIN dept_manager as dm
ON e.emp_no = dm.emp_no
INNER JOIN departments as d
ON dm.dept_no = d.dept_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and
-- department name.
SELECT
d.dept_no,
e.emp_no,
e.last_name,
e.first_name,
d.dept_name

FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the
-- letter B.
SELECT 
first_name,
last_name,
sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT 
e.emp_no,
e.last_name,
e.first_name,
d.dept_no

FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE d.dept_no = 'd007';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and
-- department name.
SELECT 
e.emp_no,
e.last_name,
e.first_name,
d.dept_name

FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each
-- last name).
SELECT last_name,
COUNT(*) as "Frequency"
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;

