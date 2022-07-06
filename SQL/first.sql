-- CREATING TABLES

-- EMPLOYER TABLE
DROP TABLE IF EXISTS employer ;
CREATE TABLE employer (
	emp_id INTEGER PRIMARY KEY,
	fname VARCHAR(20),
	join_date DATE,
	curr_pos VARCHAR(20),
	dep VARCHAR(20),
	asigned_project VARCHAR(20)
);

-- SERVICES TABLE
DROP TABLE IF EXISTS services ;
CREATE TABLE services (
	software_id INTEGER PRIMARY KEY,
	s_name VARCHAR(50),
	category VARCHAR(20),
	s_size NUMERIC,
	n_o_inst INTEGER
);

-- REQUESTS TABLE
DROP TABLE IF EXISTS requests ;
CREATE TABLE requests(
	emp_id INTEGER,
	software_id INTEGER,
	req_start_date DATE,
	req_close_date DATE,
	status VARCHAR(20)
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
	WHERE services.software_id = NEW.software_id;
	RETURN NEW;
END;
$$

-- TRIGGER 
CREATE TRIGGER installment_counter
AFTER INSERT ON requests
FOR EACH ROW 
	EXECUTE PROCEDURE trigger_function();

