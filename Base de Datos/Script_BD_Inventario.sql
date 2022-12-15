-- Nombre de Base de Datos: Inventario

-- Usuario administrador BD (root): root
-- password: albarregas

-- Usuario: adminInventario
-- password: albarregas

-- drop database bdinventariolindin;
-- SELECT User, Host FROM mysql.user;
-- drop user 'lindin'@'localhost';

-- Para hacer una copia de seguridad de una o más bases de datos completas:
-- mysqldump -u adminInventario -p -B -c Inventario > Backup_BD_Inventario.sql

-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE if EXISTS Equipos, Impresoras, Ubicacion, Usuarios, Dispositivos;
-- SET FOREIGN_KEY_CHECKS = 1;

 CREATE DATABASE IF NOT EXISTS Inventario DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
 
 CREATE USER IF NOT EXISTS 'adminInventario'@'localhost' IDENTIFIED BY 'albarregas';
 GRANT ALL PRIVILEGES ON Inventario.* TO 'adminInventario'@'localhost';
 FLUSH PRIVILEGES;

 USE Inventario;

   
-- Tabla Ubicacion
CREATE TABLE if not exists Ubicacion(
	idUbicacion smallInt (6) not null auto_increment PRIMARY KEY,
	departamento varchar (50) COLLATE utf8_spanish_ci not null,
	aula varchar (10) COLLATE utf8_spanish_ci not null
	);	
    
CREATE TABLE if not exists MotivosBaja(
	idMotivo smallInt (4) not null auto_increment PRIMARY KEY,
	codigoBaja varchar(4) collate utf8_spanish_ci not null,
	descripcionBaja varchar(50) collate utf8_spanish_ci not null
);
-- Tabla Equipos.
CREATE TABLE if not exists Equipos(
	idEquipo smallInt (6) not null auto_increment  PRIMARY KEY,
	numinventario varchar(8) collate utf8_spanish_ci not null,
	tipoEquipo varchar (10) COLLATE utf8_spanish_ci not null,
	marca varchar (20) COLLATE utf8_spanish_ci not null,
	modelo varchar (30) COLLATE utf8_spanish_ci not null,
	numSerie varchar (20) COLLATE utf8_spanish_ci not null,
	procesador varchar (20) COLLATE utf8_spanish_ci not null,
	memoriaRam char (3) COLLATE utf8_spanish_ci not null,
	almacenamiento char (4) not null,
	sistemaOperativo varchar (50) COLLATE utf8_spanish_ci not null,
	maquinaVirtual varchar (50) COLLATE utf8_spanish_ci null,
	componenteExtra varchar (50) COLLATE utf8_spanish_ci null,
	fechaAlta date COLLATE utf8_spanish_ci not null,
	fechaBaja date COLLATE utf8_spanish_ci not null,
	idUbicacion smallInt (6) not null,
	idMotivo smallInt (6) not null,	
	CONSTRAINT `ubicacion_equipos` FOREIGN KEY (`idUbicacion`) REFERENCES `Ubicacion` (`idUbicacion`),
	CONSTRAINT `motivoBaja_equipo` FOREIGN KEY (`idMotivo`) REFERENCES `MotivosBaja` (`idMotivo`)
	);

-- Tabla Impresoras --

CREATE TABLE if not exists Impresoras(
	idImpresora smallInt (6) not null auto_increment PRIMARY KEY,
	numInventario VARCHAR(8) COLLATE utf8_spanish_ci not null,
	marca varchar (20) COLLATE utf8_spanish_ci not null,
	modelo varchar (30) COLLATE utf8_spanish_ci not null,
	numSerie varchar (20) COLLATE utf8_spanish_ci not null,
	tipoImpresora varchar (10) COLLATE utf8_spanish_ci not null,
	enRed char(1) COLLATE utf8_spanish_ci not null,
	fechaAlta date COLLATE utf8_spanish_ci not null,
	fechaBaja date COLLATE utf8_spanish_ci not null,
	idUbicacion smallInt (6) not null,
	idMotivo smallInt (6) not null,
	CONSTRAINT `ubicacion_impresoras` FOREIGN KEY (`idUbicacion`) REFERENCES `Ubicacion` (`idUbicacion`),
	CONSTRAINT `motivoBaja_impresora` FOREIGN KEY (`idMotivo`) REFERENCES `MotivosBaja` (`idMotivo`)
	);

-- Tabla dispositivos
CREATE TABLE if not exists Dispositivos(
	idDispositivo smallInt (6) not null auto_increment PRIMARY KEY,
	numInventario VARCHAR(8) COLLATE utf8_spanish_ci not null,
	marca varchar (20) COLLATE utf8_spanish_ci not null,
	modelo varchar (30) COLLATE utf8_spanish_ci not null,
	numSerie varchar (20)COLLATE utf8_spanish_ci not null,
	fechaAlta date COLLATE utf8_spanish_ci not null,
	fechaBaja date COLLATE utf8_spanish_ci not null,
	idUbicacion smallInt (6) not null,
	idEquipo smallInt (6) null,
	idMotivo smallInt (6) not null,
	CONSTRAINT `ubicacion_dispositivo` FOREIGN KEY (`idUbicacion`) REFERENCES `Ubicacion` (`idUbicacion`),
	CONSTRAINT `equipo_dispositivo` FOREIGN KEY (`idEquipo`) REFERENCES `Equipos` (`idEquipo`),
	CONSTRAINT `motivoBaja_dispositivo` FOREIGN KEY (`idMotivo`) REFERENCES `MotivosBaja` (`idMotivo`)
	);
	
-- Eliminar maquinaVirtual de la tabla equipos:
	ALTER TABLE equipos DROP COLUMN maquinaVirtual;

-- Añadir columna imagenEquipo en tabla equipos(tamaño de la imagen máximo: 16 Mb):
	ALTER TABLE equipos ADD imagenEquipo MEDIUMBLOB not null AFTER sistemaOperativo;
	
-- Eliminar columna imagenEquipo y crear nueva columna imagen
	ALTER TABLE equipos DROP COLUMN imagenEquipo;
	
	ALTER TABLE equipos ADD imagen VARCHAR(20) null DEFAULT 'default.png' AFTER componenteExtra;
	
-- Cambiar valores columnas fechaBaja, idDispositivo, idMotivo, idUbicacion en tablas equipos, impresoras y dispositivos.
	ALTER TABLE dispositivos MODIFY fechaBaja DATE NULL;

	ALTER TABLE equipos MODIFY fechaBaja DATE NULL;

	ALTER TABLE impresoras MODIFY fechaBaja DATE NULL;

	ALTER TABLE equipos MODIFY idUbicacion smallInt (6) NULL;
	ALTER TABLE equipos MODIFY idMotivo smallInt (6) NULL;
	ALTER TABLE dispositivos MODIFY idEquipo smallInt (6) NULL;
	ALTER TABLE dispositivos MODIFY idMotivo smallInt (6) NULL;
	ALTER TABLE dispositivos MODIFY idUbicacion smallInt (6) NULL;
	ALTER TABLE impresoras MODIFY idUbicacion smallInt (6) NULL;
	ALTER TABLE impresoras MODIFY idMotivo smallInt (6) NULL;
	
-- ERROR 1364 (HY000): Field 'idUbicacion' doesn't have a default value --> solucionado

insert into ubicacion (departamento,aula) values ('Informatica', '1 ESO');
insert into motivosBaja (codigoBaja,descripcionBaja) values ('00000', 'Averiado');

-- Cambiar valores tabla ubicacion. Se añade columna cursosCiclos.
-- Modificar nombres de las columnas aula por aulas y departamento por departamentos.
	ALTER TABLE ubicacion CHANGE departamento departamentos VARCHAR(50) NOT NULL;
	ALTER TABLE ubicacion CHANGE aula aulas VARCHAR(50) NOT NULL;
	ALTER TABLE ubicacion ADD cursosCiclos VARCHAR(10) NOT NULL;
	
	
	Microsoft Windows [Versión 10.0.22000.1281]
(c) Microsoft Corporation. Todos los derechos reservados.

C:\Users\Francisco_Antonio>mysql -u adminInventario -p
Enter password: **********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.7.32-log MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use inventario
Database changed
mysql> show tables;
+----------------------+
| Tables_in_inventario |
+----------------------+
| dispositivos         |
| equipos              |
| impresoras           |
| motivosbaja          |
| ubicacion            |
+----------------------+
5 rows in set (0.02 sec)

mysql> desc dispositivos;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idDispositivo | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numInventario | varchar(8)  | NO   |     | NULL    |                |
| marca         | varchar(20) | NO   |     | NULL    |                |
| modelo        | varchar(30) | NO   |     | NULL    |                |
| numSerie      | varchar(20) | NO   |     | NULL    |                |
| fechaAlta     | date        | NO   |     | NULL    |                |
| fechaBaja     | date        | YES  |     | NULL    |                |
| idUbicacion   | smallint(6) | YES  | MUL | NULL    |                |
| idEquipo      | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo      | smallint(6) | YES  | MUL | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
10 rows in set (0.05 sec)

mysql> desc equipos;
+------------------+-------------+------+-----+-------------+----------------+
| Field            | Type        | Null | Key | Default     | Extra          |
+------------------+-------------+------+-----+-------------+----------------+
| idEquipo         | smallint(6) | NO   | PRI | NULL        | auto_increment |
| numinventario    | varchar(8)  | NO   |     | NULL        |                |
| tipoEquipo       | varchar(10) | NO   |     | NULL        |                |
| marca            | varchar(20) | NO   |     | NULL        |                |
| modelo           | varchar(30) | NO   |     | NULL        |                |
| numSerie         | varchar(20) | NO   |     | NULL        |                |
| procesador       | varchar(20) | NO   |     | NULL        |                |
| memoriaRam       | char(3)     | NO   |     | NULL        |                |
| almacenamiento   | char(4)     | NO   |     | NULL        |                |
| sistemaOperativo | varchar(50) | NO   |     | NULL        |                |
| componenteExtra  | varchar(50) | YES  |     | NULL        |                |
| imagen           | varchar(20) | YES  |     | default.png |                |
| fechaAlta        | date        | NO   |     | NULL        |                |
| fechaBaja        | date        | YES  |     | NULL        |                |
| idUbicacion      | smallint(6) | YES  | MUL | NULL        |                |
| idMotivo         | smallint(6) | YES  | MUL | NULL        |                |
+------------------+-------------+------+-----+-------------+----------------+
16 rows in set (0.00 sec)

mysql> desc impresoras;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idImpresora   | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numInventario | varchar(8)  | NO   |     | NULL    |                |
| marca         | varchar(20) | NO   |     | NULL    |                |
| modelo        | varchar(30) | NO   |     | NULL    |                |
| numSerie      | varchar(20) | NO   |     | NULL    |                |
| tipoImpresora | varchar(10) | NO   |     | NULL    |                |
| enRed         | char(1)     | NO   |     | NULL    |                |
| fechaAlta     | date        | NO   |     | NULL    |                |
| fechaBaja     | date        | YES  |     | NULL    |                |
| idUbicacion   | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo      | smallint(6) | YES  | MUL | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
11 rows in set (0.02 sec)

mysql> desc ubicacion;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idUbicacion   | smallint(6) | NO   | PRI | NULL    | auto_increment |
| departamentos | varchar(50) | NO   |     | NULL    |                |
| aulas         | varchar(50) | NO   |     | NULL    |                |
| cursosCiclos  | varchar(10) | NO   |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> desc motivosBaja;
+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| idMotivo        | smallint(6) | NO   | PRI | NULL    | auto_increment |
| codigoBaja      | varchar(6)  | NO   |     | NULL    |                |
| descripcionBaja | varchar(50) | NO   |     | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+
3 rows in set (0.01 sec)

mysql>

-- Cambiar nombre y valores columna imagen por observaciones:
ALTER TABLE equipos CHANGE fechaBaja observaciones VARCHAR(50) NULL;
ALTER TABLE impresoras CHANGE fechaBaja observaciones VARCHAR(50) NULL;
ALTER TABLE dispositivos CHANGE fechaBaja observaciones VARCHAR(50) NULL;

-- Eliminar columna imagen de la tabla equipos:
ALTER TABLE equipos DROP COLUMN imagen;


mysql> ALTER TABLE equipos DROP COLUMN imagen;
Query OK, 0 rows affected (0.13 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE equipos CHANGE fechaBaja observaciones VARCHAR(50) NULL;
Query OK, 2 rows affected (0.08 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE impresoras CHANGE fechaBaja observaciones VARCHAR(50) NULL;
Query OK, 2 rows affected (0.08 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE dispositivos CHANGE fechaBaja observaciones VARCHAR(50) NULL;
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc motivosBaja;
+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| idMotivo        | smallint(6) | NO   | PRI | NULL    | auto_increment |
| codigoBaja      | varchar(6)  | NO   |     | NULL    |                |
| descripcionBaja | varchar(50) | NO   |     | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

mysql> desc ubicacion;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idUbicacion   | smallint(6) | NO   | PRI | NULL    | auto_increment |
| departamentos | varchar(50) | NO   |     | NULL    |                |
| aulas         | varchar(50) | NO   |     | NULL    |                |
| cursosCiclos  | varchar(10) | NO   |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> desc impresoras;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idImpresora   | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numInventario | varchar(8)  | NO   |     | NULL    |                |
| marca         | varchar(20) | NO   |     | NULL    |                |
| modelo        | varchar(30) | NO   |     | NULL    |                |
| numSerie      | varchar(20) | NO   |     | NULL    |                |
| tipoImpresora | varchar(10) | NO   |     | NULL    |                |
| enRed         | char(1)     | NO   |     | NULL    |                |
| fechaAlta     | date        | NO   |     | NULL    |                |
| observaciones | varchar(50) | YES  |     | NULL    |                |
| idUbicacion   | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo      | smallint(6) | YES  | MUL | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
11 rows in set (0.00 sec)

mysql> desc equipos;
+------------------+-------------+------+-----+---------+----------------+
| Field            | Type        | Null | Key | Default | Extra          |
+------------------+-------------+------+-----+---------+----------------+
| idEquipo         | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numinventario    | varchar(8)  | NO   |     | NULL    |                |
| tipoEquipo       | varchar(10) | NO   |     | NULL    |                |
| marca            | varchar(20) | NO   |     | NULL    |                |
| modelo           | varchar(30) | NO   |     | NULL    |                |
| numSerie         | varchar(20) | NO   |     | NULL    |                |
| procesador       | varchar(20) | NO   |     | NULL    |                |
| memoriaRam       | char(3)     | NO   |     | NULL    |                |
| almacenamiento   | char(4)     | NO   |     | NULL    |                |
| sistemaOperativo | varchar(50) | NO   |     | NULL    |                |
| componenteExtra  | varchar(50) | YES  |     | NULL    |                |
| fechaAlta        | date        | NO   |     | NULL    |                |
| observaciones    | varchar(50) | YES  |     | NULL    |                |
| idUbicacion      | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo         | smallint(6) | YES  | MUL | NULL    |                |
+------------------+-------------+------+-----+---------+----------------+
15 rows in set (0.00 sec)

mysql> desc dispositivos;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idDispositivo | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numInventario | varchar(8)  | NO   |     | NULL    |                |
| marca         | varchar(20) | NO   |     | NULL    |                |
| modelo        | varchar(30) | NO   |     | NULL    |                |
| numSerie      | varchar(20) | NO   |     | NULL    |                |
| fechaAlta     | date        | NO   |     | NULL    |                |
| observaciones | varchar(50) | YES  |     | NULL    |                |
| idUbicacion   | smallint(6) | YES  | MUL | NULL    |                |
| idEquipo      | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo      | smallint(6) | YES  | MUL | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
10 rows in set (0.00 sec)

mysql>
-- Se eliminan datos tablas y rectificacion de la tabla motivosBaja que se crea de nuevo.

-- SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE equipos;
TRUNCATE TABLE impresoras;
TRUNCATE TABLE dispositivos;
TRUNCATE TABLE ubicacion;
TRUNCATE TABLE motivosBaja;
-- SET FOREIGN_KEY_CHECKS = 1;

-- Se elimina tabla motivosBaja.
DROP TABLE if EXISTS motivosBaja;

-- Se crea de nuevo la tabla motivosBaja.
CREATE TABLE if not exists MotivosBaja(
	idMotivo smallInt (4) not null auto_increment PRIMARY KEY,
	codigoBaja varchar(4) collate utf8_spanish_ci not null,
	descripcionBaja varchar(50) collate utf8_spanish_ci not null
);

-- Insercción de datos en las tablas motivosBaja, equipos, impresoras, dispositivos y ubicacion:
INSERT INTO motivosBaja (codigoBaja, descripcionBaja) VALUES ('OBS','Equipo Obsoleto'),
															 ('AVR','Averiado'),
															 ('ACC','Accidente');
															 
INSERT INTO ubicacion (departamentos, aulas, cursosCiclos) VALUES ('Comercio','Aula Informatica','1 BACH_A'),
																  ('Administracion y Gestion','Aula Desdoble 1','1 BACH_B'),
																  ('Biologia y Geologia','Aula Desdoble 2','1 BACH_C'),
																  ('Ciencias Sociales','Aula Desdoble 3','1 BACH_D'),
																  ('Clasicas','Aula Desdoble 4','1 BACH_E'),
																  ('Comercio y Marketing','Aula Desdoble 5','1 DIV'),
																  ('Filosofia','Aula Cisco','1 ESO_A'),
																  ('Fisica y Quimica','Aula desdoble bilingüe','1 ESO_B'),
																  ('Frances, Lengua','Aula apoyo PT','1 ESO_C'),
																  ('Matematicas','Aula PT','1 ESO_D'),
																  ('Plastica','Sala usos multiples','1 ESO_E'),
																  ('Tecnologia','Aula Abanico','2 BACH_A'),
																  ('Administracion - Direccion','Aula Abierta','2 BACH_B'),
																  ('Jefatura de Estudios','Laboratorio Fisica y Quimica','2 BACH_C'),
																  ('Secretaria','Laboratorio','2 BACH_D'),
																  ('Conserjeria','Biologia y Geologia','2 ESO_A'),
																  ('Biblioteca','Sala Comunicaciones','2 ESO_B'),
																  ('Orientacion y Educadora Social','Sala de Guardias','2 ESO_C'),
																  ('Informatica','Sala de Profesores','2 ESO_D');
																  
INSERT INTO ubicacion (aulas, cursosCiclos) VALUES 	('Cafeteria','2 ESO_E'),
													('Aula Apoyo','2 ESO_F'),
													('Aula Plastica','3 ESO_A'),
													('Aula Desdoble','3 ESO_B'),
													('Aula Ateca','3 ESO_C'),
													('Aula de Musica','3 ESO_D'),
													('Aula 2.0','3 ESO_E');

													
INSERT INTO ubicacion (cursosCiclos) VALUES ('3 ESO_F'),
											('4 ESO_A'),
											('4 ESO_B'),
											('4 ESO_C'),
											('4 ESO_D'),
											('4 ESO_E'),
											('ACOM 1'),
											('ACOM 2'),
											('ADI 1'),
											('ADI 2'),
											('AFI 1'),
											('AFI 2'),
											('ASIR 1'),
											('ASIR 2'),
											('COI 1'),
											('COI 2'),
											('DAM 1'),
											('DAM 2'),
											('DAW 1'),
											('DAW 2'),
											('FPB 1'),
											('FPB 2'),
											('GAD 1'),
											('GAD 2'),
											('PMAR_1');
											
INSERT INTO equipos (numInventario, tipoEquipo, marca, modelo, numSerie, procesador, memoriaRam, Almacenamiento, sistemaOperativo, componenteExtra, fechaAlta) VALUES ('ALBAINF1','portatil','Lenovo','D310','jld12345','Intel i7 3500', 16,2000,'Ubuntu','No','2022/11/15');
INSERT INTO impresoras (numInventario, marca, modelo, numSerie,tipoImpresora,enRed,fechaAlta) VALUES ('ALBAINF4','Hewlett Packard','ENVY6000','ipl12345','All In One', 'Si','2022/11/15');
INSERT INTO dispositivos (numInventario, marca, modelo, numSerie,fechaAlta,observaciones) VALUES ('ALBASEC','Genius','GM-080025','X4F67711109714','2022/12/10', 'Raton');

-- modificacioón de valores  NOT NULL a NULL, para que puedan tener campos nulos:
	ALTER TABLE ubicacion MODIFY departamentos VARCHAR(50) NULL;
	ALTER TABLE ubicacion MODIFY aulas VARCHAR(50) NULL;
	ALTER TABLE ubicacion MODIFY cursosCiclos VARCHAR(10) NULL;

-- Eliminar columnas observaciones de las tablas dispositivos, equipos e impresoras:
	ALTER TABLE equipos DROP COLUMN observaciones;
	ALTER TABLE dispositivos DROP COLUMN observaciones;
	ALTER TABLE impresoras DROP COLUMN observaciones;
	
-- Eliminar valores tabla impresoras y modificar los valores de la columna enRed:
	delete from impresoras;
	ALTER TABLE impresoras MODIFY enRed CHAR(2) NOT NULL;	

-- Así quedan las tablas a día 13 de diciembre de 2022:

mysql> desc impresoras;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idImpresora   | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numInventario | varchar(8)  | NO   |     | NULL    |                |
| marca         | varchar(20) | NO   |     | NULL    |                |
| modelo        | varchar(30) | NO   |     | NULL    |                |
| numSerie      | varchar(20) | NO   |     | NULL    |                |
| tipoImpresora | varchar(10) | NO   |     | NULL    |                |
| enRed         | char(2)     | NO   |     | NULL    |                |
| fechaAlta     | date        | NO   |     | NULL    |                |
| idUbicacion   | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo      | smallint(6) | YES  | MUL | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
10 rows in set (0.02 sec)

mysql> desc equipos;
+------------------+-------------+------+-----+---------+----------------+
| Field            | Type        | Null | Key | Default | Extra          |
+------------------+-------------+------+-----+---------+----------------+
| idEquipo         | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numinventario    | varchar(8)  | NO   |     | NULL    |                |
| tipoEquipo       | varchar(10) | NO   |     | NULL    |                |
| marca            | varchar(20) | NO   |     | NULL    |                |
| modelo           | varchar(30) | NO   |     | NULL    |                |
| numSerie         | varchar(20) | NO   |     | NULL    |                |
| procesador       | varchar(20) | NO   |     | NULL    |                |
| memoriaRam       | char(3)     | NO   |     | NULL    |                |
| almacenamiento   | char(4)     | NO   |     | NULL    |                |
| sistemaOperativo | varchar(50) | NO   |     | NULL    |                |
| componenteExtra  | varchar(50) | YES  |     | NULL    |                |
| fechaAlta        | date        | NO   |     | NULL    |                |
| idUbicacion      | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo         | smallint(6) | YES  | MUL | NULL    |                |
+------------------+-------------+------+-----+---------+----------------+
14 rows in set (0.00 sec)

mysql> desc dispositivos;
+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| idDispositivo   | smallint(6) | NO   | PRI | NULL    | auto_increment |
| numInventario   | varchar(8)  | NO   |     | NULL    |                |
| tipoDispositivo | varchar(20) | NO   |     | NULL    |                |
| marca           | varchar(20) | NO   |     | NULL    |                |
| modelo          | varchar(30) | NO   |     | NULL    |                |
| numSerie        | varchar(20) | NO   |     | NULL    |                |
| fechaAlta       | date        | NO   |     | NULL    |                |
| idUbicacion     | smallint(6) | YES  | MUL | NULL    |                |
| idEquipo        | smallint(6) | YES  | MUL | NULL    |                |
| idMotivo        | smallint(6) | YES  | MUL | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+
10 rows in set (0.00 sec)

mysql> desc ubicacion;
+---------------+-------------+------+-----+---------+----------------+
| Field         | Type        | Null | Key | Default | Extra          |
+---------------+-------------+------+-----+---------+----------------+
| idUbicacion   | smallint(6) | NO   | PRI | NULL    | auto_increment |
| departamentos | varchar(50) | YES  |     | NULL    |                |
| aulas         | varchar(50) | YES  |     | NULL    |                |
| cursosCiclos  | varchar(10) | YES  |     | NULL    |                |
+---------------+-------------+------+-----+---------+----------------+
4 rows in set (0.01 sec)

mysql> desc motivosBaja;
+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| idMotivo        | smallint(4) | NO   | PRI | NULL    | auto_increment |
| codigoBaja      | varchar(4)  | NO   |     | NULL    |                |
| descripcionBaja | varchar(50) | NO   |     | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

mysql>