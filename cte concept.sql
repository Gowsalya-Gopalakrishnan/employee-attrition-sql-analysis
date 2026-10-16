
-- 30/09
-- CTE common table expression

create database cte;

use cte;

CREATE TABLE employee_sales (
    employee_name VARCHAR(50),
    products VARCHAR(50),
    dep VARCHAR(50),
    unit INT,
    sales_amount DECIMAL(10,2)
);

INSERT INTO employee_sales
(employee_name, products, dep, unit, sales_amount)
VALUES
('Rahul',  'Laptop',  'Electronics', 5, 250000.00),
('Priya',  'Phone',   'Electronics', 8, 160000.00),
('Amit',   'Tablet',  'IT',          6, 120000.00),
('Sneha',  'Laptop',  'IT',          4, 200000.00),
('Vikram', 'Phone',   'Sales',      10, 200000.00),
('Anita',  'Tablet',  'Sales',       7, 140000.00),
('Ravi',   'Laptop',  'Marketing',   3, 150000.00),
('Neha',   'Phone',   'Marketing',   9, 180000.00),
('Arjun',  'Tablet',  'HR',           5, 100000.00),
('Pooja',  'Laptop',  'HR',           2, 100000.00),
('Karan',  'Phone',   'Electronics', 6, 120000.00),
('Meena',  'Tablet',  'IT',           8, 160000.00),
('Suresh', 'Laptop',  'Sales',        5, 250000.00),
('Divya',  'Phone',   'Sales',        4,  80000.00),
('Manoj',  'Tablet',  'Marketing',    6, 120000.00),
('Kavya',  'Laptop',  'Marketing',    7, 350000.00),
('Nikhil', 'Phone',   'HR',           5, 100000.00),
('Swati',  'Tablet',  'HR',           3,  60000.00),
('Rohan',  'Laptop',  'Electronics',  4, 200000.00),
('Isha',   'Phone',   'IT',           7, 140000.00);

select * from employee_sales;

select employee_name from employee_sales
where sales_amount >= (select avg(sales_amount) as avg_sales from employee_sales);


select * from
(select * ,
row_number()over(partition by dep order by sales_amount desc) as rw_num 
from employee_sales) as w
where rw_num<=2;
 -- cte faster compare to sub queries instead of subquries mostly will go with cte concepts
 
 -- cte
 with emp_ranks as (
		select *,
        dense_rank()over(partition by dep order by sales_amount desc) as rnk
        from employee_sales)
select * from emp_ranks
where rnk<=2;


select dep,sum(sales_amount) as t_sales
from employee_sales
group by dep
having t_sales >= 
(select avg(t_sales) as avg_sales
from
(select dep,sum(sales_amount) as t_sales 
from employee_sales
group by dep)w);

-- cte is storing a table as per our wish whatever the name we want whereever we want call with that name
with dep_sales as ( 
					select dep,sum(sales_amount) as t_sales
                    from employee_sales
                    group by dep)
select *  from dep_sales
where t_sales>=(select avg(t_sales) as avg_sales from dep_sales);

