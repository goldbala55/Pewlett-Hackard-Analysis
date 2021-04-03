-- create a table with all retirement titles
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
 INTO Retirement_Titles
 FROM employees as e
  INNER JOIN titles as t ON (e.emp_no = t.emp_no)
 WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
 ORDER BY e.emp_no;

-- export Retirement_Titles to csv
-- https://www.postgresqltutorial.com/export-postgresql-table-to-csv-file/
COPY Retirement_Titles TO 'D:\Users\AlanG\Columbia\class_work\Module7_Employee_Database_with_SQL\Pewlett-Hackard-Analysis\Data\retirement_titles.csv' DELIMITER ',' CSV HEADER;

-- create table of unique titles
SELECT DISTINCT ON (emp_no) emp_no,
       first_name,
       last_name,
	   title
 INTO Unique_Titles
 FROM Retirement_Titles
 ORDER BY emp_no, to_date DESC;

-- Export Unique Titles to csv
COPY Unique_Titles TO 'D:\Users\AlanG\Columbia\class_work\Module7_Employee_Database_with_SQL\Pewlett-Hackard-Analysis\Data\unique_titles.csv' DELIMITER ',' CSV HEADER;

-- Retiring employee count by title
SELECT COUNT(emp_no), 
       title
INTO Retiring_Titles
FROM Unique_Titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

COPY Retiring_Titles TO 'D:\Users\AlanG\Columbia\class_work\Module7_Employee_Database_with_SQL\Pewlett-Hackard-Analysis\Data\retiring_titles.csv' DELIMITER ',' CSV HEADER;
