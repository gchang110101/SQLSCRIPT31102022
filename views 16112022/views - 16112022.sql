SELECT CONCAT (E.FirstName , ' ' , E.LastName) Empleado, B.Nombre Beneficio, T.TerritoryDescription
FROM [dbo].[Beneficios] B INNER JOIN [dbo].[Employees] E
	ON B.ID = E.id_beneficio
	LEFT JOIN [dbo].[EmployeeTerritories] ET
	ON E.EmployeeID = ET.EmployeeID
	LEFT JOIN [dbo].[Territories] T
	ON ET.TerritoryID = T.TerritoryID

SELECT * FROM [dbo].[Beneficios]

SELECT * FROM [dbo].[EmployeeTerritories]

SELECT * FROM [dbo].[Employees]

SELECT * FROM [dbo].[Territories]

SELECT P.ProductName, Categeoria=
	CASE C.CategoryName
		WHEN 'Beverages' THEN 'Bebidas'
		WHEN 'Condiments' THEN 'Comidas'
		ELSE 'OTROS'
	END
FROM [dbo].[Categories] C INNER JOIN [dbo].[Products] P
	ON C.CategoryID = P.CategoryID


--VISTAS
CREATE VIEW VW_EMPLEADOBENEFICIO
AS
SELECT CONCAT (E.FirstName , ' ' , E.LastName) Empleado, B.Nombre Beneficio--, T.TerritoryDescription
FROM [dbo].[Beneficios] B INNER JOIN [dbo].[Employees] E
	ON B.ID = E.id_beneficio

SELECT * FROM [dbo].[VW_EMPLEADOBENEFICIO]


UPDATE [dbo].[VW_EMPLEADOBENEFICIO]
	SET Beneficio = 'SCHOOL'
	WHERE Empleado = 'Nancy Davolio'

ALTER TABLE [dbo].[Beneficios]
	ALTER COLUMN ID INT IDENTITY(1, 1)