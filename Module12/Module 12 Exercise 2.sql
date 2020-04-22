
-------------------Exercise 2: Using Natively Compiled Stored Procedures Scenario ---------------------


-------------Task 1: Create Natively Compiled Stored Procedures ---------------------------

USE InternetSales 
GO
CREATE PROCEDURE dbo.AddItemToCart
	@SessionID INT, 
@TimeAdded DATETIME, 
@CustomerKey INT, 
@ProductKey INT, 
@Quantity INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	INSERT INTO dbo.ShoppingCart VALUES (@SessionID, @TimeAdded,	@CustomerKey, @ProductKey, @Quantity)
END
GO


CREATE PROCEDURE dbo.DeleteItemFromCart
	@SessionID INT, 
	@ProductKey INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	DELETE FROM dbo.ShoppingCart WHERE SessionID = @SessionID AND ProductKey = @ProductKey
END
GO

CREATE PROCEDURE dbo.EmptyCart
	@SessionID INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	DELETE FROM dbo.ShoppingCart   WHERE SessionID = @SessionID
END
GO


---------------------------------------------------------------

declare @datetime datetime =getdate();
EXEC dbo.AddItemToCart @SessionID = 3,@TimeAdded =@datetime ,@CustomerKey = 2,@ProductKey = 3,@Quantity = 1;

EXEC dbo.AddItemToCart  
	@SessionID = 3,@TimeAdded = @datetime,@CustomerKey = 2,@ProductKey = 4,@Quantity = 1;

SELECT * FROM dbo.ShoppingCart;

EXEC dbo.DeleteItemFromCart @SessionID = 3, @ProductKey = 4;
		
SELECT * FROM dbo.ShoppingCart;

EXEC dbo.EmptyCart @SessionID = 3;
	
SELECT * FROM dbo.ShoppingCart;