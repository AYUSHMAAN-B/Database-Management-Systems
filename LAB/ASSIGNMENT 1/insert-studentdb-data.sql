COPY student FROM '/home/vivek/Downloads/TA/DBIS/Student/studentData.csv' DELIMITER ',';
COPY department FROM '/home/vivek/Downloads/TA/DBIS/Student/departmentData.csv' DELIMITER ',';
COPY professor FROM '/home/vivek/Downloads/TA/DBIS/Student/professorData.csv' DELIMITER ',';
COPY course FROM '/home/vivek/Downloads/TA/DBIS/Student/courseData.csv' DELIMITER ',';
COPY major FROM '/home/vivek/Downloads/TA/DBIS/Student/majorData.csv' DELIMITER ',';
COPY enroll FROM '/home/vivek/Downloads/TA/DBIS/Student/enrollData.csv' DELIMITER ',';

--ALTER TABLE course ALTER COLUMN cname TYPE VARCHAR(60);
