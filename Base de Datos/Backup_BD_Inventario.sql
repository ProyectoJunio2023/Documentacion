-- MySQL dump 10.13  Distrib 5.7.32, for Win64 (x86_64)
--
-- Host: localhost    Database: Inventario
-- ------------------------------------------------------
-- Server version	5.7.32-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `Inventario`
--

 CREATE DATABASE IF NOT EXISTS Inventario DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
 
 CREATE USER IF NOT EXISTS 'adminInventario'@'localhost' IDENTIFIED BY 'albarregas';
 GRANT ALL PRIVILEGES ON Inventario.* TO 'adminInventario'@'localhost';
 FLUSH PRIVILEGES;

 USE Inventario;

--
-- Table structure for table `centros`
--

DROP TABLE IF EXISTS `centros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centros` (
  `idCentro` smallint(6) NOT NULL AUTO_INCREMENT,
  `centro` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `poblacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `provicia` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `codigoPostal` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `idUsuario` smallint(6) DEFAULT NULL,
  `idIncidencia` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idCentro`),
  KEY `centro_usuario` (`idUsuario`),
  KEY `centro_incidencia` (`idIncidencia`),
  CONSTRAINT `centro_incidencia` FOREIGN KEY (`idIncidencia`) REFERENCES `incidencias` (`idIncidencia`),
  CONSTRAINT `centro_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centros`
--

LOCK TABLES `centros` WRITE;
/*!40000 ALTER TABLE `centros` DISABLE KEYS */;
/*!40000 ALTER TABLE `centros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispositivos`
--

DROP TABLE IF EXISTS `dispositivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispositivos` (
  `idDispositivo` smallint(6) NOT NULL AUTO_INCREMENT,
  `numInventario` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `tipoDispositivo` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `marca` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `modelo` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `numSerie` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `fechaAlta` date NOT NULL,
  `fechaBaja` date DEFAULT NULL,
  `motivoBaja` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idUbicacion` smallint(6) DEFAULT NULL,
  `idEquipo` smallint(6) DEFAULT NULL,
  `idMotivo` smallint(6) DEFAULT NULL,
  `idIncidencia` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idDispositivo`),
  KEY `ubicacion_dispositivo` (`idUbicacion`),
  KEY `dispositivo_equipo` (`idEquipo`),
  KEY `motivoBaja_dispositivo` (`idMotivo`),
  KEY `dispositivo_incidencia` (`idIncidencia`),
  CONSTRAINT `dispositivo_equipo` FOREIGN KEY (`idEquipo`) REFERENCES `equipos` (`idEquipo`),
  CONSTRAINT `dispositivo_incidencia` FOREIGN KEY (`idIncidencia`) REFERENCES `incidencias` (`idIncidencia`),
  CONSTRAINT `motivoBaja_dispositivo` FOREIGN KEY (`idMotivo`) REFERENCES `motivosbaja` (`idMotivo`),
  CONSTRAINT `ubicacion_dispositivo` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicaciones` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispositivos`
--

LOCK TABLES `dispositivos` WRITE;
/*!40000 ALTER TABLE `dispositivos` DISABLE KEYS */;
INSERT INTO `dispositivos` (`idDispositivo`, `numInventario`, `tipoDispositivo`, `marca`, `modelo`, `numSerie`, `fechaAlta`, `fechaBaja`, `motivoBaja`, `idUbicacion`, `idEquipo`, `idMotivo`, `idIncidencia`) VALUES (1,'ALBASEC','Ratón','Genius','GM-080025','X4F67711109714','2022-12-10',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `dispositivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos` (
  `idEquipo` smallint(6) NOT NULL AUTO_INCREMENT,
  `numinventario` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `tipoEquipo` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `marca` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `modelo` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `numSerie` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `procesador` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `memoriaRam` char(6) COLLATE utf8_spanish_ci NOT NULL,
  `almacenamiento` char(8) COLLATE utf8_spanish_ci NOT NULL,
  `sistemaOperativo` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `componenteExtra` varchar(80) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fechaAlta` date DEFAULT NULL,
  `fechaBaja` date DEFAULT NULL,
  `motivoBaja` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idUbicacion` smallint(6) DEFAULT NULL,
  `idMotivo` smallint(6) DEFAULT NULL,
  `idDispositivo` smallint(6) DEFAULT NULL,
  `idImpresora` smallint(6) DEFAULT NULL,
  `idIncidencia` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idEquipo`),
  KEY `ubicaciones_equipos` (`idUbicacion`),
  KEY `motivoBaja_equipo` (`idMotivo`),
  KEY `equipo_incidencia` (`idIncidencia`),
  KEY `equipos_dispositivo` (`idDispositivo`),
  KEY `equipo_impresora` (`idImpresora`),
  CONSTRAINT `equipo_impresora` FOREIGN KEY (`idImpresora`) REFERENCES `impresoras` (`idImpresora`),
  CONSTRAINT `equipo_incidencia` FOREIGN KEY (`idIncidencia`) REFERENCES `incidencias` (`idIncidencia`),
  CONSTRAINT `equipos_dispositivo` FOREIGN KEY (`idDispositivo`) REFERENCES `dispositivos` (`idDispositivo`),
  CONSTRAINT `motivoBaja_equipo` FOREIGN KEY (`idMotivo`) REFERENCES `motivosbaja` (`idMotivo`),
  CONSTRAINT `ubicaciones_equipos` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicaciones` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` (`idEquipo`, `numinventario`, `tipoEquipo`, `marca`, `modelo`, `numSerie`, `procesador`, `memoriaRam`, `almacenamiento`, `sistemaOperativo`, `componenteExtra`, `fechaAlta`, `fechaBaja`, `motivoBaja`, `idUbicacion`, `idMotivo`, `idDispositivo`, `idImpresora`, `idIncidencia`) VALUES (1,'ALBAINF1','Portatil','Lenovo','D310','jld12345','Intel i7 3500','16','2000','Ubuntu','','2022-11-15',NULL,NULL,NULL,NULL,NULL,0,NULL),(2,'AU03001','Sobremesa','Genius','gladiator','JKL12345','AMD K6','4','500','WINDOWS 11','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'AU03001','Sobremesa','Asus','Inspiron','jgskj-432','Intel i7 3500Mhz','4','500','WINDOWS 11','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'AU03001','Sobremesa','Asus','Inspiron','jgskj-432','Intel i7 3500Mhz','4','500','WINDOWS 11','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'AU03001','Sobremesa','Asus','Inspiron','jgskj-432','Intel i7 3500Mhz','4','500','WINDOWS 11','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'DAW1001','Sobremesa','MSI','AK500','asde87498d','Intel I3 13th','8','500','Windows 11 Home','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'DAW2001','Portatil','Lenovo','D340','qwer9876x','Intel I3 3500Mhz','4','1000','Windows 11 Pro','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'DAW2002','Sobremesa','MSI','gladiator','JKL12345','Intel i7 3500Mhz','16','2000','WINDOWS 11 Pro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'DAW2002','Sobremesa','MSI','gladiator','jgskj-432','Intel i7 3500Mhz','16','2000','WINDOWS 11 Pro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'DAW2002','Sobremesa','MSI','gladiator','jgskj-432','Intel i7 3500Mhz','16','2000','WINDOWS 11 Pro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'DAW2003','Portatil','LENOVO','D310','JKL12345','Intel i3 3500Mhz','8','500','Ubuntu 2022',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'ASIR1001','Sobremesa','MSI','gladiator','JKL12345','Intel i3 3500Mhz','8','500','WINDOWS 11 Pro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impresoras`
--

DROP TABLE IF EXISTS `impresoras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impresoras` (
  `idImpresora` smallint(6) NOT NULL AUTO_INCREMENT,
  `numInventario` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `tipoImpresora` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `marca` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `modelo` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `numSerie` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `enRed` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
  `fechaAlta` date NOT NULL,
  `fechaBaja` date DEFAULT NULL,
  `motivoBaja` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idUbicacion` smallint(6) DEFAULT NULL,
  `idMotivo` smallint(6) DEFAULT NULL,
  `idIncidencia` smallint(6) DEFAULT NULL,
  `idEquipo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idImpresora`),
  KEY `ubicacion_impresoras` (`idUbicacion`),
  KEY `motivoBaja_impresora` (`idMotivo`),
  KEY `impresora_incidencia` (`idIncidencia`),
  KEY `impresora_impresora` (`idEquipo`),
  CONSTRAINT `impresora_impresora` FOREIGN KEY (`idEquipo`) REFERENCES `equipos` (`idEquipo`),
  CONSTRAINT `impresora_incidencia` FOREIGN KEY (`idIncidencia`) REFERENCES `incidencias` (`idIncidencia`),
  CONSTRAINT `motivoBaja_impresora` FOREIGN KEY (`idMotivo`) REFERENCES `motivosbaja` (`idMotivo`),
  CONSTRAINT `ubicacion_impresoras` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicaciones` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impresoras`
--

LOCK TABLES `impresoras` WRITE;
/*!40000 ALTER TABLE `impresoras` DISABLE KEYS */;
INSERT INTO `impresoras` (`idImpresora`, `numInventario`, `tipoImpresora`, `marca`, `modelo`, `numSerie`, `enRed`, `fechaAlta`, `fechaBaja`, `motivoBaja`, `idUbicacion`, `idMotivo`, `idIncidencia`, `idEquipo`) VALUES (1,'ALBAINF4','AllInOne','Hewlett Packard','ENVY6000','ipl12345','Sí','2022-11-15',NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `impresoras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencias`
--

DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidencias` (
  `idIncidencia` smallint(6) NOT NULL AUTO_INCREMENT,
  `tipoIncidencia` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `resolucion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `idUsuario` smallint(6) DEFAULT NULL,
  `idEquipo` smallint(6) DEFAULT NULL,
  `idImpresora` smallint(6) DEFAULT NULL,
  `idDispositivo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idIncidencia`),
  KEY `incidencia_equipo` (`idEquipo`),
  KEY `incidencia_impresora` (`idImpresora`),
  KEY `incidencia_dispositivo` (`idDispositivo`),
  KEY `incidencia_usuario` (`idUsuario`),
  CONSTRAINT `incidencia_dispositivo` FOREIGN KEY (`idDispositivo`) REFERENCES `dispositivos` (`idDispositivo`),
  CONSTRAINT `incidencia_equipo` FOREIGN KEY (`idEquipo`) REFERENCES `equipos` (`idEquipo`),
  CONSTRAINT `incidencia_impresora` FOREIGN KEY (`idImpresora`) REFERENCES `impresoras` (`idImpresora`),
  CONSTRAINT `incidencia_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencias`
--

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motivosbaja`
--

DROP TABLE IF EXISTS `motivosbaja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motivosbaja` (
  `idMotivo` smallint(4) NOT NULL AUTO_INCREMENT,
  `codigoBaja` varchar(4) COLLATE utf8_spanish_ci NOT NULL,
  `descripcionBaja` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idMotivo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motivosbaja`
--

LOCK TABLES `motivosbaja` WRITE;
/*!40000 ALTER TABLE `motivosbaja` DISABLE KEYS */;
INSERT INTO `motivosbaja` (`idMotivo`, `codigoBaja`, `descripcionBaja`) VALUES (1,'OBS','Obsoleto'),(2,'AVR','Averiado'),(3,'ACC','Accidente');
/*!40000 ALTER TABLE `motivosbaja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedores` (
  `idProveedor` smallint(6) NOT NULL AUTO_INCREMENT,
  `cif` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `poblacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `provicia` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `codigoPostal` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software`
--

DROP TABLE IF EXISTS `software`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software` (
  `idSoftware` smallint(6) NOT NULL AUTO_INCREMENT,
  `tipoSoftware` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `denominacionSoft` varchar(80) COLLATE utf8_spanish_ci NOT NULL,
  `tipoLicencia` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `numLicencia` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `idEquipo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idSoftware`),
  KEY `software_equipo` (`idEquipo`),
  CONSTRAINT `software_equipo` FOREIGN KEY (`idEquipo`) REFERENCES `equipos` (`idEquipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software`
--

LOCK TABLES `software` WRITE;
/*!40000 ALTER TABLE `software` DISABLE KEYS */;
/*!40000 ALTER TABLE `software` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicaciones`
--

DROP TABLE IF EXISTS `ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicaciones` (
  `idUbicacion` smallint(6) NOT NULL AUTO_INCREMENT,
  `departamentos` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aulas` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cursos` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ciclos` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idEquipo` smallint(6) DEFAULT NULL,
  `idDispositivo` smallint(6) DEFAULT NULL,
  `idImpresora` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idUbicacion`),
  KEY `ubicaciones_dispositivo` (`idDispositivo`),
  KEY `ubicaciones_impresoras` (`idImpresora`),
  KEY `ubicaciones_equipo` (`idEquipo`),
  CONSTRAINT `ubicacion_equipo` FOREIGN KEY (`idEquipo`) REFERENCES `equipos` (`idEquipo`),
  CONSTRAINT `ubicaciones_dispositivo` FOREIGN KEY (`idDispositivo`) REFERENCES `dispositivos` (`idDispositivo`),
  CONSTRAINT `ubicaciones_equipo` FOREIGN KEY (`idEquipo`) REFERENCES `equipos` (`idEquipo`),
  CONSTRAINT `ubicaciones_impresoras` FOREIGN KEY (`idImpresora`) REFERENCES `impresoras` (`idImpresora`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicaciones`
--

LOCK TABLES `ubicaciones` WRITE;
/*!40000 ALTER TABLE `ubicaciones` DISABLE KEYS */;
INSERT INTO `ubicaciones` (`idUbicacion`, `departamentos`, `aulas`, `cursos`, `ciclos`, `idEquipo`, `idDispositivo`, `idImpresora`) VALUES (1,'Comercio','Aula Informática','1 BACH_A','ACOM 1',NULL,NULL,NULL),(2,'Administración y Gestión','Aula Desdoble 1','1 BACH_B','ACOM 2',NULL,NULL,NULL),(3,'Biología y Geología','Aula Desdoble 2','1 BACH_C','ADI 1',NULL,NULL,NULL),(4,'Ciencias Sociales','Aula Desdoble 3','1 BACH_D','ADI 2',NULL,NULL,NULL),(5,'Clásicas','Aula Desdoble 4','1 BACH_E','AFI 1',NULL,NULL,NULL),(6,'Comercio y Márketing','Aula Desdoble 5','1 DIV','AFI 2',NULL,NULL,NULL),(7,'Filosofía','Aula Cisco','1 ESO_A','ASIR 1',NULL,NULL,NULL),(8,'Física y Química','Aula desdoble bilingüe','1 ESO_B','ASIR 2',NULL,NULL,NULL),(9,'Francés','Aula apoyo PT','1 ESO_C','COI 1',NULL,NULL,NULL),(10,'Matemáticas','Aula PT','1 ESO_D','COI 2',NULL,NULL,NULL),(11,'Plástica','Sala usos múltiples','1 ESO_E','DAM 1',NULL,NULL,NULL),(12,'Tecnología','Aula abanico','2 BACH_A','DAM 2',NULL,NULL,NULL),(13,'Administración - Dirección','Aula abierta','2 BACH_B','DAW 1',NULL,NULL,NULL),(14,'Jefatura de Estudios','Laboratorio Física y Química','2 BACH_C','DAW 2',NULL,NULL,NULL),(15,'Secretaría','Laboratorio','2 BACH_D','FPB 1',NULL,NULL,NULL),(16,'Conserjería','Biología y Geología','2 ESO_A','FPB 2',NULL,NULL,NULL),(17,'Biblioteca','Sala Comunicaciones','2 ESO_B','GAD 1',NULL,NULL,NULL),(18,'Orientación y Educadora Social','Sala de Guardias','2 ESO_C','GAD 2',NULL,NULL,NULL),(19,'Informática','Sala de Profesores','2 ESO_D','PMAR_1',NULL,NULL,NULL),(20,'Lengua',NULL,NULL,NULL,NULL,NULL,NULL),(21,'Inglés',NULL,NULL,NULL,NULL,NULL,NULL),(22,NULL,'Cafetería','2 ESO_E',NULL,NULL,NULL,NULL),(23,NULL,'Aula Apoyo','2 ESO_F',NULL,NULL,NULL,NULL),(24,NULL,'Aula Plástica','3 ESO_A',NULL,NULL,NULL,NULL),(25,NULL,'Aula Desdoble','3 ESO_B',NULL,NULL,NULL,NULL),(26,NULL,'Aula Ateca','3 ESO_C',NULL,NULL,NULL,NULL),(27,NULL,'Aula de Música','3 ESO_D',NULL,NULL,NULL,NULL),(28,NULL,'Aula 2.0','3 ESO_E',NULL,NULL,NULL,NULL),(29,NULL,NULL,'3 ESO_F',NULL,NULL,NULL,NULL),(30,NULL,NULL,'4 ESO_A',NULL,NULL,NULL,NULL),(31,NULL,NULL,'4 ESO_B',NULL,NULL,NULL,NULL),(32,NULL,NULL,'4 ESO_C',NULL,NULL,NULL,NULL),(33,NULL,NULL,'4 ESO_D',NULL,NULL,NULL,NULL),(34,NULL,NULL,'4 ESO_E',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ubicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `idUsuario` smallint(6) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` char(10) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(120) COLLATE utf8_spanish_ci NOT NULL,
  `usuario` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `permisos` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-12 22:27:27
