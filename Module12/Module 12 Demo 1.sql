

----------DEMO 1------------------

USE MemDemo
GO
CREATE TABLE dbo.MemoryTable
(id INTEGER NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 1000000),
 date_value DATETIME NULL)
WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);


CREATE TABLE dbo.DiskTable
(id INTEGER NOT NULL PRIMARY KEY NONCLUSTERED,
 date_value DATETIME NULL);


BEGIN TRAN
	DECLARE @Diskid int = 1
	WHILE @Diskid <= 699999
	BEGIN
		INSERT INTO dbo.DiskTable VALUES (@Diskid, GETDATE())
		SET @Diskid += 1
	END
COMMIT;

SELECT COUNT(*) FROM dbo.DiskTable;
select *from DiskTable


BEGIN TRAN
	DECLARE @Memid int = 1
	WHILE @Memid <= 699999
	BEGIN
		INSERT INTO dbo.MemoryTable VALUES (@Memid, GETDATE())
		SET @Memid += 1
	END
COMMIT;

SELECT COUNT(*) FROM dbo.MemoryTable;

DELETE FROM DiskTable;

DELETE FROM MemoryTable;

SELECT o.Name, m.*
FROM
sys.dm_db_xtp_table_memory_stats m
JOIN sys.sysobjects o
ON m.object_id = o.id
