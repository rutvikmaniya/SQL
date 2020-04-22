
-----------------------Lab Exercise 1------------------	


-------------------- Add a Filegroup for Memory-Optimized Data -----------------

ALTER DATABASE InternetSales ADD FILEGROUP manish 
CONTAINS MEMORY_OPTIMIZED_DATA; 
ALTER DATABASE InternetSales ADD FILE (NAME = 'manish', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\manish')
TO FILEGROUP manish;

--------------- Create a Memory-Optimized Table -----------------------
USE InternetSales
GO

create table dbo.ShoppingCart 
(
SessionID int not null,
TimeAdded datetime not null,
CustomerKey int not null,
ProductKey int not null,
Quantity int not null
primary key nonclustered (SessionID,ProductKey))
with (memory_optimized=on,durability=schema_and_data);


insert into ShoppingCart 
values (1, GETDATE(), 2, 3, 1);

insert into ShoppingCart 
values (1, GETDATE(), 2, 4, 1);

	
SELECT * FROM dbo.ShoppingCart;
