use UNIVERSIDAD;

CREATE TABLE PERSONA (
	CIF INT NOT NULL,
	NOMBRE VARCHAR(30) NOT NULL,
	CORREO VARCHAR(30)
)

ALTER TABLE [dbo].[PERSONA]
	--ADD CONSTRAINT PK_CIF PRIMARY KEY(CIF)
	--ADD CONSTRAINT DF_NOMBRE DEFAULT '---' FOR NOMBRE
	ADD CONSTRAINT DF_CORREO DEFAULT '---@gmail.com' FOR CORREO

SELECT CIF AS ID_PERSONA, NOMBRE AS NAME
FROM [dbo].[PERSONA]
WHERE CIF NOT LIKE 19014795

SELECT *
FROM [dbo].[PERSONA]

INSERT INTO [dbo].[PERSONA] 
	VALUES(18019050, 'ANDRES', 'ANDRES@gmail.com'),
	(16017055, 'MARIO', 'MARIO@gmail.com'),
	(13014022, 'LUIGI', 'LUIGI@gmail.com'),
	(19014795, '', '')

INSERT INTO [dbo].[PERSONA] 
	VALUES(555, 'TEST', '')

DELETE FROM [dbo].[PERSONA]
WHERE CIF = 555

--UPDATE [dbo].[PERSONA]
--SET NOMBRE = 'GABRIEL', CORREO = 'gdchang@uamv.edu.ni'
--WHERE CIF = 19014795

--TRUNCATE TABLE [dbo].[PERSONA]

DELETE FROM [dbo].[PERSONA]
WHERE CIF = 18019050

DROP TABLE [dbo].[PERSONA]