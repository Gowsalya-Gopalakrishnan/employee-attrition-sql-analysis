create database hr_attrition;

use hr_attrition;

show tables;
SELECT DISTINCT Attrition FROM employee_raw;

drop database hr_attrition;

create database hr_attrition;

use hr_attrition;

show tables;

select * from employee_raw;
select count(*) from employee_raw;

select distinct Attrition from employee_raw;

CREATE TABLE departments (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(50) UNIQUE
);
INSERT INTO departments (dept_name)
SELECT DISTINCT Department FROM employee_raw;

CREATE TABLE employees AS
SELECT r.EmployeeID, d.dept_id, r.Age, r.JobLevel, r.YearsAtCompany,
       r.MonthlyIncome, r.JobSatisfaction, r.WorkLifeBalance, r.OverTime,
       r.DistanceFromHome, r.PromotionLast5Years, r.PerformanceRating,
       r.TrainingHoursLastYear, r.Attrition
FROM employee_raw r
JOIN departments d ON r.Department = d.dept_name;

-- attrition rate by department
SELECT d.dept_name, COUNT(*) AS total_employees,
       ROUND(100 * SUM(e.Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY attrition_pct DESC;

-- average income by job level 
SELECT JobLevel, ROUND(AVG(MonthlyIncome), 0) AS avg_income
FROM employees GROUP BY JobLevel ORDER BY JobLevel;

-- earnings above department average
SELECT e.EmployeeID, e.MonthlyIncome, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.MonthlyIncome > (
  SELECT AVG(MonthlyIncome) FROM employees WHERE dept_id = e.dept_id);
  
-- high risk employees
CREATE VIEW high_risk_employees AS
SELECT EmployeeID, dept_id, JobSatisfaction, OverTime, Attrition
FROM employees
WHERE OverTime = 'Yes' AND JobSatisfaction <= 2;

-- attrition by tenure brand
SELECT CASE WHEN YearsAtCompany <= 2 THEN '0-2 yrs'
            WHEN YearsAtCompany <= 5 THEN '3-5 yrs'
            ELSE '5+ yrs' END AS tenure_band,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees GROUP BY tenure_band;

-- overtime vs no over time
SELECT OverTime,
       ROUND(100 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS attrition_pct
FROM employees GROUP BY OverTime;