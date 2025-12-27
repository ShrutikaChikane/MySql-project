use db;
select * from employee_management; 

# Add a CHECK constraint to ensure salary is greater than 0.
alter table employee_management
add constraint chk_sal_pos check (SALARY>0);

# Alter the table to add an experience_years column.
ALTER TABLE employee_management
ADD experience_years INT DEFAULT 0;

# Modify the mobile_no column to allow up to 15 characters.
ALTER TABLE employee_management
MODIFY mobile_no VARCHAR(15);

# Create an index on department and salary to improve query performance.
CREATE INDEX idx_salary
ON employee_management (salary);

# Insert multiple employee records in a single query.
INSERT INTO employee_management
(employee_id, employee_name, email, mobile_no, department, role, salary, joining_date, city, status, 
experience_years)
VALUES
(12001, 'Priya Patil', 'priya.patil@gmail.com', '9123456789',
 'HR', 'HR Executive', 45000, '2022-04-10', 'Mumbai', 'Active', 4),

(12002, 'Rahul Verma', 'rahul.verma@gmail.com', '9988776655',
 'Finance', 'Financial Analyst', 55000, '2021-08-20', 'Delhi', 'Active', 5),

(12003, 'Sneha Kulkarni', 'sneha.k@gmail.com', '8899776655',
 'Sales', 'Sales Associate', 40000, '2023-01-12', 'Bengaluru', 'Active', 2);
 
# Update salary by 10% for all employees in the IT department.
UPDATE employee_management
SET salary = salary * 1.10
WHERE department = 'IT';

# Update employee status to Inactive for employees who left the company.
UPDATE employee_management
SET status = 'Inactive'
WHERE joining_date < '2020-01-01';

# Retrieve all employee details.
SELECT *
FROM employee_management;

# Retrieve employee name, department, and salary only.
SELECT employee_name, department, salary
FROM employee_management;

# Fetch employees working in HR department.
SELECT *
FROM employee_management
WHERE department = 'HR';

# Fetch distinct department names.
SELECT DISTINCT department
FROM employee_management;

# Retrieve top 10 highest paid employees.
SELECT * FROM employee_management
ORDER BY salary DESC
LIMIT 10;

# Fetch employees whose salary is between 40,000 and 80,000.
SELECT * FROM employee_management
WHERE salary BETWEEN 40000 AND 80000;

# Fetch employees working in IT, HR, or Finance departments.
SELECT * FROM employee_management
WHERE department IN ('IT', 'HR', 'Finance');

# Fetch employees whose name starts with ‘A’.
SELECT * FROM employee_management
WHERE employee_name LIKE 'A%';

# Fetch employees whose email is NULL.
SELECT * FROM employee_management
WHERE email IS NULL;

# Fetch employees who joined after 2022.
SELECT * FROM employee_management
WHERE joining_date > '2022-12-31';

# Find total number of employees in the company.
SELECT COUNT(*) AS total_employees
FROM employee_management;

# Find total salary paid to all employees.
SELECT SUM(salary) AS total_salary
FROM employee_management;

# Find average salary of employees.
SELECT AVG(salary) AS avg_salary
FROM employee_management;

# Find minimum and maximum salary.
SELECT 
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employee_management;

# Find department-wise employee count.
SELECT department, COUNT(*) AS employee_count
FROM employee_management
GROUP BY department;

# Find department-wise average salary and sort it in descending order.
SELECT department, AVG(salary) AS avg_salary
FROM employee_management
GROUP BY department
ORDER BY avg_salary DESC;

#  Find employees whose salary is above the company’s average salary.
SELECT *
FROM employee_management
WHERE salary > (
SELECT AVG(salary)
FROM employee_management );

# Find top 3 highest paid employees in each department.
SELECT *
FROM (
SELECT *, DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employee_management) ranked
WHERE salary_rank <= 3;

# Find city-wise employee count and display top 5 cities.
SELECT city, COUNT(*) AS employee_count
FROM employee_management
GROUP BY city
ORDER BY employee_count DESC
LIMIT 5;

# Calculate running total of salary ordered by joining date.
SELECT 
    employee_id,
    employee_name,
    joining_date,
    salary,
    SUM(salary) OVER (ORDER BY joining_date ) AS running_total_salary
FROM employee_management;

