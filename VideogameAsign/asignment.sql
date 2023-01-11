DROP TABLE IF EXISTS kiado CASCADE;
CREATE TABLE kiado(
	kiado_id serial PRIMARY KEY NOT NULL,
	kiado_nev VARCHAR(255),
	cim VARCHAR (255),
	alapit_dat smallint CHECK(alapit_dat between 0 and extract(year from current_date))
	
);

DROP TABLE IF EXISTS videojatek CASCADE;
CREATE TABLE videojatek(
	videojatek_id serial PRIMARY KEY,
	kiado_id serial,
	videojatek_nev VARCHAR(255),
	kategoria VARCHAR(255),
	fejleszto VARCHAR(255),
	CONSTRAINT fk_kid 
	FOREIGN KEY(kiado_id)
	REFERENCES kiado(kiado_id))
	
	
INSERT INTO kiado VALUES(1234,'The NineHertz', 'Atlanta, US', 2008);
INSERT INTO kiado VALUES(1243,'iTechArt', 'New York, USA', 2002);
INSERT INTO kiado VALUES(1324,'Juego Studios', 'Bangalore, India', 2013);
INSERT INTO kiado VALUES(1342,'Innowise', 'Warsaw, Poland', 2007);
INSERT INTO kiado VALUES(1423,'Zero Games Studio', 'Paris, France', 2013);
INSERT INTO kiado VALUES(1432,'Electronic Arts', 'California, US', 1982);
INSERT INTO kiado VALUES(2134,'Ubisoft', 'Paris, France', 1986);
INSERT INTO kiado VALUES(2143,'Nintendo', 'Washington, US', 1889);
INSERT INTO kiado VALUES(2314,'Sony Interactive Entertainment', 'Tokyo, Japan', 1993);


SELECT * FROM kiado;


-- CHECKING IF PBLISHER IN DATABASE TRIGGER 
DROP FUNCTION IF EXISTS exist_check CASCADE;
CREATE FUNCTION exist_check() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
  IF NEW.kiado_id NOT IN (SELECT kiado_id FROM kiado) 
  THEN
  RAISE NOTICE 'Nincs ilyen kiadó az adatbázisban';
  RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS exist_check ON videojatek;
CREATE TRIGGER exist_check
BEFORE INSERT ON videojatek
FOR EACH ROW 
EXECUTE PROCEDURE exist_check();



-- CHECKING IF GAME ALREADY EXISTS TRIGGER 
DROP FUNCTION IF EXISTS unique_checker CASCADE;
CREATE FUNCTION unique_checker() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
   AS $$
BEGIN
  IF NEW.videojatek_id IN (SELECT videojatek_id FROM videojatek) 
  THEN
  RAISE NOTICE '% már az adatbázisban van', NEW.videojatek_nev;
  RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$;
-- TRIGGER 
DROP TRIGGER IF EXISTS unique_checker ON videojatek;
CREATE TRIGGER unique_checker
BEFORE INSERT ON videojatek
FOR EACH ROW 
EXECUTE PROCEDURE unique_checker();


copy videojatek FROM '/Users/lantosfeher/loadFiles/newVideojatek.csv' WITH DELIMITER ';' CSV HEADER;

SELECT * FROM kiado;
SELECT * FROM videojatek;
