-- TRIGGERS

-- Tablas de Bitacora

USE DB_DELTA

DROP TABLE IF EXISTS ALQUILER_BIT
CREATE TABLE ALQUILER_BIT (
	MATRICULA NCHAR(6),
	CEDULA_CLIENTE NCHAR(12),
	FECHA_INICIO_ALQUILER DATE,
	FECHA_FINAL_ALQUILER DATE,

	EXE_USER VARCHAR(50),
	EXE_MAQUINA VARCHAR(50),
	EXE_DATE DATETIME,
	EXE_ACCION VARCHAR(2)
)

DROP TABLE IF EXISTS AUTO_BIT
CREATE TABLE AUTO_BIT (
	NUMPLACA NCHAR(6),
	MARCA NCHAR(100),
	ID_DISTRIBUIDOR INT,
	TIPO_MOTOR NCHAR(100),
	AUTO_ANIO INT,
	PRECIO_ALQUILER DECIMAL(6,2),

	EXE_USER VARCHAR(50),
	EXE_MAQUINA VARCHAR(50),
	EXE_DATE DATETIME,
	EXE_ACCION VARCHAR(2)
)

DROP TABLE IF EXISTS CLIENTE_BIT
CREATE TABLE CLIENTE_BIT (
	CEDULA NCHAR(12),
	NOMBRE NCHAR(100),
	APELLIDO NCHAR(100),
	DIRECCION NCHAR(250),
	EMAIL NCHAR(250),
	LICENCIA NCHAR(20),

	EXE_USER VARCHAR(50),
	EXE_MAQUINA VARCHAR(50),
	EXE_DATE DATETIME,
	EXE_ACCION VARCHAR(2)
)

DROP TABLE IF EXISTS DISTRIBUIDOR_BIT
CREATE TABLE DISTRIBUIDOR_BIT (
	ID INT,
	NOMBRE NCHAR(100),
	DIRECCION NCHAR(250),
	CIUDAD NCHAR(100),
	TELEFONO NCHAR(20),
	EMAIL NCHAR(250),

	EXE_USER VARCHAR(50),
	EXE_MAQUINA VARCHAR(50),
	EXE_DATE DATETIME,
	EXE_ACCION VARCHAR(2)
)

-- TRIGGERS PARA LA BITACORA ALQUILER

-- TRIGGER INSERT

USE DB_DELTA
DROP TRIGGER IF EXISTS TRG_ALQUILER_I
GO

CREATE TRIGGER TRG_ALQUILER_I
	ON dbo.[ALQUILER]
	AFTER INSERT
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[ALQUILER_BIT](MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'I'
	FROM INSERTED
END
GO

-- TRIGGER DELETE
DROP TRIGGER IF EXISTS TRG_ALQUILER_D
GO

CREATE TRIGGER TRG_ALQUILER_D
	ON dbo.[ALQUILER]
	AFTER DELETE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[ALQUILER_BIT](MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'D'
	FROM DELETED
END
GO

-- TRIGGER UPDATE

DROP TRIGGER IF EXISTS TRG_ALQUILER_U
GO

CREATE TRIGGER TRG_ALQUILER_U
	ON dbo.[ALQUILER]
	AFTER UPDATE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[ALQUILER_BIT](MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'UI'
	FROM INSERTED

	INSERT INTO dbo.[ALQUILER_BIT](MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT MATRICULA, CEDULA_CLIENTE,FECHA_INICIO_ALQUILER,FECHA_FINAL_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'UD'
	FROM DELETED
END
GO

-- TRIGGERS PARA LA BITACORA AUTO

-- TRIGGER INSERT

DROP TRIGGER IF EXISTS TRG_AUTO_I
GO

CREATE TRIGGER TRG_AUTO_I
	ON dbo.[AUTO]
	AFTER INSERT
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[AUTO_BIT](NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'I'
	FROM INSERTED
END
GO

-- TRIGGER DELETE

DROP TRIGGER IF EXISTS TRG_AUTO_D
GO

CREATE TRIGGER TRG_AUTO_D
	ON dbo.[AUTO]
	AFTER DELETE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[AUTO_BIT](NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'D'
	FROM DELETED
END
GO

-- TRIGGER UPDATE

DROP TRIGGER IF EXISTS TRG_AUTO_U
GO

CREATE TRIGGER TRG_AUTO_U
	ON dbo.[AUTO]
	AFTER UPDATE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[AUTO_BIT](NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'UI'
	FROM INSERTED

	INSERT INTO dbo.[AUTO_BIT](NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT NUMPLACA,MARCA,ID_DISTRIBUIDOR,TIPO_MOTOR,AUTO_ANIO,PRECIO_ALQUILER,SUSER_NAME(), HOST_NAME(), GETDATE(), 'UD'
	FROM DELETED
END
GO

-- TRIGGERS PARA LA BITACORA CLIENTE

-- TRIGGER INSERT

DROP TRIGGER IF EXISTS TRG_CLIENTE_I
GO

CREATE TRIGGER TRG_CLIENTE_I
	ON dbo.[CLIENTE]
	AFTER INSERT
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[CLIENTE_BIT](CEDULA,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT CEDULA ,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA,SUSER_NAME(), HOST_NAME(), GETDATE(), 'I'
	FROM INSERTED
END
GO

-- TRIGGER DELETE

DROP TRIGGER IF EXISTS TRG_CLIENTE_D
GO

CREATE TRIGGER TRG_CLIENTE_D
	ON dbo.[CLIENTE]
	AFTER DELETE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[CLIENTE_BIT](CEDULA,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT CEDULA,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA, SUSER_NAME(), HOST_NAME(), GETDATE(), 'D'
	FROM DELETED
END
GO

-- TRIGGER UPDATE

DROP TRIGGER IF EXISTS TRG_CLIENTE_U
GO

CREATE TRIGGER TRG_CLIENTE_U
	ON dbo.[CLIENTE]
	AFTER UPDATE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[CLIENTE_BIT](CEDULA,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT CEDULA,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA, SUSER_NAME(), HOST_NAME(), GETDATE(), 'UI'
	FROM INSERTED

	INSERT INTO dbo.[CLIENTE_BIT](CEDULA,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT CEDULA,NOMBRE,APELLIDO,DIRECCION,EMAIL,LICENCIA, SUSER_NAME(), HOST_NAME(), GETDATE(), 'UD'
	FROM DELETED
END
GO

-- TRIGGERS PARA LA BITACORA DISTRIBUIDOR

-- TRIGGER INSERT

DROP TRIGGER IF EXISTS TRG_DISTRIBUIDOR_I
GO

CREATE TRIGGER TRG_DISTRIBUIDOR_I
	ON dbo.[DISTRIBUIDOR]
	AFTER INSERT
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[DISTRIBUIDOR_BIT](ID,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT ID ,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL,SUSER_NAME(), HOST_NAME(), GETDATE(), 'I'
	FROM INSERTED
END
GO

-- TRIGGER DELETE

DROP TRIGGER IF EXISTS TRG_DISTRIBUIDOR_D
GO

CREATE TRIGGER TRG_DISTRIBUIDOR_D
	ON dbo.[DISTRIBUIDOR]
	AFTER DELETE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[DISTRIBUIDOR_BIT](ID,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT ID ,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL,SUSER_NAME(), HOST_NAME(), GETDATE(), 'D'
	FROM DELETED
END
GO

-- TRIGGER UPDATE

DROP TRIGGER IF EXISTS TRG_DISTRIBUIDOR_U
GO

CREATE TRIGGER TRG_DISTRIBUIDOR_U
	ON dbo.[DISTRIBUIDOR]
	AFTER UPDATE
AS 
BEGIN
SET NOCOUNT ON;

	INSERT INTO dbo.[DISTRIBUIDOR_BIT](ID,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT ID,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL, SUSER_NAME(), HOST_NAME(), GETDATE(), 'UI'
	FROM INSERTED

	INSERT INTO dbo.[DISTRIBUIDOR_BIT](ID,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL, EXE_USER, EXE_MAQUINA, EXE_DATE, EXE_ACCION)
	SELECT ID,NOMBRE,DIRECCION,CIUDAD,TELEFONO,EMAIL, SUSER_NAME(), HOST_NAME(), GETDATE(), 'UD'
	FROM DELETED
END
GO