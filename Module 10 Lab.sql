--demo

USE tempdb;

CREATE FUNCTION dbo.fnEndOfPreviousMonth (@DateToTest date)
RETURNS date
AS BEGIN
  RETURN DATEADD(day, 0 - DAY(@DateToTest), @DateToTest);
END;

select dbo.fnEndofPreviousMonth(SYSDATETIME())
select dbo.fnEndOfPreviousMonth('2018-02-08')

SELECT OBJECTPROPERTY(OBJECT_ID('dbo.fnEndOfPreviousMonth'),'IsDeterministic');
DROP FUNCTION dbo.fnEndOfPreviousMonth;

CREATE FUNCTION dbo.fnEndOfPreviousMonth (@DateToTest date)
RETURNS date
AS BEGIN
  RETURN EOMONTH ( dateadd(month, -1, @DateToTest ));
END;

select dbo.fnEndofPreviousMonth(SYSDATETIME())
select dbo.fnEndOfPreviousMonth('2018-02-08')
DROP FUNCTION dbo.fnEndOfPreviousMonth;


USE AdventureWorks;


CREATE FUNCTION Sales.fnGetLastOrdersForCustomer 
(@CustomerID int, @NumberOfOrders int)
RETURNS TABLE
AS
RETURN (SELECT TOP(@NumberOfOrders) soh.SalesOrderID,soh.OrderDate,soh.PurchaseOrderNumber FROM Sales.SalesOrderHeader AS soh
WHERE soh.CustomerID = @CustomerID
ORDER BY soh.OrderDate DESC);
	
SELECT * FROM Sales.fnGetLastOrdersForCustomer(18754,3);

SELECT c.CustomerID,
             c.AccountNumber,
             glofc.SalesOrderID,
             glofc.OrderDate 
FROM Sales.Customer AS c
CROSS APPLY Sales.fnGetLastOrdersForCustomer(c.CustomerID,2) AS glofc
ORDER BY c.CustomerID,glofc.SalesOrderID;

drop function Sales.fnGetLastOrdersForCustomer


--Lab
USE tempdb;

CREATE FUNCTION dbo.FormatPhoneNumber
( @PhoneNumberToFormat nvarchar(16)
)
RETURNS nvarchar(16)
AS
BEGIN
	DECLARE @Digits nvarchar(16) = '';
	DECLARE @Remaining nvarchar(16) = @PhoneNumberToFormat;
	DECLARE @Character nchar(1);
	
	IF LEFT(@Remaining,1) = N'+' RETURN @Remaining;
	
	WHILE (LEN(@Remaining) > 0) BEGIN
		SET @Character = LEFT(@Remaining,1);
		SET @Remaining = SUBSTRING(@Remaining,2,LEN(@Remaining));
		IF (@Character >= N'0') AND (@Character <= N'9')
			SET @Digits += @Character;
	END;
	RETURN CASE LEN(@Digits)
		WHEN 10 THEN N'(' + SUBSTRING(@Digits,1,3) + N') '
			+ SUBSTRING(@Digits,4,3) + N'-'
			+ SUBSTRING(@Digits,7,4)
		WHEN 8 THEN SUBSTRING(@Digits,1,4) + N'-'
			+ SUBSTRING(@Digits,5,4)
		WHEN 6 THEN SUBSTRING(@Digits,1,3) + N'-'
		+ SUBSTRING(@Digits,4,3)ELSE @Digits
	END;
END;

SELECT dbo.FormatPhoneNumber ('+91-1455454465');
SELECT dbo.FormatPhoneNumber('123 4567890');

CREATE FUNCTION dbo.IntegerListToTable
( @InputList nvarchar(MAX),@Delimiter nchar(1) = N',')
RETURNS @OutputTable TABLE (PositionInList int IDENTITY(1, 1) NOT NULL,IntegerValue int)
AS BEGIN
		INSERT INTO @OutputTable (IntegerValue)
		SELECT Value FROM STRING_SPLIT ( @InputList , @Delimiter );
	RETURN;
END;


SELECT * FROM IntegerListToTable('123-456789-0123-0','-');
SELECT * FROM IntegerListToTable('123,456789,012345',',');