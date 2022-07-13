psql -U postgres -h localhost  //After installing postgresql I log into the postgres user

CREATE DATABASE chin; //creates the database

\c chin; //selects the chin database

chin=# <SQL code for populating the database>

// I quit the postgres view, and start writing the script, therefore I open an mcedit editor
// inside the editor I write the code seen below

#!/usr/bin/env bash

psql --host=localhost --dbname=chin --username=postgres -c "COPY (SELECT DISTINCT(EXTRACT(YEAR FROM invoicedate)) as years FROM invoice
ORDER BY years) TO STDOUT (format csv)" > /home/student/Projects/linux_asignment/years.csv



psql --host=localhost --dbname=chin --username=postgres -c "COPY (SELECT invoice.invoiceid, customer.firstname, customer.lastname,
customer.company, customer.customerid, invoiceline.trackid, artist.name, album.title, track.name, invoice.invoicedate FROM invoice
JOIN customer ON invoice.customerid = customer.customerid
JOIN invoiceline ON invoice.invoiceid = invoiceline.invoiceid
JOIN track ON track.trackid = invoiceline.trackid
JOIN album ON album.albumid = track.albumid
JOIN artist ON album.artistid = artist.artistid

WHERE EXTRACT(YEAR FROM invoicedate) = '2009') TO STDOUT (format csv, delimiter ';')" > /home/student/Projects/linux_asignment/output.csv 



cat /home/student/Projects/linux_asignment/output.csv
