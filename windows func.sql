use sales_of_jan;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    joining_date DATE,
    city VARCHAR(30)
);
INSERT INTO employees
(employee_id, employee_name, department, salary, joining_date, city)
VALUES
(1, 'Rahul',  'IT',      75000, '2021-01-15', 'Bangalore'),
(2, 'Priya',  'HR',      55000, '2020-06-20', 'Mumbai'),
(3, 'Amit',   'IT',      85000, '2019-03-10', 'Delhi'),
(4, 'Sneha',  'Finance', 70000, '2022-02-18', 'Bangalore'),
(5, 'Vikram', 'IT',      75000, '2023-05-12', 'Chennai'),
(6, 'Neha',   'HR',      60000, '2021-08-25', 'Delhi'),
(7, 'Arjun',  'Finance', 80000, '2020-11-05', 'Mumbai'),
(8, 'Kavya',  'IT',      90000, '2018-07-30', 'Bangalore'),
(9, 'Rohan',  'Sales',   50000, '2022-09-14', 'Chennai'),
(10, 'Anjali', 'Sales',   65000, '2021-04-22', 'Delhi'),
(11, 'Karan',  'IT',      75000, '2020-01-10', 'Mumbai'),
(12, 'Pooja',  'Finance', 72000, '2019-12-15', 'Chennai'),
(13, 'Suresh', 'Sales',   55000, '2023-01-20', 'Bangalore'),
(14, 'Meena',  'HR',      65000, '2022-06-10', 'Mumbai'),
(15, 'Raj',    'Finance', 85000, '2018-10-25', 'Delhi'),
(16, 'Divya',  'Sales',   70000, '2020-05-18', 'Bangalore'),
(17, 'Manoj',  'IT',      68000, '2022-03-30', 'Chennai'),
(18, 'Swati',  'HR',      50000, '2023-07-15', 'Bangalore'),
(19, 'Nitin',  'Sales',   60000, '2019-08-12', 'Mumbai'),
(20, 'Riya',   'Finance', 75000, '2021-10-05', 'Bangalore');

select * from employees;

-- multiple rows,cols subquery
select * from employees
where (department,salary) in (select department,max(salary) as max_salary from employees
group by department); 

-- windows func 
-- row_number,rank, dense rank

select * from
(select * ,
row_number()over(order by salary desc) as rw_num
from employees) as a
where rw_num<=5;

select * from
(select * ,
row_number()over(order by salary asc) as rw_num from employees) as x
where rw_num<=5;

select * from
(select * ,
row_number()over(partition by department order by salary desc) as rw_num 
from employees) as w
where rw_num<=2;

-- 16/09
select avg(salary) as s from employees;

select department,sum(salary) as t_salary from employees
group by department;

select avg(t_salary) as avg_salary
from (select department,sum(salary) as t_salary from employees group by department)v;

select department,sum(salary) as tot_salary 
from employees
group by department
having tot_salary >= (select avg(new_total) as agg 
						from (select department,sum(salary) as new_total from employees 
						group by department)x);
                        
select * from employees;

-- 17/09
drop table employees;

select * from employees;

select * from employees
where department="IT"
order by department, salary desc;

select * ,
row_number()over(partition by department order by salary desc) as rw_num,
rank()over(partition by department order by salary desc) as rank_num,
dense_rank()over(partition by department order by salary desc) as dense_num
from employees;

select * from 
(select * ,
dense_rank()over(partition by department order by salary desc) as dense_num
from employees
where department in ("IT","Finance"))x
where dense_num <=3;

select department,count(employee_name) as emp_count
from
(select *,
dense_rank()over(partition by department order by salary desc) as dense_num
from employees
where department in ("IT","Finance"))x
where dense_num<=3
group by department;

select department,count(employee_name) as emp_counts
from
(select *,
dense_rank()over(partition by department order by salary desc) as dense_num from employees
where department in ("HR","Sales"))x
where dense_num<=3
group by department;

-- 18/09
CREATE TABLE employee_sales (
    employee_id INT,
    employee_name VARCHAR(50),
    sale_month DATE,
    sales_amount INT
);

INSERT INTO employee_sales
(employee_id, employee_name, sale_month, sales_amount)
VALUES
(101, 'Amit', '2026-01-01', 50000),
(101, 'Amit', '2026-02-01', 55000),
(101, 'Amit', '2026-03-01', 48000),
(101, 'Amit', '2026-04-01', 62000),

(102, 'Priya', '2026-01-01', 45000),
(102, 'Priya', '2026-02-01', 47000),
(102, 'Priya', '2026-03-01', 52000),
(102, 'Priya', '2026-04-01', 50000),

(103, 'Rahul', '2026-01-01', 60000),
(103, 'Rahul', '2026-02-01', 58000),
(103, 'Rahul', '2026-03-01', 65000),
(103, 'Rahul', '2026-04-01', 70000);

select * from employee_sales;

-- lead is next data 
-- lag id previous data
-- lead,lag takes three parameter col name,row how many row will i take if its 1 next row 
-- if its 2 means 1 is skipped row 2 will display, 0 means null we are getting instead of null whatever value we want we can fill with that values


select employee_id,sales_amount,sale_month,sales_amount,
		lead(sales_amount) over(partition by employee_id order by sale_month) as next_month_salary
        from employee_sales;
        
select employee_id,sales_amount,sale_month,sales_amount,
		lead(sales_amount,1,0) over(partition by employee_id order by sale_month) as next_month_salary
        from employee_sales;

 
 select *,
        (nxt_mnt_sales / sales_amount - 1) * 100 as growth
 from
 (
     select employee_id,
            employee_name,
            sales_amount,
            sale_month,
            lead(sales_amount, 1, 0) over(
                partition by employee_id
                order by sale_month
            ) as nxt_mnt_sales
     from employee_sales
 ) w;

select * from
(select *,
       (nxt_mnt_sales / sales_amount - 1) * 100 as growth
from
(
    select employee_id,
           employee_name,
           sales_amount,
           sale_month,
           lead(sales_amount, 1, 0) over(
               partition by employee_id
               order by sale_month
           ) as nxt_mnt_sales
    from employee_sales
) w)y
where growth<0;
        
-- 22/09
select * from employee_sales;

select * ,
lead(sales_amount,1,0)over(partition by employee_id order by sale_month) nxt_sales,
lag(sales_amount,1,0)over(partition by employee_id order by sale_month) prev_sales
from employee_sales;

-- case func similar like if condition as per the condition it will create new col

select *,
case
	when sales_amount >= 60000 then "Good"
    when sales_amount between 50000 and 60000 then "Avg"
    else "Low" end salary_status
from employee_sales;


select *,
lead(sales_amount, 1, 0) over(partition by employee_id order by sale_month) as nxt_mnt_sales,
case
	when sales_amount <= lead(sales_amount,1,0)over(partition by employee_id order by sale_month) then "Greater"
    else "Lower" end salary_s
from employee_sales;
 
select*,
(sales_amount/tot_sales)*100 as contri
from 
(select*,
sum(sales_amount)over(partition by employee_id) tot_sales
from employee_sales)x;

select * ,
max(sales_amount)over(partition by employee_id) mx_sales from employee_sales;

select * from 
(select *,
max(sales_amount)over(partition by employee_id) max_sales
from employee_sales)s
where sales_amount=max_sales;

select * ,
min(sales_amount)over(partition by employee_id) as min_sales from employee_sales;

select * from 
(select *, min(sales_amount)over(partition by employee_id) as min_sales from employee_sales)e
where sales_amount=min_sales;

