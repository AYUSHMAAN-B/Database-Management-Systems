--111111111111111111111111111	< 6 >

SELECT pname
FROM professor NATURAL JOIN department
WHERE numphds < 50;

--22222222222222222222222222	< 6 >

SELECT sname
FROM student
WHERE gpa = ( SELECT MAX(gpa) 
		 FROM student );
		 
--33333333333333333333333333	< 3 >

SELECT course.cno, AVG(gpa)
FROM course NATURAL JOIN enroll NATURAL JOIN student
WHERE dname = 'Computer Sciences'
GROUP BY course.cno;

--44444444444444444444444444	< 1 >

SELECT student.sname, student.sid
FROM student NATURAL JOIN enroll NATURAL JOIN course
GROUP BY student.sname, student.sid
HAVING count(*) = ( SELECT max(counted) FROM ( SELECT count(*) AS counted
		       FROM student NATURAL JOIN enroll NATURAL JOIN course
		       GROUP BY student.sname, student.sid ) AS salia);
		       
--5555555555555555555555555	< 1 >
			       
SELECT department.dname
FROM department NATURAL JOIN professor
GROUP BY department.dname
HAVING count(*) = ( SELECT max(counted)
			FROM ( SELECT count(*) AS counted
			       FROM department NATURAL JOIN professor
			       GROUP BY department.dname ) AS salia );
			       
--6666666666666666666666666	< 8 >

SELECT student.sname, major.dname
FROM student, major, enroll, course
WHERE course.cname = 'Thermodynamics' AND student.sid = major.sid AND enroll.sid = major.sid AND course.cno = enroll.cno;

--777777777777777777777777	< 1 >

SELECT dname
FROM course
EXCEPT
SELECT major.dname
FROM major NATURAL JOIN student JOIN enroll ON enroll.sid = student.sid
WHERE enroll.cno = '701';

--888888888888888888888888	< 3 >

(
SELECT student.sname
FROM student NATURAL JOIN enroll NATURAL JOIN course
WHERE enroll.dname = 'Mathematics'
GROUP BY student.sname
HAVING count(cname) <= 2
)
INTERSECT
(
SELECT student.sname
FROM student
WHERE sname = SOME ( SELECT sname
		     FROM student NATURAL JOIN enroll NATURAL JOIN course
		     WHERE enroll.dname = 'Civil Engineering' )
);

--99999999999999999999999	< 5 >

SELECT department.dname, avg(student.gpa) AS average_gpa
FROM student JOIN major  ON student.sid = major.sid JOIN department ON major.dname = department.dname
GROUP BY department.dname
HAVING min(student.gpa) < 1.5;

--10 10 10 10 10 10 10 10	< 1 >

SELECT DISTINCT student.sid, sname, gpa
FROM student, course, enroll
WHERE NOT EXISTS ( ( SELECT cno
		     FROM course
		     WHERE dname = 'Civil Engineering' )
		   EXCEPT
		   ( SELECT enroll.cno
		     FROM enroll
		     WHERE enroll.sid = student.sid ) );


-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

--111111111111111111111111111

create database salesdb;

--22222222222222222222222222

\c salesdb
\i tableSales.sql
		 
--33333333333333333333333333

SET datestyle = 'ISO, MDY';
\i dataSales.sql

-- 4444444444444444444444	< 7 >

SELECT CUST_NAME
FROM Customer
WHERE GRADE = 2;

-- 555555555555555555555	< 25 >

SELECT ORD_NUM, ORD_DATE, ORD_DESCRIPTION
FROM Orders
ORDER BY ORD_DATE;

-- 666666666666666666666	< 20 >

SELECT ORD_NUM, ORD_DATE, ORD_AMOUNT
FROM Orders
WHERE ORD_AMOUNT >= 800
ORDER BY ORD_AMOUNT DESC;

-- 77777777777777777777		< 20 >

SELECT *
FROM Customer
ORDER BY WORKING_AREA, CUST_NAME DESC;

-- 88888888888888888888		< 5 >

SELECT CUST_NAME
FROM Customer
WHERE CUST_NAME LIKE 'S%';

-- 99999999999999999999		< 1 >

SELECT ORD_NUM
FROM Orders
WHERE ORD_DATE BETWEEN '2008-03-01' AND '2008-03-31';

-- 10 10 10 10 10 10 10		< 25 >

SELECT ORD_AMOUNT*1.1 AS ORDER_AMOUNT
FROM Orders;

-- 11 11 11 11 11 11 11		< 13 >

SELECT ORD_NUM, (ORD_AMOUNT - ADVANCE_AMOUNT) AS BALANCE
FROM Orders
WHERE ORD_AMOUNT BETWEEN 2000 AND 4000;

-- 12 12 12 12 12 12 12		< 7 >

SELECT ORD_NUM, CUST_CODE, ORD_AMOUNT
FROM Orders NATURAL JOIN Customer
WHERE ORD_AMOUNT = SOME ( SELECT ORD_AMOUNT
			   FROM Orders
			   WHERE CUST_CODE = 'C00022' );

-- 13 13 13 13 13 13 13		< 3 >

SELECT AGENT_CODE, AGENT_NAME
FROM Agents as A1
WHERE A1.COMMISSION = ( SELECT max(COMMISSION)
			   FROM Agents as A2
			   WHERE A2.WORKING_AREA = 'Bangalore' );

-- 14 14 14 14 14 14 14		< 6 >

SELECT AGENT_CODE, AGENT_NAME
FROM Agents as A1
WHERE A1.COMMISSION > SOME ( SELECT COMMISSION
			   FROM Agents as A2
			   WHERE A2.WORKING_AREA = 'Bangalore' );
			   
-- 15 15 15 15 15 15 15		< 11 >

SELECT DISTINCT Agents.AGENT_CODE
FROM Agents NATURAL JOIN Orders
ORDER BY AGENT_CODE;

-- 16 16 16 16 16 16 16		< 1 >

SELECT AGENT_CODE
FROM Agents
EXCEPT
SELECT DISTINCT Agents.AGENT_CODE
FROM Agents NATURAL JOIN Orders
ORDER BY AGENT_CODE;

-- 17 17 17 17 17 17 17		< 20 >

SELECT Agents.AGENT_CODE
FROM Agents NATURAL JOIN Orders
WHERE ORD_AMOUNT >= 800
ORDER BY AGENT_CODE;

-- 18 18 18 18 18 18 18		< 9 >

SELECT DISTINCT Agents.AGENT_CODE
FROM Agents NATURAL JOIN Orders
WHERE ORD_AMOUNT >= 800;

-- 19 19 19 19 19 19 19		< 5 >

SELECT CUST_CODE, CUST_NAME
FROM Customer
WHERE CUST_CITY IN ( 'New York', 'Paris', 'Bangalore' );

-- 20 20 20 20 20 20 20		< 3 >

SELECT DISTINCT AGENT_NAME
FROM Agents NATURAL JOIN Orders
GROUP BY AGENT_NAME, ORD_AMOUNT
HAVING sum( ORD_AMOUNT ) = 1000
ORDER BY AGENT_NAME;

-- 21 21 21 21 21 21 21		< 1 >

SELECT sum(ORD_AMOUNT), avg(ORD_AMOUNT), min(ORD_AMOUNT), max(ORD_AMOUNT)
FROM Orders;

-- 22 22 22 22 22 22 22		< 3 >

SELECT count(CUST_CODE)
FROM Customer
WHERE CUST_CITY = 'New York';

-- 23 23 23 23 23 23 23		< 11 >

SELECT count( DISTINCT ORD_AMOUNT )
FROM Orders;

-- 24 24 24 24 24 24 24		< 8 >

SELECT Agents.AGENT_CODE, Agents.AGENT_NAME
FROM Agents NATURAL JOIN Orders
GROUP BY Agents.AGENT_CODE, Agents.AGENT_CODE
HAVING count( AGENT_CODE ) >= 2;

-- 25 25 25 25 25 25 25		< 9 >

SELECT WORKING_AREA, count( AGENT_CODE )
FROM Agents
GROUP BY WORKING_AREA;

-- 26 26 26 26 26 26 26		< 10 >

SELECT AGENT_NAME
FROM Agents
WHERE WORKING_AREA IN ( SELECT WORKING_AREA
			FROM Orders NATURAL JOIN Agents
			WHERE Agents.AGENT_CODE IN ( SELECT AGENT_CODE
						     FROM Orders
						     GROUP BY AGENT_CODE
						     HAVING count(*) >= 2 ) );

-- 27 27 27 27 27 27 27		< 11 >

SELECT DISTINCT AGENT_NAME, avg( ORD_AMOUNT )
FROM Agents NATURAL JOIN Orders
GROUP BY AGENT_NAME
ORDER BY AGENT_NAME;

-- 28 28 28 28 28 28 28

DELETE FROM Agents
WHERE WORKING_AREA = 'Bangalore';

UPDATE Customer
SET AGENT_CODE = NULL
WHERE AGENT_CODE IN (SELECT AGENT_CODE FROM Agents WHERE WORKING_AREA = 'Bangalore');

UPDATE Orders
SET AGENT_CODE = NULL
WHERE AGENT_CODE IN (SELECT AGENT_CODE FROM Agents WHERE WORKING_AREA = 'Bangalore');

-- 29 29 29 29 29 29 29

ALTER TABLE customer
ADD COLUMN Address varchar(50) NULL;

UPDATE customer
SET Address = 'IIT Dharwad,Karntaka'
WHERE cust_code='C00013';

-- 30 30 30 30 30 30 30

ALTER TABLE Agents DROP COLUMN COUNTRY;

-- 31 31 31 31 31 31 31

DELETE FROM Orders;

-- 32 32 32 32 32 32 32

DROP TABLE Customer CASCADE;



































