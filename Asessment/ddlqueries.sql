CREATE TYPE status AS ENUM ('completed', 'in progress');



DROP TABLE employee;
CREATE TABLE employee (
	user_id INT NOT NULL PRIMARY KEY ,
	employee_num INT NOT NULL,
	creation_date DATE NOT NULL,
	username VARCHAR(20) NOT NULL,
	pw VARCHAR(20) NOT NULL,
	emp_level INT NOT NULL,
	is_active BOOL DEFAULT '1'
);

DROP TABLE course;
CREATE TABLE course (
	course_id INT NOT NULL PRIMARY KEY,
	course_name VARCHAR(50) NOT NULL,
	platform_id INT NOT NULL,
	duration TIME NOT NULL,
	create_date DATE NOT NULL,
	tags TEXT NOT NULL,
	photo TEXT NOT NULL,
	is_active BOOL DEFAULT '1'
);
DROP TABLE platform;
CREATE TABLE platform (
	platform_id INT NOT NULL PRIMARY KEY,
	platform_name VARCHAR(50) NOT NULL,
	hyper_path TEXT NOT NULL,
	is_active BOOL DEFAULT '1'
);

DROP TABLE review;
CREATE TABLE review (
	user_id INT NOT NULL,
	course_id INT NOT NULL,
	feedback TEXT,
	has_liked BOOL,
	rank_score INT CHECK (rank_score BETWEEN 1 AND 5),
	is_active BOOL DEFAULT '1'
);

DROP TABLE certification;
CREATE TABLE certification (
	cert_id INT NOT NULL PRIMARY KEY,
	user_id INT NOT NULL,
	course_id INT NOT NULL,
	complete_duration TIME,
	complete_date DATE,
	is_active BOOL DEFAULT '1'
);

DROP table ongoing_training;
CREATE TABLE ongoing_training (
	training_id INT NOT NULL PRIMARY KEY,
	user_id INT NOT NULL,
	course_id INT NOT NULL,
	status STATUS NOT NULL,
	complete_percentage DECIMAL(3,2) NOT NULL,
	start_date DATE NOT NULL,
	finish_date DATE NOT NULL,
	last_updated DATE NOT NULL,
	is_active BOOL DEFAULT '1'
);


DROP TABLE photo;
CREATE TABLE photo(
	course_id INT NOT NULL,
	platform_id INT NOT NULL,
	img JSONB
);


INSERT INTO photo VALUES(123, 324, '{"path" : "myimage.jpeg"}');


SELECT img -> 'path' FROM photo;
