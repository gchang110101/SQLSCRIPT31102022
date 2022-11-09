--CONSULTA SENCILLA ORDENADO EL NOMBRE ALFABETICAMENTE
USE Northwind

SELECT *
FROM [dbo].[Beneficios]
ORDER BY Nombre ASC

--consulta asignando alias a la tabla anterior y ordenando el nombre alfbéticamente
SELECT B.Nombre, FirstName
FROM [dbo].[Beneficios] AS B, [dbo].[Employees] AS E
WHERE B.ID = E.id_beneficio
ORDER BY FirstName ASC

-- SE ASIGNA ENCABEZADO A UNA COLUMNA
SELECT E.FirstName as Nombre_beneficiado, B.Nombre AS Nombre_de_Beneficio
FROM [dbo].[Beneficios] AS B, [dbo].[Employees] AS E
WHERE B.ID = E.id_beneficio
ORDER BY Nombre_beneficiado ASC

-- CONDICIO Y OTRO TIPO DE ENCABEZADO
SELECT BENEFICIO = Nombre
FROM [dbo].[Beneficios]
WHERE ID < 6 AND Nombre = 'ALIMENTACION'

-- DEVOLVER VENTAS TOTALES Y DESCUENTOS DE CADA ORDEN
SELECT * FROM [dbo].[Order Details]

SELECT * FROM [dbo].[Products]

CREATE VIEW PRUBEA
AS 
SELECT OD.Discount, P.ProductName, 
	VENTASTOT = (OD.UnitPrice*OD.Quantity),
	VENTADESC = ((OD.UnitPrice*OD.Quantity)*OD.Discount)

FROM [dbo].[Order Details] AS OD, [dbo].[Products] AS P
WHERE OD.ProductID = P.ProductID

SELECT PRODUCTNAME, VENTASTOT
FROM [dbo].[PRUBEA]

SELECT *
FROM [dbo].[PRUBEA]

--COUNT
SELECT COUNT(VENTASTOT)
FROM [dbo].[PRUBEA]

--CONCATENAR Y CADENAS
SELECT 'EL NOMBRE ES: ' + FirstName + ' ' + LastName AS NOMBRE_COMPLETO
FROM [dbo].[Employees]