CREATE TABLE "departments"(
"dept_no" VARCHAR NOT NULL,
"dept_name" VARCHAR NOT NULL, 
CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
);
CREATE TABLE "dept_manager"(
"dept_no" VARCHAR NOT NULL,
"emp_no" INT NOT NULL 
);
CREATE TABLE "employees"(
"emp_no" INT NOT NULL,
"emp_title_id" VARCHAR NOT NULL,
"birth_date" DATE NOT NULL, 
"first_name" VARCHAR NOT NULL, 
"last_name" VARCHAR NOT NULL, 
"sex" VARCHAR NOT NULL,
"hire_date" DATE NOT NULL, 	
CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no")
);
CREATE TABLE "salaries"(
"emp_no" INT NOT NULL,
"salary" INT NOT NULL
);
CREATE TABLE "dept_emp"(
"emp_dept_key" VARCHAR NOT NULL,
"emp_no" INT NOT NULL, 
"dept_no" VARCHAR NOT NULL,
CONSTRAINT "pk_dept_emp" PRIMARY KEY ("emp_dept_key")
);
CREATE TABLE "titles"(
"title_id" VARCHAR NOT NULL,
"title" VARCHAR NOT NULL, 
CONSTRAINT "pk_titles" PRIMARY KEY ("title_id")
);

/*List the following details of each employee: employee number, last name, first name, sex, and salary.*/
select employees.emp_no, last_name, first_name, sex, salary
from employees, salaries 
where employees.emp_no=salaries.emp_no

/*List first name, last name, and hire date for employees who were hired in 1986.*/
select first_name, last_name, hire_date
from employees
where hire_date BETWEEN '1986-01-01' AND '1987-01-01'

/* List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.*/
select dept_manager.dept_no, dept_name, dept_manager.emp_no, last_name, first_name
from employees, dept_manager, departments
where employees.emp_no=dept_manager.emp_no and dept_manager.dept_no=departments.dept_no

/*  List the department of each employee with the following information: employee number, last name, first name, and department name.*/
select employees.emp_no, last_name, first_name, dept_name
from employees, dept_emp, departments
where employees.emp_no=dept_emp.emp_no and dept_emp.dept_no=departments.dept_no

/*List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."*/
select first_name, last_name, sex
from employees
where first_name='Hercules' and last_name like 'B%'

/*List all employees in the Sales department, including their employee number, last name, first name, and department name.*/
select employees.emp_no, last_name, first_name, dept_name
from employees, departments, dept_emp
where employees.emp_no=dept_emp.emp_no and dept_emp.dept_no=departments.dept_no and departments.dept_no ='d007'

/*List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.*/
select employees.emp_no, last_name, first_name, dept_name
from employees, departments, dept_emp
where employees.emp_no=dept_emp.emp_no and dept_emp.dept_no=departments.dept_no and departments.dept_no in ('d007', 'd005')

/*In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.*/
select last_name, count (last_name) as frequency
from employees
group by last_name
order by frequency desc