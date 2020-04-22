
---------------  DEMO 2   ------------------------


USE MemDemo

CREATE PROCEDURE dbo.InsertData
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')
	DECLARE @Memid int = 1
	WHILE @Memid <= 699999
	BEGIN
		INSERT INTO dbo.MemoryTable VALUES (@Memid, GETDATE())
		SET @Memid += 1
	END
END;
GO

EXEC dbo.InsertData;


SELECT COUNT(*) FROM dbo.MemoryTable;