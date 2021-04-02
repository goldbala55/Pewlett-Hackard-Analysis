select * from departments;
--select * from titles limit 10;
--select * from dept_emp limit 10;
--select * from dept_manager limit 10;
--select * from employees limit 10;
--select * from salaries limit 10;

--SELECT extract(year from birth_date) bdate, count(*)
--FROM employees
--WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
--group by extract(year from birth_date);
--WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
--WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

/*
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
*/


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select * from retirement_info;