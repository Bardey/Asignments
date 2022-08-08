CREATE TYPE status AS ENUM ('completed', 'in progress');

DROP FUNCTION IF EXISTS unique_checker CASCADE;
CREATE FUNCTION unique_checker() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
  IF NEW.user_id IN (SELECT user_id FROM employee) 
  OR NEW.username IN (SELECT username FROM employee) 
  OR NEW.employee_num IN (SELECT employee_num FROM employee) THEN
  RAISE NOTICE 'This record exists already';
  RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$;

-- TRIGGER 
DROP TRIGGER IF EXISTS unique_checker ON employee;
CREATE TRIGGER unique_checker
BEFORE INSERT ON employee
FOR EACH ROW 
EXECUTE PROCEDURE unique_checker();



DROP FUNCTION IF EXISTS unique_checker2 CASCADE;
CREATE FUNCTION unique_checker2() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
  IF NEW.course_id IN (SELECT course_id FROM course) 
  OR NEW.course_name IN (SELECT course_name FROM course) 
  OR NEW.platform_id IN (SELECT platform_id FROM course) THEN
  RAISE NOTICE 'This record exists already';
  RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$;

-- TRIGGER 
DROP TRIGGER IF EXISTS unique_checker2 ON employee;
CREATE TRIGGER unique_checker2
BEFORE INSERT ON course
FOR EACH ROW 
EXECUTE PROCEDURE unique_checker2();


DROP FUNCTION IF EXISTS unique_checker_platform CASCADE;
CREATE FUNCTION unique_checker_platform() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
  IF NEW.platform_id IN (SELECT platform_id FROM platform) 
  OR NEW.platform_name IN (SELECT platform_name FROM platform)  THEN
  RAISE NOTICE 'This record exists already';
  RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$;

-- TRIGGER 
DROP TRIGGER IF EXISTS unique_checker_platform ON employee;
CREATE TRIGGER unique_checker_platform
BEFORE INSERT ON platform
FOR EACH ROW 
EXECUTE PROCEDURE unique_checker_platform();

DROP FUNCTION IF EXISTS unique_checker_ongoing_training CASCADE;
CREATE FUNCTION unique_checker_ongoing_training() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
  IF NEW.training_id IN (SELECT training_id FROM ongoing_training)
  OR 
  NEW.user_id IN (SELECT user_id FROM ongoing_training) AND NEW.course_id IN (SELECT course_id FROM ongoing_training)
  THEN
  RAISE NOTICE 'This record exists already';
  RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$;
-- TRIGGER 
DROP TRIGGER IF EXISTS unique_checker_ongoing_training ON ongoing_training;
CREATE TRIGGER unique_checker_ongoing_training
BEFORE INSERT ON ongoing_training
FOR EACH ROW 
EXECUTE PROCEDURE unique_checker_ongoing_training();

DROP TABLE employee;
CREATE TABLE employee (
	user_id INT PRIMARY KEY ,
	employee_num INT,
	creation_date DATE,
	username VARCHAR(20),
	pw VARCHAR(20),
	emp_level INT,
	is_active BOOL DEFAULT '1'
);

DROP TABLE course;
CREATE TABLE course (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(50),
	platform_id INT,
	duration TIME,
	create_date DATE,
	tags TEXT,
	photo JSONB,
	is_active BOOL DEFAULT '1'
);
DROP TABLE platform;
CREATE TABLE platform (
	platform_id INT PRIMARY KEY,
	platform_name VARCHAR(50),
	hyper_path TEXT,
	is_active BOOL DEFAULT '1'
);

DROP TABLE review;
CREATE TABLE review (
	user_id INT,
	course_id INT,
	feedback TEXT,
	has_liked BOOL,
	rank_score INT CHECK (rank_score BETWEEN 1 AND 5),
	is_active BOOL DEFAULT '1'
);

DROP TABLE certification;
CREATE TABLE certification (
	cert_id INT PRIMARY KEY,
	user_id INT,
	course_id INT,
	complete_duration TIME,
	complete_date DATE,
	is_active BOOL DEFAULT '1'
);

DROP table ongoing_training;
CREATE TABLE ongoing_training (
	training_id INT PRIMARY KEY,
	user_id INT,
	course_id INT,
	status STATUS,
	complete_percentage INT,
	start_date DATE,
	finish_date DATE,
	last_updated DATE,
	is_active BOOL DEFAULT '1'
);


DROP TABLE photo;
CREATE TABLE photo(
	course_id INT,
	platform_id INT,
	img JSONB
);


INSERT INTO photo VALUES(123, 324, '{"path" : "myimage.jpeg"}');


SELECT img -> 'path' FROM photo;
