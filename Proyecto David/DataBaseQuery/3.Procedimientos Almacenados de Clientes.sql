-- Procedimientos de CLIENTE

-- SELECT 

DROP PROCEDURE IF EXISTS SELECCIONAR_CLIENTE
GO

CREATE PROCEDURE SELECCIONAR_CLIENTE @CEDULA NCHAR(12)
AS
BEGIN
	SELECT CEDULA, NOMBRE, APELLIDO, DIRECCION, TELEFONO, EMAIL, LICENCIA FROM dbo.[CLIENTE]
	WHERE CEDULA = @CEDULA
END

-- INSERT 

DROP PROCEDURE IF EXISTS INSERTAR_CLIENTE
GO

CREATE PROCEDURE INSERTAR_CLIENTE @CEDULA NCHAR(12), @NOMBRE NCHAR(100), @APELLIDO NCHAR(100),
	@DIRECCION NCHAR(250), @TELEFONO NCHAR(20), @EMAIL NCHAR(250), @LICENCIA NCHAR(20),@CONTRA NCHAR(100)
AS 
BEGIN
	SELECT @CONTRA = CONVERT( varchar(500), dbo.fx_Proyecto (@CONTRA))
	
	Open SYMMETRIC KEY lallave
	DECRYPTION BY PASSWORD = '%La/Mama/Es/La/Mama/De/Las/Mamases/Mundiales%'
	
	INSERT INTO dbo.[CLIENTE](CEDULA, NOMBRE, APELLIDO, DIRECCION, TELEFONO, EMAIL, LICENCIA, CONTRA)
	VALUES(@CEDULA, @NOMBRE, @APELLIDO, @DIRECCION, @TELEFONO, @EMAIL, @LICENCIA, EncryptByPassPhrase
	(@CONTRA, EncryptByKey(Key_GUID('lallave'), @CONTRA)))
	
	CLOSE SYMMETRIC KEY lallave
END

-- UPDATE

DROP PROCEDURE IF EXISTS ACTUALIZAR_CLIENTE
GO

CREATE PROCEDURE ACTUALIZAR_CLIENTE @CEDULA NCHAR(12), @NOMBRE NCHAR(100), @APELLIDO NCHAR(100),
	@DIRECCION NCHAR(250), @TELEFONO NCHAR(20), @EMAIL NCHAR(250), @LICENCIA NCHAR(20)
AS 
BEGIN 
	IF @APELLIDO IS NULL AND @DIRECCION IS NULL AND @TELEFONO IS NULL AND @EMAIL IS NULL AND 
	@LICENCIA IS NULL
	UPDATE dbo.[CLIENTE]
	SET NOMBRE = @NOMBRE
	WHERE CEDULA = @CEDULA
	ELSE IF @NOMBRE IS NULL AND @DIRECCION IS NULL AND @TELEFONO IS NULL AND @EMAIL IS NULL AND 
	@LICENCIA IS NULL
	UPDATE dbo.[CLIENTE]
	SET APELLIDO = @APELLIDO
	WHERE CEDULA = @CEDULA
	ELSE IF @NOMBRE IS NULL AND @APELLIDO IS NULL AND @TELEFONO IS NULL AND @EMAIL IS NULL AND 
	@LICENCIA IS NULL
	UPDATE dbo.[CLIENTE]
	SET DIRECCION = @DIRECCION
	WHERE CEDULA = @CEDULA
	ELSE IF @NOMBRE IS NULL AND @APELLIDO IS NULL AND @DIRECCION IS NULL AND @EMAIL IS NULL AND 
	@LICENCIA IS NULL
	UPDATE dbo.[CLIENTE]
	SET TELEFONO = @TELEFONO
	WHERE CEDULA = @CEDULA
	ELSE IF @NOMBRE IS NULL AND @APELLIDO IS NULL AND @DIRECCION IS NULL AND @TELEFONO IS NULL AND 
	@LICENCIA IS NULL
	UPDATE dbo.[CLIENTE]
	SET EMAIL = @EMAIL
	WHERE CEDULA = @CEDULA
	ELSE IF @NOMBRE IS NULL AND @APELLIDO IS NULL AND @DIRECCION IS NULL AND @TELEFONO IS NULL AND 
	@EMAIL IS NULL
	UPDATE dbo.[CLIENTE]
	SET LICENCIA = @LICENCIA
	WHERE CEDULA = @CEDULA
	ELSE
	UPDATE dbo.[CLIENTE]
	SET NOMBRE = @NOMBRE, APELLIDO = @APELLIDO, DIRECCION = @DIRECCION, TELEFONO = @TELEFONO,
	EMAIL = @EMAIL, LICENCIA = @LICENCIA
	WHERE CEDULA = @CEDULA
END

-- DELETE 
DROP PROCEDURE IF EXISTS ELIMINAR_CLIENTE
GO

CREATE PROCEDURE ELIMINAR_CLIENTE @CEDULA NCHAR(12)
AS 
BEGIN
	DELETE FROM CLIENTE
	WHERE CEDULA = @CEDULA
END
GO