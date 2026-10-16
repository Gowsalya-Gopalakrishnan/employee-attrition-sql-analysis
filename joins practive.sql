-- self join practice 
create database practice;

use practice;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);
INSERT INTO employees (employee_id, employee_name, manager_id)
VALUES
(1, 'Alice', NULL),
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'David', 2),
(5, 'Emma', 2),
(6, 'Frank', 3),
(7, 'Grace', 3),
(8, 'Henry', 4),
(9, 'Ivy', 4),
(10, 'Jack', 5);

select * from employees;

select emp.employee_name, emp1.employee_name as manager_name 
from employees as emp
left join employees as emp1
on emp.manager_id = emp1.employee_id;	

select emp.employee_name,emp1.employee_name as manager_name
from employees as emp
left join employees as emp1
on emp.manager_id = emp1.employee_id
where emp.manager_id is not null;

select emp1.employee_name as manager_name,emp.employee_name
from employees as emp
left join employees as emp1
on emp.manager_id = emp1.employee_id
where emp.manager_id is not null;

select emp1.employee_name as manager_name from employees as emp
left join employees as emp1
on emp.manager_id = emp1.employee_id
where emp.employee_name = "Henry";

select emp1.employee_name as manager_name from employees as emp
left join employees as emp1
on emp.manager_id = emp1.employee_id
where emp.employee_name = "Jack";

select emp.employee_name from employees as emp
left join employees as emp1
on emp.manager_id = emp1.employee_id
where emp1.employee_name = "David";

