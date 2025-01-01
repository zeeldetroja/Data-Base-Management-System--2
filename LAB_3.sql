CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);
CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-- Create Projects Table
CREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');

 INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID,
Salary)
VALUES
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);

 INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);


-- Part – A


--1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based
--on this you must give EmployeeID, DOB, Gender & Hiredate.
Create or alter Procedure PR_First_Last
@Fname varchar(50) = null,
@Lname Varchar(50) = Null
as 
begin 
	select EmployeeID, DoB,Gender,HireDate from Employee
	where (FirstName = @Fname) or (FirstName = @Fname and LastName = @Lname) or (LastName = @Lname)
end

exec PR_First_Last 'John'
exec PR_First_Last Null , 'Doe'
exec PR_First_Last @Lname = 'Doe'



--2. Create a Procedure that will accept Department Name and based on that gives employees list who
--belongs to that department.  
Create Or alter Procedure PR_Departments_Select
@Dname varchar(50)
as
begin 
	select * from Employee as e join Departments as d 
	on e.DepartmentID = d.DepartmentID 
	where d.DepartmentName = @Dname
end

exec PR_Departments_Select 'IT'

--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give
--all the project related details.
Create Or Alter Procedure PR_Project_Select 
@Pname varchar(50),
@Dname varchar(50)
as
begin
	select * 
	from Projects as p join Departments as d
	on p.DepartmentID = d.DepartmentID
	where p.ProjectName = @Pname and d.DepartmentName = @Dname
end

exec PR_Project_Select 'Project Beta','IT'

--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those
--employee list comes in output.
Create Or Alter Procedure PR_Employee_salary_select
@Start int ,
@End int
as
begin
	select * from Employee
	where salary between @Start and @End
end

exec PR_Employee_salary_select 70000 , 80000

--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date. 
Create Or Alter Procedure PR_Employee_Get_Hiredate
@date DateTime
as
begin 
	select * from Employee
	where HireDate = @Date
end

exec PR_Employee_Get_Hiredate '2010-06-15'


--Part – B

--6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be
--served.
Create Or Alter procedure PR_Employee_FirstLetter_select
@FirstLetter varchar(50)
as
begin
	select * from Employee
	where Gender Like @FirstLetter + '%'
end

exec PR_Employee_FirstLetter_select 'M'

--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee
--data will come.
Create Or Alter Procedure PR_Employee_Departments_Select 
@Fname varchar(50) = null,
@Dname varchar(50) = null
as
begin 
	select * From Employee as e join Departments as d 
	on e.DepartmentID = d.DepartmentID 
	where (e.FirstName = @Fname ) or (e.FirstName = @Fname and d.DepartmentName = @Dname ) or (d.DepartmentName = @Dname)
end

exec PR_Employee_Departments_Select 'John'
exec PR_Employee_Departments_Select null , 'HR'
exec PR_Employee_Departments_Select 'John', 'IT'

--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will
--get all the departments with all data. 
Create Or Alter Procedure PR_Departments_Location
@Dname varchar(50)
as
begin
	select * from Departments 
	where Location Like '%'+ @Dname + '%'
end

exec PR_Departments_Location 'a'


--Part – C

--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project
--related data.
Create or Alter Procedure PR_Projects_Date_select
@Start datetime,
@End datetime 
as
begin
	select * from Projects 
	where StartDate = @Start and EndDate = @End
end

exec PR_Projects_Date_select '2022-01-01' ,'2022-12-31'


--10. Create a procedure in which user will enter project name & location and based on that you must
--provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates. 
Create Or Alter Procedure PR_Manager_Dept_Project_Select
@PName varchar(50),
@Location varchar(50)
as
begin
	Select d.DepartmentName , e.FirstName , p.ProjectName , p.StartDate , p.EndDate
	from Departments as d join Employee as e 
	on d.DepartmentID = e.DepartmentID 
	join Projects as p 
	on d.DepartmentID = p.DepartmentID
	where p.ProjectName = @PName and d.Location = @Location
end

exec PR_Manager_Dept_Project_Select 'Project Delta','Chicago'
