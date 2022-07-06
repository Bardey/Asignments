-- 1

SELECT artist.name AS "Artist Name", COALESCE(album.title, 'No Album' ) AS "Album Name" 
FROM artist
LEFT JOIN album 
ON artist.artistid = album.artistid
ORDER BY artist.name;


-- 2
SELECT sub.artist_name AS "Artist Name", sub.album_name AS "Album Name" FROM 
	(SELECT artist.name AS artist_name, album.title AS album_name, COUNT(album.albumid) FROM artist
	FULL JOIN album
	ON album.artistid = artist.artistid
	GROUP BY artist.name, album.title
	HAVING COUNT(album.albumid) > 0) AS sub
	
ORDER BY sub.album_name DESC;

-- 3
SELECT artist.name AS "Artist Name" FROM artist
FULL JOIN album
ON album.artistid = artist.artistid
WHERE album.albumid IS NULL
ORDER BY artist.name;

-- 4

SELECT artist.name AS "Artist Name", COUNT(album.albumid) AS "No of albums" FROM artist
JOIN album
ON album.artistid = artist.artistid
GROUP BY artist.name
ORDER BY COUNT(album.albumid) DESC, artist.name;

-- 5

SELECT artist.name AS "Artist Name", COUNT(album.albumid) AS "No of Albums" FROM artist
JOIN album
ON album.artistid = artist.artistid
GROUP BY artist.name
HAVING COUNT(album.albumid) >= 10
ORDER BY COUNT(album.albumid) DESC, artist.name;

-- 6

SELECT artist.name AS "Artist Name", COUNT(album.albumid) AS "No of albums" FROM artist
JOIN album
ON album.artistid = artist.artistid
GROUP BY artist.name
ORDER BY COUNT(album.albumid) DESC
LIMIT 3;


-- 7

SELECT artist.name AS "Artist name", album.title AS "Album Title", track.name AS "Track" FROM artist
JOIN album
ON album.artistid = artist.artistid
JOIN track 
ON album.albumid = track.albumid
WHERE artist.name = 'Santana'
ORDER BY track.trackid;

-- 8

SELECT 
e.employeeid AS "Employee ID",
e.firstname || ' ' || e.lastname AS "Employee Name", 
e.title AS "Employee Title",
e.reportsto AS "Manager ID", 
m.firstname || ' ' || m.lastname AS "Manager Name",
m.title AS "Manager Title"
FROM   employee e
LEFT JOIN   employee m on e.reportsto = m.employeeid;


-- 9

SELECT top_employees.emp_id, top_employees.emp_name, customer.firstname || ' ' || customer.lastname AS "Customer Name" FROM top_employees
JOIN customer 
ON customer.supportrepid = top_employees.emp_id
WHERE emp_id = (SELECT emp_id FROM top_employees ORDER BY top_employees.count DESC limit 1)
ORDER BY "Customer Name";


-- 10 

INSERT INTO mediatype (mediatypeid, name)
VALUES (6, 'MP3');


