use master

exec sp_configure 'clr enabled',1
reconfigure

ALTER DATABASE DB_Delta SET TRUSTWORTHY ON

use DB_Delta

CREATE ASSEMBLY Proyecto from 'C:\Windows\Proyecto.dll'
WITH PERMISSION_SET = SAFE

CREATE FUNCTION dbo.fx_Proyecto
(
  @Cadena as nvarchar(4000)
)
RETURNS nvarchar(4000)
AS 	EXTERNAL NAME Proyecto[Proyecto.Program].DesEncripta

go
