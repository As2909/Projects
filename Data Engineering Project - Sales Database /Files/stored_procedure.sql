USE adwtransformed2_db
GO

CREATE OR ALTER PROCEDURE CreateSqlSeverlessViews_adw @ViewName NVARCHAR(100)
AS
BEGIN
DECLARE @statement VARCHAR(MAX)
SET @statement = N'CREATE OR ALTER VIEW ' + QUOTENAME(@ViewName) +  ' AS 
    SELECT *
     FROM
                  OPENROWSET(
                           BULK = ''https://etlstorage507.dfs.core.windows.net/transformation-2/SalesLT/' + 
                           @ViewName + '/'',
                           FORMAT = ''DELTA''
                   ) AS [result];'
Exec (@statement)
END
GO

