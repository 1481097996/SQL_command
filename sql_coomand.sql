/*
select lists from table;
*/

# start
USE emp;

SELECT last_name FROM employees;

SELECT 'last_name', email FROM employees;

SELECT * FROM employees;

# query value
SELECT 'john';

#7. new name
SELECT 100%98 AS result;

SELECT last_name l, first_name f FROM employees; # another form

#8. Distinct
SELECT DISTINCT department_id FROM employees;

# + using string: transfer string to int then add, if fail, string ->0, if null, result null

#function concat(a,b,c)
SELECT CONCAT('a','b') AS result;
SELECT 
	CONCAT(last_name, first_name) AS emp_name
FROM
	employees;
	
# display structure table
DESC departments;

# display all as out_put with,

SELECT 
	IFNULL(commission_pct,0) AS rate, commission_pct
FROM
	employees;
	
SELECT 
	CONCAT(`first_name`,',',`last_name`,',',`email`,',',`phone_number`,',',
	IFNULL(commission_pct,0)) AS out_put
FROM
	employees;
	

# select from where

#1 where

SELECT * FROM employees WHERE salary>12000;

SELECT
	last_name,
	department_id
FROM 
	employees
WHERE department_id<>90; # !=


#2. logic expression query
/*
	like
	between and
	in
	is null
	is not null
*/
SELECT last_name,salary,commission_pct
FROM employees
WHERE salary>= 10000 AND salary<= 20000;


SELECT * FROM employees
WHERE last_name LIKE '%a%'; # include a inside last name

/*
	% 任意多个字符
	_ 任意单个字符
	
*/

SELECT last_name, salary
FROM employees
WHERE last_name LIKE '_e_'

SELECT last_name FROM employees WHERE last_name LIKE '_\_%' # second is_



SELECT 
	*
FROM 
	employees
WHERE
	employee_id BETWEEN 100 AND 120;
	
	
# in
SELECT *
FROM employees
WHERE job_id IN ('IT_PROG','AD_VP');

SELECT 
	last_name,
	commission_pct
FROM 
	employees
WHERE commission_pct IS NULL; # is not null can't use =


# safety equal <=>
SELECT 
	last_name,
	commission_pct
FROM 
	employees
WHERE commission_pct <=> NULL; # is not null can't use =

# sort order by asc/desc


SELECT *
FROM employees
ORDER BY salary DESC # asc


SELECT * FROM employees WHERE department_id >= 90 ORDER BY hiredate ASC;

SELECT *, salary*12*(1+IFNULL(commission_pct,0)) total FROM employees ORDER BY
total DESC;


# name length
SELECT LENGTH(last_name) len, last_name, salary FROM employees ORDER BY len DESC;

# salary first then id sort

SELECT * FROM employees ORDER BY salary ASC, employee_id DESC;

# function in sql
/*
	usage: select fuc(var1,var2..) from talbe;
	single function: concat,length,ifnull
	groupby function
*/


# single function String, number, date, other


# String function
SELECT LENGTH('john');

SHOW VARIABLES LIKE '%char%'; # utff8


SELECT CONCAT(last_name, '_', first_name) na FROM employees;


SELECT UPPER('john');#lower

SELECT SUBSTR('abc',1,2); #thrid position is length

# up the first capital lower others
SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),'_',LOWER(SUBSTR(last_name,2))) output FROM employees;

# instr
SELECT INSTR('abc','c') AS out_put; # the first start position

# trim delete

SELECT LENGTH(TRIM('           abc   ')) out_put;

SELECT TRIM('a' FROM 'aaaaaaaaaaaaabc') out_put;

# lpad rpad

SELECT LPAD('aaa',10,'*'); #left pad

# replace
SELECT REPLACE('abc','a','b');


# number function
# round
SELECT ROUND(1.5);
SELECT ROUND(1.567,2);

#ceil
SELECT CEIL(1.01); #>= floor

#truncate
SELECT TRUNCATE(1.69999,1); #1.6


#mod  a-a/b*b

# date function

#now

SELECT NOW();

# current date
SELECT CURDATE();

# current time
SELECT CURTIME();

SELECT YEAR(NOW()); # month
SELECT MONTHNAME(NOW());

# str_to_date # %Y 1999 %y 99 %m 01 %c 1 %d 
# date_format()  date to string

# other function  version(); database(); USER();


# if funciton

SELECT IF(10>5,'big','small');

# case function

SELECT salary, department_id, 
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS new_salary
FROM employees;


# use case as multiple if
# check salary
SELECT salary,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>10000 THEN 'B'
ELSE  'S'
END AS res
FROM employees;

# group by function aggregate function
# sum avg max min count omit null value
# can combine with distinct
# count


SELECT SUM(DISTINCT salary),SUM(salary) FROM employees;

SELECT COUNT(*) FROM employees; # total count

SELECT COUNT(1) FROM employees; # total count


#======================================================================

# group by

SELECT AVG(salary), `department_id`
FROM employees
GROUP BY department_id;

SELECT MAX(salary), job_id
FROM employees
GROUP BY job_id

SELECT AVG(salary), department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY deparmtent_id



SELECT MAX(salary), manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id


# complex

SELECT COUNT(*),department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>2; # group by then select

SELECT MIN(salary),manager_id
FROM employees
WHERE manager_id > 102
GROUP BY manager_id
HAVING MIN(salary) > 5000;


SELECT department_id, COUNT(*), AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)

#++++++++++++++++++++++++++++++++++++++++++++++++
SELECT * FROM beauty;
SELECT * FROM boys;



SELECT NAME, boyName FROM boys,beauty
WHERE beauty.boyfriend_id  = boys.id;


#=====================================================


# inner connection
USE emp;
SELECT e.last_name, e.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id;


#

SELECT last_name,department_name
FROM employees e,departments d
WHERE e.department_id = d.department_id
AND e.commission_pct IS NOT NULL;




SELECT department_name, city
FROM departments d, locations l
WHERE d.location_id = l.location_id
AND city LIKE '_o%';


SELECT COUNT(*), city
FROM departments d, locations l
WHERE d.location_id = l.location_id
GROUP BY city;


SELECT department_name, d.manager_id, MIN(salary)
FROM departments d, employees e
WHERE d.department_id = e.department_id AND commission_pct IS NOT NULL
GROUP BY d.department_id;

#自连接
SELECT e.last_name, e.employee_id, m.employee_id, m.last_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;



# sql 99
/*

	select lists
	from t1 a [type]
	join t2 b
	on conditions
	where conditions
	[group by]
	[having]
	[order by]

	inner join
	left outer join/ right
	full outer join
	cross join
*/

# inner join
#查询员工名 部门名
SELECT last_name, department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT last_name, job_title
FROM employees e
INNER JOIN jobs j
ON e.job_id = j.job_id;

SELECT city, COUNT(*)



FROM departments d
INNER JOIN locations l
ON d.location_id = l.location_id
GROUP BY city
HAVING COUNT(*) >1;


# outer join
SELECT * FROM boys;

# don't have boyfriends
SELECT b.name
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.boyfriend_id = bo.id
WHERE bo.id IS NULL;

SELECT b.name,bo.*
FROM beauty b
LEFT JOIN boys bo
ON b.boyfriend_id = bo.id
WHERE b.id >3;

#=====================================

# sub query


#查询每个部门的员工个数

SELECT d.*, (SELECT COUNT(*) FROM employees WHERE e.department_id = d.department_id)
FROM departments d;

FROM employees
GROUP BY department_id


SELECT a1.* ,g.grade_level
FROM  (
	SELECT AVG(salary) ag,department_id
	FROM employees
	GROUP BY department_id

) a1 
INNER JOIN
job_grades g
ON a1.ag BETWEEN lowest_sal AND highest_sal;


# after exists
SELECT EXISTS(SELECT employee_id FROM employees WHERE salary = 30000) a;

SELECT department_name FROM departments d
WHERE EXISTS( SELECT * FROM employees e WHERE d.department_id = e.department_id)



SELECT * FROM employees e , departments d WHERE d.department_id = e.department_id

SELECT * FROM departments

SELECT bo.*,boyfriend_id FROM beauty b, boys bo WHERE bo.id = b.boyfriend_id


SELECT last_name, salary
FROM employees e
WHERE department_name 


SELECT e1.last_name , e1.salary, e1.department_id
FROM employees e1
WHERE department_id = (SELECT e.department_id FROM employees e WHERE e.last_name = 'Zlotkey')


SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)


SELECT AVG(salary) av, department_id  FROM employees GROUP BY department_id;




