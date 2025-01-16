-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);


-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);



--Part - A


--1. Create a cursor Product_Cursor to fetch all the rows from a products table.
Declare @id int ,@name varchar(50), @price decimal(10,2)

Declare Cursor_All_Rows Cursor 
For Select Product_id,Product_Name , Price from Products

Open Cursor_All_Rows;

Fetch Next From Cursor_All_Rows Into @id , @name , @price

while @@Fetch_Status = 0
	begin 
		print cast(@id as varchar) + '-'+ @name + '-' +cast(@price as varchar);

		Fetch Next From Cursor_All_Rows Into @id ,@name ,@price

	end

close Cursor_All_Rows;

Deallocate Cursor_All_Rows;



--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.
--(Example: 1_Smartphone)

Declare @id int , @name varchar(100)

Declare Cursor_One_Row Cursor
For Select Product_id , Product_Name  from Products

Open Cursor_One_Row;

Fetch Next From Cursor_One_Row Into @id , @name

while @@Fetch_Status = 0
	begin 
		Print cast(@id as varchar) + '_' + @name
		
		Fetch Next from Cursor_One_Row Into @id ,@name

	end

Close Cursor_One_Row;

Deallocate Cursor_One_Row;


--3. Create a Cursor to Find and Display Products Above Price 30,000.
Declare @id int , @name varchar(100) , @price decimal(10,2)

Declare Cursor_Salary Cursor 
For 
	Select * from Products
	where price > 30000

Open Cursor_Salary 

Fetch Next From Cursor_Salary Into @id , @name , @price

while @@Fetch_Status = 0
	begin 
		print cast(@id as varchar) + '-'+ @name + '-' +cast(@price as varchar);

		Fetch Next From Cursor_Salary Into @id ,@name ,@price

	end

close Cursor_Salary;

Deallocate Cursor_Salary;




--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.Declare @id int 

Declare Cursor_Delete Cursor 
For 
	Select Product_id from Products

Open Cursor_Delete  

Fetch Next From Cursor_Delete  Into @id 

while @@Fetch_Status = 0
	begin 
		Delete from Products
		Where Product_id = @id

		Fetch Next From Cursor_Delete  Into @id 

	end

close Cursor_Delete ;

Deallocate Cursor_Delete ;


--Part – B


--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases
--the price by 10%.
Declare @id int ,@name varchar(50), @price decimal(10,2)

Declare Cursor_Update Cursor 
For Select Product_id,Product_Name , Price from Products

Open Cursor_Update;

Fetch Next From Cursor_Update Into @id , @name , @price

while @@Fetch_Status = 0
	begin 
		Update Products
		Set price = Price + (price*10)/100
		where Product_id = @id

		Fetch Next From Cursor_Update Into @id ,@name ,@price

	end

close Cursor_Update;

Deallocate Cursor_Update;

select * from Products

--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
Declare @id int ,@name varchar(50), @price decimal(10,2)

Declare Cursor_Update Cursor 
For Select Product_id,Product_Name , Price from Products

Open Cursor_Update;

Fetch Next From Cursor_Update Into @id , @name , @price

while @@Fetch_Status = 0
	begin 
		Update Products
		Set price = round(price,0)

		Fetch Next From Cursor_Update Into @id ,@name ,@price

	end

close Cursor_Update;

Deallocate Cursor_Update;



--Part – C


--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”
--(Note: Create NewProducts table first with same fields as Products table)
CREATE TABLE NewProducts (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);


Declare @id int ,@name varchar(50), @price decimal(10,2)

Declare Cursor_Insert Cursor 
For Select Product_id,Product_Name , Price from Products

Open Cursor_Insert ;

Fetch Next From Cursor_Insert  Into @id , @name , @price

while @@Fetch_Status = 0
	begin 
		Insert Into NewProducts Values(@id , @name , @price)

		Fetch Next From Cursor_Insert  Into @id ,@name ,@price

	end

close Cursor_Insert ;

Deallocate Cursor_Insert ;

select * from NewProducts


--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products
--with a price above 50000 to an archive table, removing them from the original Products table.
CREATE TABLE ArchivedProducts (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);


Declare @id int ,@name varchar(50), @price decimal(10,2)

Declare Cursor_High Cursor 
For 
	Select Product_id,Product_Name , Price from Products
	Where price > 50000

Open Cursor_High ;

Fetch Next From Cursor_High  Into @id , @name , @price

while @@Fetch_Status = 0
	begin 
		Insert Into ArchivedProducts Values(@id , @name , @price)

		Delete From Products
		Where Product_id = @id

		Fetch Next From Cursor_High  Into @id ,@name ,@price

	end

close Cursor_High ;

Deallocate Cursor_High ;

select * from Products

Select * from ArchivedProducts

