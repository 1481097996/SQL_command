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


SELECT employee_id, last_name, salary
FROM employees e
INNER JOIN (SELECT AVG(salary) ag, department_id  FROM employees GROUP BY department_id ) ee
ON e.department_id = ee.department_id
HAVING e.salary > ee.ag;


SELECT manager_id 



# Union query
# union all display all
# multiple talbes
# DQL end
# +++++++++++++++++++++++++++++++++++++++++++++++++++++


# DML
# insert update delete

#  insert
#  insert into table(a,...)
#  values(a,...)



#type same


INSERT INTO beauty(id,NAME,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'aa','f','1990-4-23','188888',NULL,2);

SELECT * FROM beauty;

# only insert some attributes in one row
INSERT INTO beauty(id,NAME,sex,borndate,phone)
VALUES(14,'aaa','f','1990-4-23','118888');

# can omit

INSERT INTO beauty
VALUES(177,'bb1','m',NULL,'119',NULL,NULL),
(20,'bbb1','m',NULL,'1191',NULL,NULL),
(21,'bb2','m',NULL,'1191',NULL,NULL);


# method 2 insert

INSERT INTO beauty
SET id =19, NAME='liu', phone='123';




# update data
/*
 UPDATE ONE TALBE
 UPDATE TABLE
 SET A=B ...
 WHERE CONDITIONS
 

*/



# UPDATE BEAUTY

UPDATE beauty
SET phone ='12222222222'
WHERE NAME LIKE 'a%';

SELECT * FROM beauty;


# delete

# delete from table where conditions

# truncate table; all delete


DELETE FROM beauty WHERE phone LIKE '%9';
 
TRUNCATE TABLE boys;
#+++++++++++++++++++++++++++++++++++++++++++++++



# DDL

# creat, alter, drop table



CREATE DATABASE  IF NOT EXISTS books;

# alter table can cause serious error

# crate table*
/* 
create table name(
	a type(length) restriction,
	a type(length) restriction,
	a type(length) restriction,
	...
	a type(length) restriction

*/


CREATE TABLE book(
	id INT,
	bname VARCHAR(20),
	price DOUBLE,
	authorid INT,
	publishDate DATETIME
);

DESC book;

CREATE TABLE author(
	id INT,
	au_name VARCHAR(20),
	nation VARCHAR(20)
);

DESC author;


ALTER TABLE book CHANGE publishdate pubDate DATETIME;

ALTER TABLE book MODIFY COLUMN pubdate TIMESTAMP;
DESC book;

ALTER  TABLE author ADD COLUMN annual DOUBLE;

ALTER TABLE author DROP COLUMN annual;



# alter table name add/drop/modify/change column name type constriants;

# drop table if exists name;


# general way to craete database

DROP DATABASE IF EXISTS OLD;
CREATE DATABASE NEW;


DROP TABLE IF EXISTS OLD;
CREATE TABLE NAME();



# duplicate table structure


CREATE TABLE copy LIKE author;


# all data

CREATE TABLE copy2
SELECT * FROM author; # use where to select part of data to create database



CREATE DATABASES IF EXISTS test;
USE test;
CREATE TABLE dept1(
id INT(7),
NAME VARCHAR(25)
);

CREATE TABLE dept2
SELECT department_id,department_name
FROM emp.departments;



CREATE TABLE emp5(

id INT(7),
first_name VARCHAR(25),
last_name VARCHAR(25),
dept_id INT(7)
);



ALTER TABLE emp5 MODIFY COLUMN last_name VARCHAR(50);

CREATE TABLE employees2 LIKE myemployees.employees;


DROP TABLE IF EXISTS emp5;


ALTER TABLE employees2 RENAME TO emp5;


ALTER TABLE emp5 ADD COLUMN test_column INT;



# constraints
# 6 constraints not null/  default:promise default value/
# primary key: not null & unique id/
# unique: can be null & unique id/
# check: check constraint sex
# foreign key: two tables relationship


CREATE DATABASE IF NOT EXISTS students;

USE students;


DROP TABLE IF EXISTS stuinfo;
CREATE TABLE stuinfo(
id INT PRIMARY KEY,
stuName VARCHAR(20) NOT NULL,
gender CHAR(1) CHECK(gender='m' OR gender = 'f'),
seat INT UNIQUE,
age INT DEFAULT 18,
majorId INT REFERENCES major(id)


);
  

CREATE TABLE major(
	id INT PRIMARY KEY,
	majorName VARCHAR(20)
);

# general

CREATE TABLE IF NOT EXISTS stuinfo(
	id INT PRIMARY KEY,
	stuname VARCHAR(20) NOT NULL,
	sex CHAR(1),
	age INT DEFAULT 18,
	seat INT UNIQUE,
	majorid INT,
	CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorid) REFERENCES major(id)

);


#TCl
/*
Transaction Control Language

one unit sql
transfer money
A 1000
B 1000
all success or all fail
ACID transaction

Atomicity: all success or all failure
Consistency: one state to an another state
Isolation: not interfare by others
Durability: can't cancel change
e

隐式事务
insert, update, delete

显式事务
开启事务
step 1
set autocommi = 0
start transaction; # can ommit
step 2
sql select insert update delete

step 3
commit;
rollback;

*/

SET autocommit = 0 #显式事务开启
SHOW VARIABLES LIKE 'autocommit' 

SHOW ENGINES;


# start
SET autocommit = 0;
START TRANSACTION;
UPDATE ACCOUNT SET balance = 500 WHERE username ='a';
UPDATE ACCOUNT SET balance =1500 WHERE username ='b';
COMMIT;
#ROLLBACK;

# 隔离机制 并发问题
# 脏读


# save point使用

SET autocommit = 0;
START TRANSACTION
DELETE FROM ACCOUNT WHERE id = 25;
SAVEPOINT a; # 设置保存点
DELETE FROM ACCOUNT WHERE id =28;
ROLLBACK TO a; # when rollback just delete id =25

#视图
/*
虚拟表：和普通表一样使用
由普通表动态生成数据：虚拟结果集 临时性
*/


#查询姓张的学生名和专业名
SELECT * FROM stuinfo
SELECT stuName,majorName
FROM stuinfo s
INNER JOIN major m ON s.majorId = m.id
WHERE s.stuname LIKE '张%';


CREATE VIEW v1
AS
SELECT stuName,majorName
FROM stuinfo s
INNER JOIN major m ON s.majorId = m.id

SELECT * FROM v1 WHERE s.stuname LIKE '张%';

#创建视图

USE emp;

# general way create view as

CREATE VIEW myv1
AS
SELECT last_name, department_name, job_title
FROM employees e
JOIN departments d ON e.department_id = d.department_id 
JOIN jobs j ON j.job_id = e.job_id;



# use
SELECT * FROM myv1 WHERE last_name LIKE "%a%"


#create view myv2
 
CREATE VIEW myv2
AS
SELECT AVG(salary) ag,department_id
FROM employees
GROUP BY department_id;

SELECT * FROM myv2

SELECT myv2.ag ,g.grade_level
FROM myv2
JOIN job_grades g
ON myv2.ag BETWEEN g.lowest_sal AND g.highest_sal;

SELECT *FROM myv2 ORDER BY ag LIMIT 1;



# revise or replace view

# method 1
CREATE OR REPLACE VIEW myv3 
AS 
SELECT AVG(salary),job_id
FROM employees
GROUP BY job_id;

# method 2
ALTER VIEW myv3
AS 
SELECT * FROM employees


# delete view
DROP VIEW myv3;

# check view structure
DESC myv2;


# 视图数据更新

CREATE OR REPLACE VIEW myv1
AS
SELECT last_name,email
FROM employees;

SELECT * FROM myv1

INSERT INTO myv1 VALUES('zhangfei','zf@qq.com');


UPDATE myv1 SET last_name ='zwj' WHERE last_name = 'zhangfei';

DELETE FROM myv1 WHERE last_name ='zwj';

#添加只读权限

# 具备以下视图不能更新
# distinct group by having union union all
# select 包括子查询
# join 可以update 不能insert
# from 一个不能更新的视图
# where子句的子查询引用了from子句中的表

# delete can be rolled back
# truncate can't be rolled back real delete
#===================================================



# mysql变量
/*

system variable: global,session

自定义变量: 用户变量 全局变量

*/



# 系统变量 服务器层面 不是用户定义

# 查看所有的系统变量
SHOW GLOBAL VARIABLES;
SHOW SESSION VARIABLES;


# 查看满足条件的部分系统变量
SHOW GLOBAL VARIABLES LIKE "%char%"

# 查看指定的某个系统变量的值
SELECT @@global#session.name


#为某个系统变量赋值

SET GLOBAL#session name#系统变量 = value;

# 全局 global 会话 session

#1 global
SHOW GLOBAL VARIABLES;

SHOW GLOBAL VARIABLES LIKE '%char%';

SELECT @@global.autocommit;

SET @@global.autocommit = 0;

# session variable
#仅仅作用于当前会话有效
SHOW SESSION VARIABLES;

# 自定义变量： 由用户自己定义
# 声明 赋值 使用
# 用户变量 当前会话有效

#声明并初始化
SET @用户变量 = 值；
SET @用户变量名：=VALUE;
SELECT @用户变量名:=VALUE;

#赋值
#SET or Select

SET @name='john';

# select into

USE emp
SET @count =1;
SELECT COUNT(*) INTO @count 
FROM employees;

#查看
SELECT @count;


# 局部变量 仅仅在定义它的begin end中有效
# 声明 begin end中的的一句话
DECLARE 变量名 TYPE;
DECLARE 变量名 TYPE DEFAULT VALUE;
#赋值
#使用

SET @m =1;
SET @n =2;
SET @sum = @m +@n;
SELECT @sum;

#存储过程和函数
/*
存储过程和函数：类似与java中方法
减少编译次数
简化操作
*/
# 创建语法
CREATE PROCEDURE NAME(参数)
BEGIN
	sqls


END

# variable three parts:
# 参数模式 参数名 参数类型
#IN OUT INOUT 参数模式
/*
IN:该参数可以作为输入
OUT:该参数可以作为输出，即返回值
INOUT:该参数既可以作为输出，也可以作为返回值
*/

BEGIN END #一句话可以省略

#每个sql结尾必须加分号
#存储过程的结尾可以使用DELIMITER作为结束符
DELIMITER 结束标记符号

#调用语法
 #call 存储过程名(实参列表）；
 
#1.空参列表
#插入五条记录
SELECT * FROM ADMIN


DELIMITER $
CREATE PROCEDURE myp1()
BEGIN
	INSERT INTO ADMIN(username,PASSWORD)
	VALUES('c','1111'),('d','2222'),('rose','3333');
END $

#调用
CALL myp1();

#带IN 模式的存储过程实现
#根据女神名 查询男神信息

DELIMITER $
CREATE PROCEDURE myp2(IN beautyName VARCHAR(20))
BEGIN
	SELECT bo.*
	FROM beauty b
	LEFT JOIN boys bo ON b.boyfriend_id = bo.id
	WHERE b.name = beautyName;
END $
SET NAMES UTF8;
SELECT * FROM beauty;
SELECT * FROM boys;

CALL myp2('小昭');


DELIMITER $
CREATE PROCEDURE myp4(IN username VARCHAR(20), IN PASSWORD VARCHAR(20) )
BEGIN
	# 声明
	DECLARE result INT DEFAULT 0;
	#赋值
	SELECT COUNT(*) INTO result
	FROM ADMIN
	WHERE admin.username = username
	AND admin.password = PASSWORD;
	
	
	SELECT IF(result>0,'YEAH','LOSE');#使用

END $

CALL myp4('zhangfei', '8888');


#创建out模式的储存过程
DELIMITER $
CREATE PROCEDURE myp5(IN beautyName VARCHAR(20), OUT boyName VARCHAR(20))
BEGIN
	SELECT bo.boyName INTO boyName
	FROM boys bo
	INNER JOIN beauty b ON bo.id = b.boyfriend_id
	WHERE b.name = beautyName;

END $

CALL myp5('小昭',@bName);
SELECT @bName;

#函数
/*
有且仅有一个返回
		
*/
CREATE FUNCTION NAME(参数列表) RETURNS 返回类型
BEGIN
	函数体
END

/*
参数列表 ： 参数名+参数类型

函数体： 肯定会有return语句

*/

#调用
SELECT 函数名(参数列表)


CREATE FUNCTION myf1() RETURN INT
BEGIN 
	DECLARE c INT DEFAULT 0; #局部变量
	SELECT COUNT(*) INTO c
	FROM employees;
	RETURN c
END $

SELECT myf1()l;


#有参有返回

CREATE FUNCTION myf2(empName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	SET @sal =0; #用户变量
	SELECT salary INTO @sal
	FROM employees
	WHERE last_name = empName
	RETURN @sal;
END $

SELECT myf2('Kochhar');


#查看函数
SHOW CREATE FUNCTION myf3;

DROP FUNCTION myf3;


SET GLOBAL log_bin_trust_function_creators=TRUE;

DELIMITER $
CREATE FUNCTION test_func1(num1 FLOAT, num2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE s FLOAT DEFAULT 0;
	SET s = num1 + num2;
	RETURN s;
END $

SELECT test_func1(1,2)$

#流程控制结构
/*
顺序结构：从上往下依次执行
分支结构：程序从两条或多条路径中去选择一条去执行

*/

#if函数

SELECT IF(表达式1，表达式2,表达式3）


#case结构
#1.switch 等值判断
#2.if多重语句 区间判断

#1
CASE 字段
WHEN 判断值 THEN 返回值或语句;
...
ELSE 要返回值 n
END CASE;

#2

CASE

WHEN 条件1 THEN 返回值1or语句;
WHEN 条件2 THEN 返回值2or语句2;
...
ELSE 返回值
END CASE;

DELIMITER $
CREATE PROCEDURE test_case(IN score INT)
BEGIN 
	CASE
	WHEN score >= 90 AND score <= 100 THEN SELECT 'A';
	WHEN score>= 80 THEN SELECT 'B';
	WHEN score >= 60 THEN SELECT 'C';
	ELSE SELECT 'D';
	END CASE;
END $

CALL test_case(95);



# 3. if结构
/*
功能：实现多重分支

语法:
if 条件1 then 语句1;
elseif 条件2 Then语句2;
[else 语句]
end if;
在begin end中

*/
DROP FUNCTION test_if;
DELIMITER $
CREATE FUNCTION test_if(score INT) RETURNS CHAR(1)
BEGIN
	IF score>=90 AND score<=100 THEN RETURN 'A';
	ELSEIF score>= 80 THEN RETURN 'B';
	ELSEIF score>=60 THEN RETURN 'C';
	END IF;
END $

SELECT test_if(86);

#循环结构
/*
  
while loop repeat

iterate 
leave
*/

# while

[NAME:]WHILE 循环条件 DO 
	循环体;
END whlie[NAME];

# loop
[NAME:] LOOP
	循环体；
END LOOP [NAME];

# repeat
[NAME:] REPEAT
	循环体；
UNTIL 结束循环的条件
END REPEAT [标签】；


CREATE PROCEDURE pro_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	WHILE i <= insertCount DO
		INSERT INTO ADMIN(username,PASSWORD) VALUES
		VALUES (CONCAT('rose' +i) , '666');
		SET i = i +1;
	END WHILE;
END $

CALL pro_while1(10)$