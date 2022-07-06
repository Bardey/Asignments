-- CREATING TABLES

-- EMPLOYER TABLE
DROP TABLE IF EXISTS employer ;
CREATE TABLE employer (
	emp_id INTEGER PRIMARY KEY NOT NULL,
	fname VARCHAR(20),
	join_date DATE,
	curr_pos VARCHAR(20),
	dep VARCHAR(20),
	asigned_project VARCHAR(20)
);

-- SERVICES TABLE
DROP TABLE IF EXISTS services ;
CREATE TABLE services (
	software_id INTEGER PRIMARY KEY NOT NULL,
	s_name VARCHAR(50),
	category VARCHAR(20),
	s_size NUMERIC,
	n_o_inst INTEGER DEFAULT 0
);

-- REQUESTS TABLE
DROP TABLE IF EXISTS requests ;
CREATE TABLE requests(
	emp_id INTEGER NOT NULL,
	software_id INTEGER NOT NULL,
	req_start_date DATE,
	req_close_date DATE,
	status VARCHAR(20) NOT NULL
);



-- To make database consistent a trigger and a corresponding trigger function are needed as follows
-- TRIGGER FUNCTION
DROP FUNCTION IF EXISTS trigger_function CASCADE;
CREATE FUNCTION trigger_function() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
   	UPDATE services SET n_o_inst = (n_o_inst + 1) 
	WHERE services.software_id = NEW.software_id AND NEW.status = 'valid' AND NEW.software_id IN 
	(SELECT software_id FROM services);
	RETURN NEW;
END;
$$

-- TRIGGER 
CREATE TRIGGER installment_counter
AFTER INSERT ON requests
FOR EACH ROW 
	EXECUTE PROCEDURE trigger_function();



-- TO UPDATE
-- TRIGGER FUNCTION WHICH CHECKS ON THE NUMBER OF VALID SOFTWARE
DROP FUNCTION IF EXISTS trigger_function2 CASCADE;
CREATE FUNCTION trigger_function2() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
   	UPDATE services SET n_o_inst = (SELECT COUNT(*) FROM requests 
									JOIN services 
									ON services.software_id = requests.software_id
									WHERE services.software_id = requests.software_id
								   AND status = 'invalid') 
	WHERE services.software_id = NEW.software_id AND NEW.status = 'valid'; 
	RETURN NEW;
END;
$$

-- THE TRIGGER ITSELF
CREATE TRIGGER installment_counter2
AFTER UPDATE ON requests
FOR EACH ROW 
	EXECUTE PROCEDURE trigger_function2();
	
	

