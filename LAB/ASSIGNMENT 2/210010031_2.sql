-- 1 1 1 1 1 1 1 1 1 1 1 1 1 1

SELECT max_students, min_students
FR
OM ( SELECT max(counted_max)
	FROM ( SELECT section.course_id, section.sec_id, count(ID) AS counted_max
       				      FROM section NATURAL JOIN takes
			              GROUP BY section.course_id, section.sec_id ) as salia1 ) as max_students , 
     ( SELECT min(counted_min)
     	FROM ( SELECT section.course_id, section.sec_id, count(ID) AS counted_min
       				      FROM section NATURAL JOIN takes
       				      GROUP BY section.course_id, section.sec_id ) as salia2 ) as min_students;

-- 2 2 2 2 2 2 2 2 2 2 2 2 2 2
			              
SELECT section.sec_id, section.course_id, COUNT(ID)
FROM section NATURAL JOIN takes
GROUP BY section.course_id, section.sec_id
HAVING count(ID) = ( SELECT max(counted_max)
		     FROM ( SELECT section.course_id, section.sec_id, count(ID) AS counted_max
       			    FROM section NATURAL JOIN takes
			    GROUP BY section.course_id, section.sec_id ) as salia );
			              
-- 3 3 3 3 3 3 3 3 3 3 3 3 3 3

-- (a)

SELECT DISTINCT ( SELECT max(counted_max)
		  FROM ( SELECT section.course_id, section.sec_id, count(ID) AS counted_max
       		         FROM section NATURAL LEFT OUTER JOIN takes
			 GROUP BY section.course_id, section.sec_id ) as salia1 ) as max_students,
       	       ( SELECT min(counted_min)
     	 	 FROM ( SELECT section.course_id, section.sec_id, count(ID) AS counted_min
       		    	FROM section NATURAL LEFT OUTER JOIN takes
       		  	GROUP BY section.course_id, section.sec_id ) as salia2 ) as min_students
FROM section NATURAL LEFT OUTER JOIN takes;

-- (b)
       				      
SELECT max(counted), min(counted)
	FROM ( SELECT section.course_id, section.sec_id, count(ID) AS counted
       				      FROM section NATURAL LEFT OUTER JOIN takes
			              GROUP BY section.course_id, section.sec_id ) as salia1;
       				      
-- 4 4 4 4 4 4 4 4 4 4 4 4 4

SELECT *
FROM course
WHERE course_id LIKE 'CS-1%';


-- 5 5 5 5 5 5 5 5 5 5 5 5 5

INSERT INTO instructor VALUES ( '69696', 'Sanchi', 'Comp. Sci.', '99999' );
INSERT INTO teaches VALUES ( '69696', 'CS-101', '1', 'Fall', '2017' );
INSERT INTO teaches VALUES ( '69696', 'CS-190', '1', 'Spring', '2017' );
		
-- (a)

SELECT DISTINCT name
FROM instructor as I NATURAL JOIN teaches
WHERE NOT EXISTS ( ( SELECT course_id
		      FROM course
	       	      WHERE course_id LIKE 'CS-1%' )
	       	    EXCEPT
	       	    ( SELECT course_id
	       	      FROM teaches
	       	      WHERE I.ID = teaches.ID ) );

-- (b)

SELECT name
FROM instructor NATURAL JOIN teaches
WHERE teaches.course_id IN ( SELECT course_id
			    FROM course
			    WHERE course_id LIKE 'CS-1%' )
GROUP BY instructor.name
HAVING count( DISTINCT teaches.course_id ) = ( SELECT count(course_id)
		      		       FROM course
	       	                       WHERE course_id LIKE 'CS-1%' );


-- 6 6 6 6 6 6 6 6 6 6 6 6 6

INSERT INTO student (id, name, dept_name, tot_cred)
SELECT instructor.id, instructor.name, instructor.dept_name, 0
FROM instructor;

-- 7 7 7 7 7 7 7 7 7 7 7 7 7

DELETE FROM student natual join instructor
WHERE tot_cred = 0;

-- 8 8 8 8 8 8 8 8 8 8 8 8 8
    		       
UPDATE instructor AS I
SET salary = 10000 * ( SELECT count(course_id)
		       FROM teaches NATURAL JOIN section
		       WHERE I.id = teaches.id 
		       GROUP BY id
		       HAVING count(course_id)>2 )
WHERE I.id IN ( SELECT teaches.id
		FROM teaches NATURAL JOIN section
		WHERE I.id = teaches.id 
		GROUP BY id
		HAVING count(course_id) > 2 );
    		       
-- 9 9 9 9 9 9 9 9 9 9 9 9 9

CREATE VIEW failures AS
SELECT student.id, course_id, sec_id, semester, year, grade
FROM student NATURAL JOIN takes
WHERE grade='F';

-- 10 10 10 10 10 10 10 10 10

SELECT id
FROM failures
GROUP BY id
HAVING count(grade) >= 2;

-- 11 11 11 11 11 11 11 11 11

CREATE TABLE grade_points ( grade VARCHAR(2) PRIMARY KEY,
			    points numeric(2, 0) );
INSERT INTO grade_points VALUES ( 'A+', 10 );
INSERT INTO grade_points VALUES ( 'A', 10 );
INSERT INTO grade_points VALUES ( 'A-', 10 );
INSERT INTO grade_points VALUES ( 'B+', 8 );
INSERT INTO grade_points VALUES ( 'B', 8 );
INSERT INTO grade_points VALUES ( 'B-', 8);
INSERT INTO grade_points VALUES ( 'C+', 6 );
INSERT INTO grade_points VALUES ( 'C', 6 );
INSERT INTO grade_points VALUES ( 'C-', 6 );
INSERT INTO grade_points VALUES ( 'D+', 4 );
INSERT INTO grade_points VALUES ( 'D', 4 );
INSERT INTO grade_points VALUES ( 'D-', 4 );
INSERT INTO grade_points VALUES ( 'F', 0 );

-- 12 12 12 12 12 12 12 12 12

SELECT id, ( tmul / tcred ) AS CGP
FROM (  SELECT id , sum(mul) as tmul , sum(cred) AS tcred
	FROM (  SELECT takes.ID AS id, ( grade_points.points * course.credits ) AS mul, course.credits AS cred
		FROM grade_points NATURAL JOIN takes NATURAL JOIN course ) AS multable
	GROUP BY id
	ORDER BY id ) AS cgpatable;

-- 13 13 13 13 13 13 13 13 13
				       
SELECT course_id, sec_id, semester, year, room_number, time_slot_id
FROM section
WHERE (room_number, semester, year, time_slot_id) IN ( SELECT room_number, semester, year, time_slot_id
   				       FROM section 
				       GROUP BY room_number, semester, year, time_slot_id
				       HAVING count(*) > 1 ) ;

-- 14 14 14 14 14 14 14 14 14

CREATE VIEW faculty AS
SELECT id, name, dept_name
FROM instructor;

-- 15 15 15 15 15 15 15 15 15

CREATE VIEW CSinstructors AS
SELECT *
FROM instructor
WHERE dept_name = 'Comp. Sci.';

-- 16 16 16 16 16 16 16 16 16

INSERT INTO faculty VALUES ( '11111', 'Instructor_1', 'Comp. Sci.', '99999' );
/*
	INSERT has more expressions than target columns
	LINE 1: ...y VALUES ( '11111', 'Instructor_1', 'Comp. Sci.', '99999' );
*/

INSERT INTO faculty VALUES ( '11111', 'Instructor_1', 'Comp. Sci.' );
/*
	INSERT 0 1
*/

INSERT INTO CSinstructors VALUES ( '33333', 'CSInstructor_1', 'CyberSecurity', '99999' );
/*
	DEPARTMENT not present in department table
*/

INSERT INTO CSinstructors VALUES ( '33333', 'CSInstructor_1', 'Biology', '99999' );
/*
	Not shown
*/

-- 17 17 17 17 17 17 17 17 17

CREATE ROLE VIEW;
GRANT SELECT ON student TO VIEWS;
CREATE USER new_user;
GRANT VIEW TO new_user;

