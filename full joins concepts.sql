create database joinss;

use joinss;

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) UNIQUE NOT NULL,
    course_fee DECIMAL(10,2)
);

INSERT INTO courses
(course_id, course_name, course_fee)
VALUES
(101, 'Python', 15000),
(102, 'Java', 18000),
(103, 'SQL', 12000),
(104, 'Web Development', 20000),
(105, 'Data Science', 25000),
(106, 'Cloud Computing', 22000),
(107, 'Cyber Security', 24000),
(108, 'Testing', 14000);


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    course_id INT,
    marks INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students
(student_id, student_name, email, course_id, marks)
VALUES
(1, 'Aarav', 'aarav@gmail.com', 101, 85),
(2, 'Diya', 'diya@gmail.com', 102, 78),
(3, 'Rohan', 'rohan@gmail.com', 103, 92),
(4, 'Meera', 'meera@gmail.com', 101, 88),
(5, 'Kabir', 'kabir@gmail.com', 104, 75),
(6, 'Anika', 'anika@gmail.com', 105, 95),
(7, 'Ishaan', 'ishaan@gmail.com', 106, 81),
(8, 'Tara', 'tara@gmail.com', 107, 89),
(9, 'Aditya', 'aditya@gmail.com', NULL, 70),
(10, 'Nisha', 'nisha@gmail.com', NULL, 65);

select * from courses;
select * from students;

-- inner join 
select stu.student_name,cours.course_name from students as stu
inner join courses as cours
on stu.course_id = cours.course_id;

-- left join
select stu.student_name,cours.course_name from students as stu
left join courses as cours
on stu.course_id = cours.course_id;

-- right join
select stu.student_name,cours.course_name from students as stu
right join courses as cours
on stu.course_id = cours.course_id;

-- full join union
(select stu.student_name,cours.course_name from students as stu
left join courses as cours
on stu.course_id = cours.course_id)
union
(select stu.student_name,cours.course_name from students as stu
right join courses as cours
on stu.course_id = cours.course_id);

--  full join union all
(select stu.student_name,cours.course_name from students as stu
left join courses as cours
on stu.course_id = cours.course_id)
union all
(select stu.student_name,cours.course_name from students as stu
right join courses as cours
on stu.course_id = cours.course_id);

-- natural joins 
-- both table has course id instead of left join it will use directly
-- dont have common cols it will behave like a cross join
select stu.student_name,cours.course_name 
from students as stu
natural join courses as cours;

-- It combines every row from the first table with every row from the second table.
-- 10 * 8 = 80
-- CROSS JOIN
select stu.student_name,cours.course_name
from students as stu
cross join courses as cours;

-- there no cols is refer the another students in the above two tables so i updated with 
-- mentor id to students table then will perform the self join 

-- added mentor id col
alter table students
add mentor_id int;

select * from students;

update students set mentor_id = NULL where student_id = 1;
update students set mentor_id = 1 where student_id = 2;
update students set mentor_id = 1 where student_id =3;
update students set mentor_id = 2 where student_id = 4;
update students set mentor_id = 2 where student_id = 5;
update students set mentor_id = 3 where student_id = 6;
update students set mentor_id = 3 where student_id =7;
update students set mentor_id = 4 where student_id = 8;
update students set mentor_id = 5 where student_id = 9;
update students set mentor_id = 6 where student_id = 10;

select* from students;

-- self join
select stu.student_id, stu.student_name, ment.student_name as mentor_name 
from students as stu
left join students as ment
on stu.mentor_id = ment.student_id;



select cours.course_name, count(stu.student_name) as count_stu
from students as stu
left join courses as cours
on stu.course_id = cours.course_id
group by cours.course_name;

select cours.course_name,avg(stu.marks) as avg_mark
from students as stu
left join courses as cours
on stu.course_id = cours.course_id
group by cours.course_name;


select cours.course_name,avg(stu.marks) as avg_mark
from students as stu
left join courses as cours
on stu.course_id = cours.course_id
group by cours.course_name
order by avg_mark desc
limit 1;

select stu.student_name,cours.course_id
from students as stu
left join courses as cours
on stu.course_id = cours.course_id
where cours.course_id is null;

