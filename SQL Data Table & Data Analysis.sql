--SQL Data Table Schemata--

CREATE TABLE "Departments" (
    "Dept_no" VARCHAR(255)   NOT NULL,
    "Dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "Dept_no"
     )
);

CREATE TABLE "Dept_Employees" (
    "Emp_no" INT   NOT NULL,
    "Dept_no" VARCHAR(255)   NOT NULL
);

CREATE TABLE "Dept_Manager" (
    "Dept_no" VARCHAR(255)   NOT NULL,
    "Emp_no" INT   NOT NULL
);

DROP TABLE "Employees";
DROP TABLE "Employees";

CREATE TABLE "Employees" (
    "Emp_no" INT,
    "Emp_title" VARCHAR(255)   NOT NULL,
    "Birth_date" DATE,
    "First_name" VARCHAR(255)   NOT NULL,
    "Last_name" VARCHAR(255)   NOT NULL,
    "Sex" VARCHAR(255)   NOT NULL,
    "Hire_date" DATE,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Emp_no"
     )
);

CREATE TABLE "Salaries" (
    "Emp_no" INT   NOT NULL,
    "Salary" INT   NOT NULL
);

CREATE TABLE "Titles" (
    "Title_id" INT   NOT NULL,
    "Title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "Title_id"
     )
);

ALTER TABLE "Dept_Employees" ADD CONSTRAINT "fk_Dept_Employees_Emp_no" FOREIGN KEY("Emp_no")
REFERENCES "Employees" ("Emp_no");

ALTER TABLE "Dept_Employees" ADD CONSTRAINT "fk_Dept_Employees_Dept_no" FOREIGN KEY("Dept_no")
REFERENCES "Departments" ("Dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager__Dept_no" FOREIGN KEY("Dept_no")
REFERENCES "Departments" ("Dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_Emp_no" FOREIGN KEY("Emp_no")
REFERENCES "Employees" ("Emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees__Emp_title" FOREIGN KEY("Emp_title")
REFERENCES "Titles" ("Title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Emp_no" FOREIGN KEY("Emp_no")
REFERENCES "Employees" ("Emp_no");



--DATA ANALYSIS--

SELECT * FROM "Employees";
SELECT * FROM "Salaries";
SELECT * FROM "Dept_Manager";
SELECT * FROM "Departments";
SELECT * FROM "Dept_Employees";

--Legends: 
	de = department employee
	dm = department manager
	 d = departments
	 e = employees

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select emp."Emp_no", "Last_name", "First_name", "Sex", "Salary"
from "Employees" as emp
inner join "Salaries" as sal
on emp."Emp_no" = sal."Emp_no";

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
select "First_name", "Last_name", "Hire_date"
from "Employees" as emp
where "Hire_date" >= '01/01/1986'
and "Hire_date"< '12/31/1986';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select dm."Dept_no", 
		d."Dept_name",
		dm."Emp_no",
		e."Last_name",
		e."First_name"
from "Dept_Manager" as dm
	join "Employees" as e
	on dm."Emp_no" = e."Emp_no"
	join "Departments" as d
	on dm."Dept_no" = d."Dept_no";


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select  e."Emp_no",
		e."Last_name", 
		e."First_name", 
		d."Dept_name"
from "Employees" as e
	join "Dept_Manager" as dm
	on e."Emp_no" = dm."Emp_no"
	join "Departments" as d
	on dm."Dept_no" = d."Dept_no";

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select "First_name", "Last_name", "Sex"
from "Employees" as emp
where "First_name" = 'Hercules'
and "Last_name" like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select de."Emp_no", 
	    e."Last_name",
		e."First_name", 
		d."Dept_name"
from "Dept_Employees" as de
	join "Employees" as e
	on de."Emp_no" = e."Emp_no"
	join "Departments"
	on de."Dept_no" = d."Dept_no"
	where d.Dept_name = 'Sales'; 

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select de."Emp_no",
		e."Last_name",
		e."First_name",
		d."Dept_name"
from "Dept_Employees" as de
	join "Employees" as e
	on de."Emp_no" = e."Emp_no"
	join "Departments"
	on de."Dept_no" = d."Dept_no"
	where d."Dept_name" = 'Sales' 
	or d."Dept_name" = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT "Last_name", COUNT("Last_name") 
FROM "Employees" as emp
GROUP BY "Last_name"
ORDER BY COUNT("Last_name") DESC;

