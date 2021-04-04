/* ------------------------------------------------- 
    Deliverable 1
   ------------------------------------------------- */

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

-- Export Retiring Titles to csv
COPY Retiring_Titles TO 'D:\Users\AlanG\Columbia\class_work\Module7_Employee_Database_with_SQL\Pewlett-Hackard-Analysis\Data\retiring_titles.csv' DELIMITER ',' CSV HEADER;

/* ------------------------------------------------- 
    Deliverable 2
   ------------------------------------------------- */
/* 
Some observations
 1. Why are we using to_date and from_date from the dept_emp table?  This seems unrelated to the query if you ask me.
    Would think selecting to_date, from_date from the titles table would make more sense.
	I ended up using titles.to_date DESC in the ORDER BY to get the correct DISTINCT ON results.  Using dept_emp.to_date
	would not work as they are all '9999-01-01' as that is in the where clause to pick current employees.
 2. For emp_no 10291, I get "Senior Staff" as the title, even though the image in the Module shows "Staff"
    There are two rows in titles table for this emp_no and the current one (to_date=9999-01-01) is for "Senior Staff"
	All the other match as expected, so would like to understand how this one is different
 3. Also filtering on "to_date" to get birth dates in 1965 is not logical.  I used birth_date.
*/

-- create a table with staff eligible for mentorship - employees born in 1965
SELECT DISTINCT ON (e.emp_no) e.emp_no,
       e.first_name,
       e.last_name,
       e.birth_date,
       de.from_date,
       de.to_date,
       ti.title
 INTO Mentorship_Eligibility
 FROM employees as e
  INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
  INNER JOIN titles as ti ON (e.emp_no = ti.emp_no)
 WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
       AND (de.to_date = '9999-01-01')
 ORDER BY emp_no, ti.to_date DESC
;

-- Export Eligibility table to csv
COPY Mentorship_Eligibility TO 'D:\Users\AlanG\Columbia\class_work\Module7_Employee_Database_with_SQL\Pewlett-Hackard-Analysis\Data\mentorship_eligibilty.csv' DELIMITER ',' CSV HEADER;

/* 
   This gets the same results but usess titles.to_date to filter current employees
   and then does not need to add titles.to_date DESC to the ORDER_BY
SELECT DISTINCT ON (e.emp_no) e.emp_no,
       e.first_name,
       e.last_name,
       e.birth_date,
       de.from_date,
       de.to_date,
       ti.title
 --INTO Mentorship_Eligibility
 FROM employees as e
  INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
  INNER JOIN titles as ti ON (e.emp_no = ti.emp_no)
 WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
       AND (ti.to_date = '9999-01-01')
 ORDER BY emp_no
;
*/
