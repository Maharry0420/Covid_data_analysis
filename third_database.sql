CREATE DATABASE company;
USE company;
 
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- find all employees --
SELECT * FROM employee;

-- find all clients  --
SELECT * FROM client;

-- Find all employees ordered by salary --
SELECT first_name, last_name, salary FROM employee
ORDER BY salary DESC;

-- Find all employees ordered by sex then name NEED HELP --
SELECT * FROM employee
ORDER BY sex, first_name, last_name;

-- Find the first 5 employees in the table --
SELECT * FROM employee 
LIMIT 5;

-- Find the first and last names of all employees --
SELECT first_name, last_name FROM employee;

-- Find the forename and surnames names of all employees --
SELECT first_name AS Forename, last_name AS Surname 
FROM employee;

-- Find out all the different genders --
SELECT DISTINCT sex FROM employee;

-- Find all male employees --
SELECT * FROM employee
WHERE sex = 'M';

-- Find all employees at branch 2 --
SELECT * FROM employee
WHERE branch_id = 2;

-- Find all employee's id's and names who were born after 1969 --
SELECT emp_id, first_name, last_name, birth_day FROM employee
WHERE birth_day > '1969-01-01';

-- Find the number of Employees --
SELECT count(emp_id) AS 'Number Of Employees' FROM employee;

-- find the number of female employees born after 1970 --
SELECT count(emp_id) FROM employee
WHERE birth_day > '1970-01-01' AND sex = 'F';

-- Find all the employees salary --
SELECT SUM(salary) FROM employee;

-- Find the average employee salary --
SELECT CAST(AVG(salary) AS DECIMAL (10,2)) AS 'AVERAGE SALARY' FROM EMPLOYEE;

-- Find the average employee salary for males --
SELECT CAST(AVG(salary) AS DECIMAL (10,2)) AS 'AVERAGE SALARY' FROM EMPLOYEE
WHERE sex = 'M';

-- How many males and female employees are there --
SELECT sex, COUNT(SEX) as 'Number of People' from employee
GROUP BY sex;

-- Find the total number of sales of each salesman (needed help)--
SELECT emp_id, SUM(total_sales) FROM works_with
GROUP BY emp_id;

-- Find all female employees at branch 2 --
SELECT * FROM employee
WHERE branch_id = 2 AND sex = 'F';

-- Find all employees who are female & born after 1969 or who make over 80000--
SELECT * FROM employee
WHERE (sex = 'F' AND birth_day > '1970-01-01') OR salary > 80000;

-- Find all employees who was born between 1970 and 1975 --
SELECT * FROM employee
WHERE birth_day BETWEEN '1970-01-01' AND '1975-01-01';

-- Find all employees named Jim, Michael, Johnny or David--
SELECT * FROM employee
WHERE first_name IN('Jim','Michael','Johnny','David');

-- Find any clients who are an LLC --
SELECT * FROM client
WHERE client_name LIKE '%LLC%';

-- Find any branch suppliers who are in the label business --
SELECT * FROM branch_supplier
WHERE supplier_name LIKE '%Lable%';
 
-- Find any employee born in October --
SELECT * FROM employee
WHERE birth_day LIKE '____-10%';

-- Find any clients who are school --
SELECT * FROM client
WHERE client_name LIKE '%school%';

-- Find any employee born on the 17th day of the month --
SELECT * FROM employee
WHERE birth_day LIKE '_______-17';

-- Find a list of employee and branch names --
SELECT first_name FROM employee
UNION
SELECT branch_name FROM branch;

-- Find a list of all clients & branch suppliers' names --
SELECT client_name, client.branch_id FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id from branch_supplier;

-- Find a list of all money spend or earned by the company --
SELECT salary FROM employee 
UNION 
SELECT total_sales FROM works_with;

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);
SELECT * from branch;

-- Find all branches and the name of their managers --
SELECT employee.emp_id AS 'Employee ID', employee.first_name AS 'Employee First Name', branch.branch_name AS 'Branch Name'
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

-- Find names of all employees who have sold over 30,000 to a single client --
SELECT emp_id, employee.first_name, employee.last_name FROM employee
WHERE employee.emp_id IN(
	SELECT works_with.emp_id FROM works_with
	WHERE works_with.total_sales > 30000);

-- Find all clients who are handled by the branch that Michael Scott Manages-
SELECT * FROM employee
WHERE first_name = 'Michael';
-- 102 --
SELECT client.client_name as 'Client Name' FROM client
WHERE client.branch_id IN /*you can use = as well*/(
	SELECT branch.branch_id FROM branch 
	WHERE branch.mgr_id = 102
    LIMIT 1);

-- Find names of all employees who have sold over 50,000 --
SELECT emp_id, employee.first_name, employee.last_name FROM employee
WHERE employee.emp_id IN(
	SELECT works_with.emp_id FROM works_with
	WHERE works_with.total_sales > 50000);
    
-- Find all clients who are handles by the branch that Michael Scott manages --
 -- Assume you DONT'T know Michael's ID --    
 SELECT client.client_name as 'Client Name' FROM client
WHERE client.branch_id IN /*you can use = as well*/(
	SELECT branch.branch_id FROM branch 
	WHERE branch.mgr_id = (
		SELECT employee.emp_id FROM employee
        WHERE first_name = 'Michael'));
        
-- Find the names of employees who work with clients handled by the scranton branch (struggle) --
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
                         SELECT works_with.emp_id
                         FROM works_with
                         )
AND employee.branch_id = 2;

-- Find the names of all clients who have spent more than 100,000 dollars
SELECT client.client_name from client
WHERE client.client_id IN (
	SELECT works_with.client_id FROM works_with
	WHERE total_sales > 100000);
    
SELECT client.client_name
FROM client
WHERE client.client_id IN (
                          SELECT client_id
                          FROM (
                                SELECT SUM(works_with.total_sales) AS totals, client_id
                                FROM works_with
                                GROUP BY client_id) AS total_client_sales
                          WHERE totals > 100000);   /*More complex way of solving it*/

-- DELETE michael scott ON DELETE SET NULL, it makes them go NULL--
DELETE FROM employee WHERE emp_id = 102;

-- delete branch id = 2 DELETE CASCADE, it clears everything--
DELETE FROM branch WHERE branch_id = 2;

-- CASCADE IS BEST FOR PRIMARY KEYS, NULL FOR FOREIGN KEYS--
