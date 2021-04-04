# Pewlett-Hackard-Analysis
## Project Overview
The original project provided substantial details on retiring employees to PH management.  Upon further review they have requested additional analyses to provide insight into two key areas:

    1. The number of employees retiring by title
    2. Identify candidates for a mentoring program 

## Resources
  * Five Human Resource files were provided by Pewlett-Hackard: 
    * departments.csv - a list of all the company departments.
    * dept_emp.csv - a linkage table mapping employees to departments.
    * dept_manager.csv - a linkage table mapping the manager to their departments.
    * employees.csv - comprehensive historical employee data.
    * salaries.csv - salary information per employee.
    * titles.csv - employee title history.
  * Software: PostgresSQL 13/pgadmin, Git Bash 4.4.23, QuickDataBaseDiagrams.com

## Results
A data model was designed and used to load the files into PostgresSQL. See [PH Data Model](https://github.com/goldbala55/Pewlett-Hackard-Analysis/blob/main/EmployeeDB.png)

This analysis was based on these tables and yielded the following observations:
    
    * Over 1/3 (90398/240124) of the total active employees will be retiring in the next few years (see Appendix for total employee count SQL)
    * Nearly 2/3 (57668/90398) of the retirees are Senior management (see [Retiring Titles](https://github.com/goldbala55/Pewlett-Hackard-Analysis/blob/main/Data/retiring_titles.csv) )
    * PH will need to engage in a significant recruiting and/or retainment project to replace the potential flood of retirees.  Depending on the companies retirement package there could also be significant financial implications.
    * While the mentoring project is am excellent approach, there is an in sufficient number of candidates (1549) to replace the volume of retiring managers.
## Summary
In summary:
    1. PH needs to start a significant recruiting and internal training project to prevent the exit of senior management from causing a leadership vacuum.
    2. PH should approach the youngest of this group (born 1955) with stay on bonuses to retain additional talent.  There are 13,075 'Senior' staff members in this group (see Appendix below)
    3. Depending on the companies retirement package there could also be significant financial implications.
    4. Starting the mentorship project with candidates from 1964 will substantially increase the number of potential candidates to 19,905 (see Appendix below)
## Appendix

### Total Active Employees at PH
    SELECT count(e.emp_no)
    FROM employees as e
    LEFT JOIN dept_emp as de ON e.emp_no = de.emp_no
    WHERE de.to_date = ('9999-01-01');
    -- 240124

### Total Senior staff born in 1955
    SELECT count(e.emp_no)
    FROM employees as e
    INNER JOIN titles as t ON (e.emp_no = t.emp_no)
    WHERE (e.birth_date BETWEEN '1955-01-01' AND '1955-12-31')
            and t.to_date = '9999-01-01'
            and title like 'Senior%';
        -- 13075

### Total staff eligible for mentorship born in 1964 and 1965
    select count (*) from 
        (SELECT DISTINCT ON (e.emp_no) e.emp_no
        FROM employees as e
        INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
        INNER JOIN titles as ti ON (e.emp_no = ti.emp_no)
        WHERE (e.birth_date BETWEEN '1964-01-01' AND '1965-12-31')
            AND (de.to_date = '9999-01-01')
        ORDER BY emp_no, ti.to_date DESC) a
    ;
    -- 19905
