CREATE DATABASE  PRESTAMOSBIBLIOTECAUAMPAC2
	ON PRIMARY
		(NAME='PRESTAMOSBIBLIOTECAUAMPAC2',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PRESTAMOSBIBLIOTECAUAMPAC2.MDF',SIZE=1000MB,MAXSIZE=5000MB,FILEGROWTH=25%)
	LOG ON
		(NAME='PRESTAMOSBIBLIOTECAUAMPAC2_LOG',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PRESTAMOSBIBLIOTECAUAMPAC2_LOG.LDF',SIZE=500MB,MAXSIZE=1000MB,FILEGROWTH=50%)

/*CREATE DATABASE  PRESTAMOSBIBLIOTECAUAMPAC
	ON PRIMARY
		(NAME='PRESTAMOSBIBLIOTECAUAMPAC',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\DATA\PRESTAMOSBIBLIOTECAUAMPAC.MDF',SIZE=1000MB,MAXSIZE=5000MB,FILEGROWTH=25%)
	LOG ON
		(NAME='PRESTAMOSBIBLIOTECAUAMPAC_LOG',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\DATA\PRESTAMOSBIBLIOTECAUAMPAC_LOG.LDF',SIZE=500MB,MAXSIZE=1000MB,FILEGROWTH=50%)

		Para crearlo en Pc Carlos
*/


--Commands completed successfully.
--Completion time: 2022-11-03T11:35:33.0730819-06:00


USE PRESTAMOSBIBLIOTECAUAMPAC2;
/*Commands completed successfully.

Completion time: 2022-11-03T11:36:52.7728292-06:00*/

CREATE SCHEMA RRHH;
/*Commands completed successfully.

Completion time: 2022-11-03T11:37:07.1234140-06:00*/

CREATE SCHEMA CATALOGO;
/*Commands completed successfully.

Completion time: 2022-11-03T11:37:20.3239984-06:00*/

CREATE SCHEMA PRESTAMOS;
/*Commands completed successfully.

Completion time: 2022-11-03T11:37:34.7007037-06:00
*/

CREATE TABLE CATALOGO.Autor
	(codigo_autor VARCHAR(10) CONSTRAINT pk_autor PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
)
/*
Commands completed successfully.

Completion time: 2022-11-07T17:22:39.9883214-06:00

*/

CREATE TABLE CATALOGO.Editorial
	(codigo_editorial VARCHAR(12) CONSTRAINT pk_editorial PRIMARY KEY,
	nombre_editorial VARCHAR(20) NOT NULL
)
/*Commands completed successfully.

Completion time: 2022-11-07T17:22:59.5017841-06:00
*/


CREATE TABLE CATALOGO.Clasificacion
	(codigo_clasificacion VARCHAR(12) CONSTRAINT pk_clasificacion PRIMARY KEY,
	nombre_clasificacion VARCHAR(12) NOT NULL
)
/*Commands completed successfully.

Completion time: 2022-11-07T17:23:14.3933154-06:00
*/

CREATE TABLE CATALOGO.Libro
	(ISBN VARCHAR(14) CONSTRAINT pk_libro PRIMARY KEY,
	titulo VARCHAR(30) NOT NULL,
	MFN VARCHAR(12),
	codigo_editorial VARCHAR(12) CONSTRAINT fk_editorial_libro FOREIGN KEY REFERENCES [CATALOGO].[Editorial](codigo_editorial) ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_clasificacion VARCHAR(12) CONSTRAINT fk_clasificacion_libro FOREIGN KEY REFERENCES [CATALOGO].[Clasificacion](codigo_clasificacion) ON UPDATE CASCADE ON DELETE CASCADE
)
/*Commands completed successfully.

Completion time: 2022-11-07T17:23:29.2110147-06:00*/

CREATE TABLE CATALOGO.AutorXLibro
	(ISBN VARCHAR(14) CONSTRAINT fk_libro_AutorXLibro FOREIGN KEY REFERENCES [CATALOGO].[Libro](ISBN)ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_autor VARCHAR(10) CONSTRAINT fk_autor_AutorXLibro FOREIGN KEY REFERENCES [CATALOGO].[Autor](codigo_autor)ON UPDATE CASCADE ON DELETE CASCADE,
)

/*Commands completed successfully.

Completion time: 2022-11-07T17:23:43.3260849-06:00*/


CREATE TABLE CATALOGO.Ubicacion
	(codigo_ubicacion VARCHAR(14) CONSTRAINT pk_ubicacion PRIMARY KEY,
	nombre VARCHAR(10) NOT NULL
)
/*Commands completed successfully.

Completion time: 2022-11-07T17:23:56.0321397-06:00
*/

CREATE TABLE CATALOGO.Ejemplar
	(codigo_inventario VARCHAR(10) CONSTRAINT pk_ejemplar PRIMARY KEY,
	estado BIT DEFAULT (1)NOT NULL,
	numero_copia int NOT NULL,
	ISBN VARCHAR(14) CONSTRAINT fk_Libro_Ejemplar FOREIGN KEY REFERENCES [CATALOGO].[Libro](ISBN) ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_ubicacion VARCHAR(14) CONSTRAINT fk_Ubicacion_Ejemplar FOREIGN KEY REFERENCES [CATALOGO].[Ubicacion](codigo_ubicacion) ON UPDATE CASCADE ON DELETE CASCADE
)
/*Commands completed successfully.

Completion time: 2022-11-07T17:24:09.3010595-06:00
*/

CREATE TABLE RRHH.Persona
	(id_persona VARCHAR(16) CONSTRAINT pk_persona PRIMARY KEY,
	nombres VARCHAR(50) NOT NULL,
	apellidos VARCHAR(50) NOT NULL,
	telefono VARCHAR(14) NOT NULL
)
/*Commands completed successfully.

Completion time: 2022-11-07T17:24:22.3618786-06:00
*/

CREATE TABLE PRESTAMOS.Prestamo
	(codigo_prestamo varchar(12) CONSTRAINT pk_prestamo PRIMARY KEY,
	f_emision DATETIME NOT NULL,
	f_devolucion DATETIME NOT NULL,
	mora DECIMAL(3,2) DEFAULT(000.00),
	estado BIT DEFAULT (0) NOT NULL,
	id_persona VARCHAR(16) CONSTRAINT fk_Persona_Prestamo FOREIGN KEY REFERENCES [RRHH].[Persona](id_persona) ON UPDATE CASCADE ON DELETE CASCADE
)
/*Commands completed successfully.

Completion time: 2022-11-07T17:24:33.7097827-06:00
*/

CREATE TABLE PRESTAMOS.PrestamoXEjemplar
	(codigo_prestamo varchar(12) CONSTRAINT fk_Prestamo_PrestamoXEjemplar FOREIGN KEY REFERENCES[PRESTAMOS].[Prestamo](codigo_prestamo) ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_inventario VARCHAR(10) CONSTRAINT fk_Ejemplar_PrestamoXEjemplar FOREIGN KEY REFERENCES [CATALOGO].[Ejemplar](codigo_inventario) ON UPDATE CASCADE ON DELETE CASCADE,

)
/*Commands completed successfully.

Completion time: 2022-11-07T17:24:44.1853615-06:00
*/



DROP TABLE [CATALOGO].[AutorXLibro]
DROP TABLE [PRESTAMOS].[PrestamoXEjemplar]
--drop a ambas tablas ya que tuvimos que añadir la llave primaria compuesta de ambos fk

CREATE TABLE CATALOGO.AutorXLibro
	(ISBN VARCHAR(14) CONSTRAINT fk_libro_AutorXLibro FOREIGN KEY REFERENCES [CATALOGO].[Libro](ISBN)ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_autor VARCHAR(10) CONSTRAINT fk_autor_AutorXLibro FOREIGN KEY REFERENCES [CATALOGO].[Autor](codigo_autor)ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_autorxlibro PRIMARY KEY (ISBN,codigo_autor)
)
/*
Commands completed successfully.

Completion time: 2022-11-07T17:33:33.6086285-06:00
*/


CREATE TABLE PRESTAMOS.PrestamoXEjemplar
	(codigo_prestamo varchar(12) CONSTRAINT fk_Prestamo_PrestamoXEjemplar FOREIGN KEY REFERENCES[PRESTAMOS].[Prestamo](codigo_prestamo) ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_inventario VARCHAR(10) CONSTRAINT fk_Ejemplar_PrestamoXEjemplar FOREIGN KEY REFERENCES [CATALOGO].[Ejemplar](codigo_inventario) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_prestamoxejemplar PRIMARY KEY (codigo_prestamo,codigo_inventario)
)

/*Commands completed successfully.

Completion time: 2022-11-07T17:34:40.8501371-06:00*/

CREATE TABLE RRHH.Docente
	(id_docente VARCHAR(14) CONSTRAINT pk_docente PRIMARY KEY,
	id_persona VARCHAR(16) CONSTRAINT fk_persona_docente FOREIGN KEY REFERENCES [RRHH].[Persona](id_persona) ON UPDATE CASCADE ON DELETE CASCADE
)
/*Commands completed successfully.

Completion time: 2022-11-07T18:04:57.2101924-06:00
*/

CREATE TABLE RRHH.PersonalActivo
	(id_personalactivo VARCHAR(14) CONSTRAINT pk_personalactivo PRIMARY KEY,
	id_persona VARCHAR(16) CONSTRAINT fk_persona_personalactivo FOREIGN KEY REFERENCES [RRHH].[Persona](id_persona) ON UPDATE CASCADE ON DELETE CASCADE
)
/*Commands completed successfully.

Completion time: 2022-11-07T18:05:37.3311038-06:00*/

CREATE TABLE RRHH.Estudiante
	(cif VARCHAR(14) CONSTRAINT pk_estudiante PRIMARY KEY,
	id_persona VARCHAR(16) CONSTRAINT fk_persona_estudiante FOREIGN KEY REFERENCES [RRHH].[Persona](id_persona) ON UPDATE CASCADE ON DELETE CASCADE
)

/*Commands completed successfully.

Completion time: 2022-11-07T18:05:48.2425340-06:00*/

CREATE TABLE RRHH.Facultad
	(codigo_facultad VARCHAR(3) CONSTRAINT pk_facultad PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
)
/*Commands completed successfully.

Completion time: 2022-11-07T18:10:59.4507514-06:00
*/

CREATE TABLE RRHH.DocenteXFacultad
	(id_docente VARCHAR(14) CONSTRAINT fk_docente_docentexfacultad FOREIGN KEY REFERENCES [RRHH].[Docente](id_docente) ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_facultad VARCHAR(3) CONSTRAINT fk_facultad_docentexfacultad FOREIGN KEY REFERENCES [RRHH].[Facultad](codigo_facultad) ON UPDATE CASCADE ON DELETE CASCADE
	CONSTRAINT pk_docentexfacultad PRIMARY KEY(id_docente, codigo_facultad)
)
/*Commands completed successfully.

Completion time: 2022-11-07T18:11:11.0384698-06:00
*/
CREATE TABLE RRHH.Cargo
	(codigo_cargo VARCHAR(3) CONSTRAINT pk_cargo PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
)
/*Commands completed successfully.

Completion time: 2022-11-07T21:38:17.2239947-06:00*/

CREATE TABLE RRHH.PersonalActivoXCargo
	(id_personalactivo VARCHAR(14) CONSTRAINT fk_personalactivo_personalactivoxcargo FOREIGN KEY REFERENCES [RRHH].[PersonalActivo](id_personalactivo)ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_cargo VARCHAR(3) CONSTRAINT fk_cargo_personalactivoxcargo FOREIGN KEY REFERENCES [RRHH].[Cargo](codigo_cargo) ON UPDATE CASCADE ON DELETE CASCADE
	CONSTRAINT pk_personalactivoxcargo PRIMARY KEY(id_personalactivo,codigo_cargo)
)
/*Commands completed successfully.

Completion time: 2022-11-07T21:40:40.1303423-06:00*/

CREATE TABLE RRHH.Carrera
	(codigo_carrera VARCHAR(3) CONSTRAINT pk_carrera PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
)
/*Commands completed successfully.

Completion time: 2022-11-07T21:42:00.8444979-06:00
*/

CREATE TABLE RRHH.EstudianteXCarrera
	(cif VARCHAR(14) CONSTRAINT fk_estudiante_estudiantexcarrera FOREIGN KEY REFERENCES [RRHH].[Estudiante](cif) ON UPDATE CASCADE ON DELETE CASCADE,
	codigo_carrera VARCHAR(3) CONSTRAINT fk_carrera_estudiantexcarrera FOREIGN KEY REFERENCES [RRHH].[Carrera](codigo_carrera) ON UPDATE CASCADE ON DELETE CASCADE
	CONSTRAINT pk_estudiantexcarrera PRIMARY KEY (cif,codigo_carrera)
)
/*Commands completed successfully.

Completion time: 2022-11-07T21:47:26.5661837-06:00
*/

ALTER TABLE [PRESTAMOS].[Prestamo]
ADD CONSTRAINT f_emision CHECK (f_emision> SYSDATETIME() );
/*Commands completed successfully.

Completion time: 2022-11-08T18:45:24.8293600-06:00*/

ALTER TABLE [PRESTAMOS].[Prestamo]
ADD CONSTRAINT f_devolucion CHECK (f_devolucion> SYSDATETIME() );

/*Commands completed successfully.

Completion time: 2022-11-08T18:45:41.5000871-06:00
*/

ALTER TABLE [CATALOGO].[Libro]
ADD CONSTRAINT MFN UNIQUE (MFN)
/*Commands completed successfully.

Completion time: 2022-11-08T18:48:34.8950230-06:00*/