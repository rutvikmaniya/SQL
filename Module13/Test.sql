USE AdventureWorks2014;
GO

--------------- Test the Scalar-Valued Function --------------

SELECT * 
	FROM Production.Product
	WHERE dbo.IsRegexMatch (Name, N'\b[Ww]heel\b') = 1; 

SELECT * 
	FROM Production.Product
	WHERE dbo.IsRegexMatch (Name, N'\bMen\b') = 1; 



---------------------------Test the Table-Valued Function ---------------------


SELECT *
	FROM dbo.RegexMatches(N'The quick brown fox jumped over the lazy dog.', N'[fd]o[xg]');



--------------------------------------------------------------------------------
-- Search Product color

--------------------------------------------------------------------------------

SELECT P.ProductID, P.Color, M.match
	FROM Production.Product AS P
		CROSS APPLY dbo.RegexMatches(P.Color, N'Silver|Black') AS M
	ORDER BY ProductID;


--------------------------------------------------------------------------------
-- Search ProductDescription for The and the following word
--------------------------------------------------------------------------------

SELECT P.ProductDescriptionID, P.[Description], M.match
	FROM Production.ProductDescription AS P
		CROSS APPLY dbo.RegexMatches(P.[Description], N'[Tt]he [A-Za-z0-9\-]+') AS M
	ORDER BY P.ProductDescriptionID;

	
----------------------------------------------------------------------------
-- Search ProductDescription for numbers and the following word
--------------------------------------------------------------------------------

SELECT P.ProductDescriptionID, P.[Description], M.match
	FROM Production.ProductDescription AS P
		CROSS APPLY dbo.RegexMatches(P.[Description], N'[0-9]+[ ]?[A-Za-z0-9\-]+') AS M
	ORDER BY P.ProductDescriptionID;




--------------------------- Test StringAggregate --------------------------------



SELECT Name
	FROM (VALUES (N'Hello'),
				(N'Rutvik')) AS X (Name);


SELECT dbo.StringAggregate(Name) AS 'AggregatedName'
	FROM (VALUES (N'Hello'),
				(N'Rutvik')) AS X (Name);



--------------------------------------------------------------------------------
-- Starter query
-- So we can see how the query works without any grouping
-------------------------------------------------------------------------------

WITH CustomerCategory_CTE AS
(
	SELECT H.CustomerID, PC.Name AS Category
		FROM Sales.SalesOrderHeader AS H
			INNER JOIN Sales.SalesOrderDetail AS D
				ON D.SalesOrderID = H.SalesOrderID
			INNER JOIN Production.Product AS X
				ON X.ProductID = D.ProductID
			INNER JOIN Production.ProductSubcategory AS PS
				ON PS.ProductSubcategoryID = X.ProductSubcategoryID
			INNER JOIN Production.ProductCategory AS PC
				ON PC.ProductCategoryID = PS.ProductCategoryID
		GROUP BY H.CustomerID, PC.Name
)

SELECT P.BusinessEntityID, CONCAT(P.FirstName + N' ', P.MiddleName + N' ', P.LastName) AS PersonName, CC.Category
	FROM CustomerCategory_CTE AS CC
		INNER JOIN Sales.Customer AS C
			ON C.CustomerID = CC.CustomerID
		INNER JOIN Person.Person AS P
			ON P.BusinessEntityID = C.PersonID
	ORDER BY P.LastName, P.FirstName, P.BusinessEntityID;



--------------------------------------------------------------------------------
-- Test StringAggregate
-------------------------------------------------------------------------------

WITH CustomerCategory_CTE AS
(
	SELECT H.CustomerID, PC.Name AS Category
		FROM Sales.SalesOrderHeader AS H
			INNER JOIN Sales.SalesOrderDetail AS D
				ON D.SalesOrderID = H.SalesOrderID
			INNER JOIN Production.Product AS X
				ON X.ProductID = D.ProductID
			INNER JOIN Production.ProductSubcategory AS PS
				ON PS.ProductSubcategoryID = X.ProductSubcategoryID
			INNER JOIN Production.ProductCategory AS PC
				ON PC.ProductCategoryID = PS.ProductCategoryID
		GROUP BY H.CustomerID, PC.Name
)

SELECT P.BusinessEntityID, CONCAT(P.FirstName + N' ', P.MiddleName + N' ', P.LastName) AS PersonName, dbo.StringAggregate(CC.Category) AS Categories
	FROM CustomerCategory_CTE AS CC
		INNER JOIN Sales.Customer AS C
			ON C.CustomerID = CC.CustomerID
		INNER JOIN Person.Person AS P
			ON P.BusinessEntityID = C.PersonID
	GROUP BY P.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName
	ORDER BY P.LastName, P.FirstName, P.BusinessEntityID;
