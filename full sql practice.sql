CREATE DATABASE sql_practice;
USE sql_practice;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments (department_id, department_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing'),
(6, 'Operations');

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    city VARCHAR(50),
    joining_date DATE,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees
(employee_id, employee_name, department_id, salary, city, joining_date, manager_id)
VALUES
(1,  'Arun',    1, 75000, 'Bangalore', '2021-01-15', NULL),
(2,  'Priya',   1, 85000, 'Chennai',   '2020-06-20', 1),
(3,  'Rahul',   1, 65000, 'Bangalore', '2022-03-10', 1),
(4,  'Sneha',   2, 55000, 'Mumbai',    '2021-08-12', NULL),
(5,  'Kiran',   2, 62000, 'Delhi',     '2020-11-05', 4),
(6,  'Anita',   3, 90000, 'Bangalore', '2019-04-18', NULL),
(7,  'Vikram',  3, 70000, 'Chennai',   '2022-01-25', 6),
(8,  'Meena',   3, 80000, 'Mumbai',    '2021-07-14', 6),
(9,  'Rohan',   4, 50000, 'Delhi',     '2023-02-10', NULL),
(10, 'Divya',   4, 68000, 'Bangalore', '2020-09-22', 9),
(11, 'Suresh',  4, 72000, 'Chennai',   '2019-12-11', 9),
(12, 'Pooja',   5, 60000, 'Mumbai',    '2022-06-30', NULL),
(13, 'Amit',    5, 78000, 'Delhi',     '2021-05-19', 12),
(14, 'Neha',    5, 55000, 'Bangalore', '2023-01-08', 12),
(15, 'Manoj',   6, 65000, 'Chennai',   '2020-03-16', NULL),
(16, 'Kavya',   6, 85000, 'Bangalore', '2019-10-21', 15),
(17, 'Ravi',    6, 58000, 'Mumbai',    '2022-08-09', 15),
(18, 'Isha',    NULL, 48000, 'Delhi',   '2023-04-15', NULL);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    product_name VARCHAR(50),
    quantity INT,
    sales_amount DECIMAL(10,2),
    sale_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO sales
(sale_id, employee_id, product_name, quantity, sales_amount, sale_date)
VALUES
(101, 1,  'Laptop',     2, 110000, '2026-01-05'),
(102, 2,  'Laptop',     3, 180000, '2026-01-08'),
(103, 3,  'Mouse',      5, 5000,   '2026-01-10'),
(104, 4,  'Keyboard',   4, 8000,   '2026-01-12'),
(105, 5,  'Monitor',    2, 30000,  '2026-01-15'),
(106, 6,  'Laptop',     4, 220000, '2026-01-18'),
(107, 7,  'Mouse',      8, 8000,   '2026-01-20'),
(108, 8,  'Printer',    2, 40000,  '2026-01-22'),
(109, 9,  'Keyboard',   6, 12000,  '2026-01-24'),
(110, 10, 'Laptop',     2, 120000, '2026-01-26'),
(111, 11, 'Monitor',    3, 45000,  '2026-01-28'),
(112, 12, 'Mouse',      10, 10000,  '2026-02-02'),
(113, 13, 'Laptop',     3, 165000, '2026-02-05'),
(114, 14, 'Keyboard',   5, 10000,  '2026-02-08'),
(115, 15, 'Printer',    4, 80000,  '2026-02-10'),
(116, 16, 'Laptop',     5, 275000, '2026-02-12'),
(117, 17, 'Mouse',      6, 6000,   '2026-02-15'),
(118, 1,  'Monitor',    2, 30000,  '2026-02-18'),
(119, 2,  'Printer',    1, 20000,  '2026-02-20'),
(120, 6,  'Laptop',     2, 110000, '2026-02-22');

select * from employees;
select * from departments;
select * from sales;

select employee_name,salary from employees
where salary > 
(select avg(salary) from employees);

select employee_name from employees
where salary = (
select max(salary) as max_salary from employees);

select * from employees;

select employee_name,department_id from employees
where department_id = (
select department_id from employees
where employee_name = "Arun");

select employee_name,department_id from employees
where department_id = (
select department_id from employees
where employee_name = "Priya");

select employee_name,salary from employees 
where salary > (
select salary from employees
where employee_name = "Rahul");

select employee_name,salary,department_id from employees 
where department_id in (
select department_id from employees
where salary > 80000);

select employee_name,department_id,salary from employees
where department_id in (
select department_id from employees
where salary < 60000);

select emp1.employee_name,emp1.department_id,emp1.salary from employees as emp1
where emp1.salary > (
select avg(emp2.salary) from employees as emp2
where emp1.department_id = emp2.department_id);

select emp1.employee_name,emp1.department_id,emp1.salary from employees as emp1
where emp1.salary in (
select max(emp2.salary) from employees as emp2
where emp1.department_id = emp2.department_id);

select employee_name,department_id,salary from employees
where (department_id,salary) in (
select department_id,max(salary) from employees
group by department_id);

select * from employees;
select * from departments;

select emp.employee_name, dep.department_name from employees as emp
left join departments as dep
on dep.department_id = emp.department_id;

select dep.department_name,emp.employee_name from departments as dep
left join employees as emp
on emp.department_id = dep.department_id;

select sum(emp.salary) as t_salary,dep.department_name  from employees as emp
left join departments as dep
on dep.department_id = emp.department_id
group by dep.department_name;

select sum(emp.salary) as t_salary, dep.department_name from employees as emp
left join departments as dep
on dep.department_id = emp.department_id
group by dep.department_name
having t_salary > 100000;

select emp.employee_name,emp.salary ,dep.department_name from employees as emp
left join departments as dep
on dep.department_id = emp.department_id
where salary > (
select avg(salary) as avg_salary from employees);


select dep.department_name,sum(emp.salary) as t_salary from employees as emp
left join departments as dep
on dep.department_id = emp.department_id 
group by dep.department_name
having t_salary > (select avg(dept_t_salary) from (
select department_id, sum(salary) as dept_t_salary from employees
group by department_id)x);

select dep.department_name,avg(emp.salary) as avg_salary  from employees as emp
left join departments as dep
on dep.department_id = emp.department_id
group by dep.department_id
having avg_salary > (
select avg(salary) from employees);	

select sum(emp.salary) as t_salary, avg(emp.salary) as avg_salary, dep.department_name from employees as emp
left join departments as dep
on dep.department_id = emp.department_id
group by dep.department_id
having t_salary > 200000 and avg_salary > 70000;

with emp_rank as (
select employee_name,department_id,salary,
row_number()over(partition by department_id order by salary desc) as rw_num
from employees)
select employee_name,department_id,salary, rw_num from emp_rank
where rw_num <=2;

select employee_name,department_id,salary,
dense_rank()over(partition by department_id order by salary desc) as dense_rnk from employees;

with emp_rnk as (select employee_name,department_id,salary,
				dense_rank()over(partition by department_id order by salary desc) as dense_rnk from employees)
                select employee_name,department_id,salary from emp_rnk
                where dense_rnk=1;
                
		
with emp_rnk as (select employee_name,department_id,salary,
row_number()over(partition by department_id order by salary desc) as dense_rnk from employees)
select employee_name,department_id,salary from emp_rnk
where dense_rnk <=2;

with emp_rnk as (select department_id,sum(salary) as t_salary from employees
group by department_id)
select department_id,t_salary from emp_rnk
where t_salary > 200000;

with emp_rnk as (select sum(emp.salary) as t_salary,dep.department_name from employees as emp
left join departments as dep
on dep.department_id = emp.department_id
group by dep.department_id
having t_salary > 200000)
select department_name,t_salary from emp_rnk;


select emp.employee_name,dep.department_name,emp.salary from employees as emp
left join departments as dep
on dep.department_id = emp.department_id



select version();

with emp_rnk as (select emp.employee_name,dep.department_name,emp.salary, row_number()over(partition by emp.department_id order by emp.salary desc) as rw_num from employees as emp
				left join departments as dep
                on dep.department_id = emp.department_id
                ) select employee_name,department_name,salary from emp_rnk
                 where rw_num<=2;
