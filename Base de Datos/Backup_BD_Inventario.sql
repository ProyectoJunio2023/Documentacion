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

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Inventario` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;

--
-- Current User Database `Inventario`:
--

 CREATE USER IF NOT EXISTS 'adminInventario'@'localhost' IDENTIFIED BY 'albarregas';
 GRANT ALL PRIVILEGES ON Inventario.* TO 'adminInventario'@'localhost';
 FLUSH PRIVILEGES;

USE `Inventario`;

--
-- Table structure for table `dispositivos`
--

DROP TABLE IF EXISTS `dispositivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispositivos` (
  `idDispositivo` smallint(6) NOT NULL AUTO_INCREMENT,
  `numInventario` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `tipoDispositivo` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `marca` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `modelo` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `numSerie` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `fechaAlta` date NOT NULL,
  `idUbicacion` smallint(6) DEFAULT NULL,
  `idEquipo` smallint(6) DEFAULT NULL,
  `idMotivo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idDispositivo`),
  KEY `ubicacion_dispositivo` (`idUbicacion`),
  KEY `equipo_dispositivo` (`idEquipo`),
  KEY `motivoBaja_dispositivo` (`idMotivo`),
  CONSTRAINT `equipo_dispositivo` FOREIGN KEY (`idEquipo`) REFERENCES `equipos` (`idEquipo`),
  CONSTRAINT `motivoBaja_dispositivo` FOREIGN KEY (`idMotivo`) REFERENCES `motivosbaja` (`idMotivo`),
  CONSTRAINT `ubicacion_dispositivo` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispositivos`
--

LOCK TABLES `dispositivos` WRITE;
/*!40000 ALTER TABLE `dispositivos` DISABLE KEYS */;
INSERT INTO `dispositivos` (`idDispositivo`, `numInventario`, `tipoDispositivo`, `marca`, `modelo`, `numSerie`, `fechaAlta`, `idUbicacion`, `idEquipo`, `idMotivo`) VALUES (1,'ALBASEC','Raton','Genius','GM-080025','X4F67711109714','2022-12-10',NULL,NULL,NULL);
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
  `memoriaRam` char(3) COLLATE utf8_spanish_ci NOT NULL,
  `almacenamiento` char(4) COLLATE utf8_spanish_ci NOT NULL,
  `sistemaOperativo` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `componenteExtra` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fechaAlta` date NOT NULL,
  `idUbicacion` smallint(6) DEFAULT NULL,
  `idMotivo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idEquipo`),
  KEY `ubicacion_equipos` (`idUbicacion`),
  KEY `motivoBaja_equipo` (`idMotivo`),
  CONSTRAINT `motivoBaja_equipo` FOREIGN KEY (`idMotivo`) REFERENCES `motivosbaja` (`idMotivo`),
  CONSTRAINT `ubicacion_equipos` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` (`idEquipo`, `numinventario`, `tipoEquipo`, `marca`, `modelo`, `numSerie`, `procesador`, `memoriaRam`, `almacenamiento`, `sistemaOperativo`, `componenteExtra`, `fechaAlta`, `idUbicacion`, `idMotivo`) VALUES (1,'ALBAINF1','portatil','Lenovo','D310','jld12345','Intel i7 3500','16','2000','Ubuntu','No','2022-11-15',NULL,NULL);
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
  `marca` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `modelo` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `numSerie` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `tipoImpresora` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `enRed` char(2) COLLATE utf8_spanish_ci NOT NULL,
  `fechaAlta` date NOT NULL,
  `idUbicacion` smallint(6) DEFAULT NULL,
  `idMotivo` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`idImpresora`),
  KEY `ubicacion_impresoras` (`idUbicacion`),
  KEY `motivoBaja_impresora` (`idMotivo`),
  CONSTRAINT `motivoBaja_impresora` FOREIGN KEY (`idMotivo`) REFERENCES `motivosbaja` (`idMotivo`),
  CONSTRAINT `ubicacion_impresoras` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impresoras`
--

LOCK TABLES `impresoras` WRITE;
/*!40000 ALTER TABLE `impresoras` DISABLE KEYS */;
INSERT INTO `impresoras` (`idImpresora`, `numInventario`, `marca`, `modelo`, `numSerie`, `tipoImpresora`, `enRed`, `fechaAlta`, `idUbicacion`, `idMotivo`) VALUES (2,'ALBAINF4','Hewlett Packard','ENVY6000','ipl12345','All In One','Si','2022-11-15',NULL,NULL);
/*!40000 ALTER TABLE `impresoras` ENABLE KEYS */;
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
  `descripcionBaja` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idMotivo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motivosbaja`
--

LOCK TABLES `motivosbaja` WRITE;
/*!40000 ALTER TABLE `motivosbaja` DISABLE KEYS */;
INSERT INTO `motivosbaja` (`idMotivo`, `codigoBaja`, `descripcionBaja`) VALUES (1,'OBS','Equipo Obsoleto'),(2,'AVR','Averiado'),(3,'ACC','Accidente');
/*!40000 ALTER TABLE `motivosbaja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicacion` (
  `idUbicacion` smallint(6) NOT NULL AUTO_INCREMENT,
  `departamentos` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `aulas` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cursosCiclos` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicacion`
--

LOCK TABLES `ubicacion` WRITE;
/*!40000 ALTER TABLE `ubicacion` DISABLE KEYS */;
INSERT INTO `ubicacion` (`idUbicacion`, `departamentos`, `aulas`, `cursosCiclos`) VALUES (1,'Comercio','Aula Informatica','1 BACH_A'),(2,'Administracion y Gestion','Aula Desdoble 1','1 BACH_B'),(3,'Biologia y Geologia','Aula Desdoble 2','1 BACH_C'),(4,'Ciencias Sociales','Aula Desdoble 3','1 BACH_D'),(5,'Clasicas','Aula Desdoble 4','1 BACH_E'),(6,'Comercio y Marketing','Aula Desdoble 5','1 DIV'),(7,'Filosofia','Aula Cisco','1 ESO_A'),(8,'Fisica y Quimica','Aula desdoble bilingüe','1 ESO_B'),(9,'Frances, Lengua','Aula apoyo PT','1 ESO_C'),(10,'Matematicas','Aula PT','1 ESO_D'),(11,'Plastica','Sala usos multiples','1 ESO_E'),(12,'Tecnologia','Aula Abanico','2 BACH_A'),(13,'Administracion - Direccion','Aula Abierta','2 BACH_B'),(14,'Jefatura de Estudios','Laboratorio Fisica y Quimica','2 BACH_C'),(15,'Secretaria','Laboratorio','2 BACH_D'),(16,'Conserjeria','Biologia y Geologia','2 ESO_A'),(17,'Biblioteca','Sala Comunicaciones','2 ESO_B'),(18,'Orientacion y Educadora Social','Sala de Guardias','2 ESO_C'),(19,'Informatica','Sala de Profesores','2 ESO_D'),(20,NULL,'Cafeteria','2 ESO_E'),(21,NULL,'Aula Apoyo','2 ESO_F'),(22,NULL,'Aula Plastica','3 ESO_A'),(23,NULL,'Aula Desdoble','3 ESO_B'),(24,NULL,'Aula Ateca','3 ESO_C'),(25,NULL,'Aula de Musica','3 ESO_D'),(26,NULL,'Aula 2.0','3 ESO_E'),(27,NULL,NULL,'3 ESO_F'),(28,NULL,NULL,'4 ESO_A'),(29,NULL,NULL,'4 ESO_B'),(30,NULL,NULL,'4 ESO_C'),(31,NULL,NULL,'4 ESO_D'),(32,NULL,NULL,'4 ESO_E'),(33,NULL,NULL,'ACOM 1'),(34,NULL,NULL,'ACOM 2'),(35,NULL,NULL,'ADI 1'),(36,NULL,NULL,'ADI 2'),(37,NULL,NULL,'AFI 1'),(38,NULL,NULL,'AFI 2'),(39,NULL,NULL,'ASIR 1'),(40,NULL,NULL,'ASIR 2'),(41,NULL,NULL,'COI 1'),(42,NULL,NULL,'COI 2'),(43,NULL,NULL,'DAM 1'),(44,NULL,NULL,'DAM 2'),(45,NULL,NULL,'DAW 1'),(46,NULL,NULL,'DAW 2'),(47,NULL,NULL,'FPB 1'),(48,NULL,NULL,'FPB 2'),(49,NULL,NULL,'GAD 1'),(50,NULL,NULL,'GAD 2'),(51,NULL,NULL,'PMAR_1');
/*!40000 ALTER TABLE `ubicacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-13 22:45:16
