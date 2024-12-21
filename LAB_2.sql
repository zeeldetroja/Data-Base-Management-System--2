-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);


--Part – A

--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.
--Person 

--Insert
create procedure PR_Person_Insert
@FirstName varchar(50) , 
@LastName varchar(50) , 
@salary int , 
@JoiningDate DateTime,
@DepartmentID int ,
@DesignationID int
as 
begin
	Insert into Person (FirstName,LastName,salary,JoiningDate,DepartmentID,DesignationID)
	Values(@FirstName,@LastName,@salary,@JoiningDate,@DepartmentID,@DesignationID)
end

--insert data
exec PR_PERSON_INSERT 'Rahul','Anshu',56000,'1990-01-01',1,12;
exec PR_PERSON_INSERT 'Hardik','Hinsu',18000,'1990-09-25',2,11;
exec PR_PERSON_INSERT 'Bhavin' ,'Kamani' ,25000 ,'1991-05-14' ,NULL, 11;
exec PR_PERSON_INSERT 'Bhoomi','Patel', 39000, '2014-02-20', 1 ,13;
exec PR_PERSON_INSERT 'Rohit','Rajgor', 17000 ,'1990-07-23', 2, 15;
exec PR_PERSON_INSERT 'Priya',' Mehta', 25000 ,'1990-10-18', 2, NULL;
exec PR_PERSON_INSERT 'Neha', 'Trivedi', 18000 ,'2014-02-20', 3, 15;

select * from Person

--Update 

Create PROCEDURE PR_Person_Update
@PID int,
@PName varchar(50)
as
begin 
	update Person 
	set FirstName = @PName 
	where PersonID = @PID
end

--Delete

Create PROCEDURE PR_Person_delete
@PID int 
as
begin
	Delete from Person where PersonID = @PID;
end


--Department 

--Insert
CREATE PROCEDURE PR_Department_Insert
@DID int , @DName varchar(50)
as 
begin 
	Insert into Department Values(@DID, @DName)
end

--insert data 
exec PR_Department_Insert 1 , 'Admin';
exec PR_Department_Insert 2 , 'IT';
exec PR_Department_Insert 3 , 'HR';
exec PR_Department_Insert 4 , 'Account';

select * from Department

--Update
CREATE PROCEDURE PR_Department_Update
@DID int , 
@Dname varchar(50)
as
begin
	Update Department
	Set DepartmentName = @Dname
	where DepartmentID = @DID
end

--Delete 
Create PROCEDURE PR_Department_Delete
@DID int 
as
begin
	Delete 
	from Department 
	where DepartmentID = @DID
end

--Designation 

--Insert
Create PROCEDURE PR_Designation_Insert
@DesID int,
@DesName varchar(50)
as
begin
	Insert into Designation Values(@DesID, @DesName)
end

--insert data
exec PR_Designation_Insert 11 , 'Jobber';
exec PR_Designation_Insert 12 , 'Welder';
exec PR_Designation_Insert 13 , 'Clerk';
exec PR_Designation_Insert 14 , 'Manager';
exec PR_Designation_Insert 15 , 'CEO';

select * from Designation

--Update 
Create PROCEDURE PR_Designation_Update 
@DesID int , 
@DesName varchar(50)
as 
begin
	Update Designation
	Set DesignationName = @DesName 
	where DesignationID = @DesID
end

--Delete 
Create PROCEDURE PR_Designation_Delete 
@DesID int
as
begin
	Delete 
	from Designation 
	Where DesignationID = @DesID
end



--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY

--Person
Create PROCEDURE PR_PERSON_SELECT
@PID int
as 
begin
	Select * from Person 
	Where PersonId = @PID;
end

--Department
Create PROCEDURE PR_Department_SELECT
@DID int
as 
begin
	Select * from Department 
	Where DepartmentID = @DID;
end

--Designation 
Create PROCEDURE PR_Designation_SELECT
@DID int
as 
begin
	Select * from Designation 
	Where DesignationID = @DID;
end

exec PR_Designation_SELECT 15


--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take
--columns on select list)

Create PROCEDURE PR_Person_SELECTALL
@PID int 
as
begin
	Select p.FirstName , d.DepartmentName , ds.DesignationName from
	Person as p	JOIN Department as d 
	on p.departmentID = d.DepartmentId 
	JOIN Designation as ds 
	on p.designationID = ds.DesignationID
	where p.PersonID = @PID
end

execute PR_Person_SELECTALL 112


--4. Create a Procedure that shows details of the first 3 persons.Create PROCEDURE PR_Person_Display_Top_3asbegin	select  top 3 *	from Personendexec PR_Person_Display_Top_3 --Part – B

--5. Create a Procedure that takes the department name as input and returns a 
--table with all workers working in that department.
Create Procedure PR_Department_Worker
@Dname varchar(50)
as
begin
	select * 
	from Person as p join Department as d 
	on p.DepartmentID = d.DepartmentID
	where d.DepartmentName = @Dname
end

exec PR_Department_Worker 'Admin';


--6. Create Procedure that takes department name & designation name 
--as input and returns a table with worker’s first name, salary, joining date & department name.
Create Procedure PR_Department_Designation
@Deptname varchar(50) ,
@Desname varchar(50)
as 
begin
	select p.FirstName,p.Salary,p.JoiningDate,dept.DepartmentName
	from Person as p join Department as dept 
	on p.DepartmentID = dept.DepartmentID
	join Designation as des 
	on p.DesignationID = des.DesignationID
end

exec PR_Department_Designation 'IT','Jobber'


--7. Create a Procedure that takes the first name as an input parameter and 
--display all the details of the worker with their department & designation name.
Create Procedure PR_Person_DeptDes
@FName varchar(50)
as
begin
	select *
	from Person as p join Department as dept 
	on p.DepartmentID = dept.DepartmentID
	join Designation as des 
	on p.DesignationID = des.DesignationID
	where p.FirstName = @FName
end

exec PR_Person_DeptDes 'Rahul'


--8. Create Procedure which displays department wise maximum, minimum & total salaries.
Create Procedure PR_Max_Min_Total_Salaryasbegin	select d.DepartmentName , Max(p.salary) , min(p.salary) , sum(p.salary) 
	from Person as p join Department as d 
	on p.DepartmentID = d.DepartmentID
	group by d.DepartmentName
end

exec PR_Max_Min_Total_Salary--9. Create Procedure which displays designation wise average & total salaries.Create or Alter Procedure PR_Avg_Total_Salary asbegin	Select d.DesignationName , avg(p.salary) as Average_Salary , sum(p.salary) as Total_Salary	from Person as p join Designation as d	on p.DesignationID = d.DesignationID	group by d.DesignationNameendexec PR_Avg_Total_Salary