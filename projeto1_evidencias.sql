-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: projeto1
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `evidencias`
--

DROP TABLE IF EXISTS `evidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_arquivo` varchar(255) DEFAULT NULL,
  `caminho` varchar(255) DEFAULT NULL,
  `id_controlo` varchar(50) DEFAULT NULL,
  `data_upload` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evidencias`
--

LOCK TABLES `evidencias` WRITE;
/*!40000 ALTER TABLE `evidencias` DISABLE KEYS */;
INSERT INTO `evidencias` VALUES (1,'evidencia-A.5.10-1778441368095.txt','uploads/evidencia-A.5.10-1778441368095.txt','A.5.10','2026-05-10 19:29:28'),(2,'evidencia-A.5.12-1778441381604.txt','uploads/evidencia-A.5.12-1778441381604.txt','A.5.12','2026-05-10 19:29:41'),(3,'evidencia-A.5.17-1778441400958.txt','uploads/evidencia-A.5.17-1778441400958.txt','A.5.17','2026-05-10 19:30:00'),(4,'evidencia-A.5.22-1778441494858.txt','uploads/evidencia-A.5.22-1778441494858.txt','A.5.22','2026-05-10 19:31:34'),(5,'evidencia-A.5.13-1778442053606.txt','uploads/evidencia-A.5.13-1778442053606.txt','A.5.13','2026-05-10 19:40:53'),(6,'evidencia-A.5.23-1778442116728.txt','uploads/evidencia-A.5.23-1778442116728.txt','A.5.23','2026-05-10 19:41:56'),(7,'evidencia-A.5.25-1778442156365.txt','uploads/evidencia-A.5.25-1778442156365.txt','A.5.25','2026-05-10 19:42:36'),(8,'evidencia-A.5.19-1778444367497.txt','uploads/evidencia-A.5.19-1778444367497.txt','A.5.19','2026-05-10 20:19:27'),(9,'evidencia-A.5.1-1778449684043.txt','uploads/evidencia-A.5.1-1778449684043.txt','A.5.1','2026-05-10 21:48:04'),(10,'evidencia-A.7.1-1778449740047.txt','uploads/evidencia-A.7.1-1778449740047.txt','A.7.1','2026-05-10 21:49:00'),(11,'evidencia-A.8.9-1778450298545.txt','uploads/evidencia-A.8.9-1778450298545.txt','A.8.9','2026-05-10 21:58:18'),(12,'evidencia-A.5.30-1778450975418.txt','uploads/evidencia-A.5.30-1778450975418.txt','A.5.30','2026-05-10 22:09:35'),(13,'evidencia-A.5.18-1778451385309.txt','uploads/evidencia-A.5.18-1778451385309.txt','A.5.18','2026-05-10 22:16:25'),(14,'evidencia-A.5.33-1778451778937.txt','uploads/evidencia-A.5.33-1778451778937.txt','A.5.33','2026-05-10 22:22:58'),(15,'evidencia-A.6.5-1778451965103.txt','uploads/evidencia-A.6.5-1778451965103.txt','A.6.5','2026-05-10 22:26:05'),(16,'evidencia-A.5.20-1778454052123.txt','uploads/evidencia-A.5.20-1778454052123.txt','A.5.20','2026-05-10 23:00:52'),(17,'evidencia-A.5.36-1778454531766.txt','uploads/evidencia-A.5.36-1778454531766.txt','A.5.36','2026-05-10 23:08:51'),(18,'evidencia-A.5.7-1778454544873.txt','uploads/evidencia-A.5.7-1778454544873.txt','A.5.7','2026-05-10 23:09:04'),(19,'evidencia-A.6.1-1778454550301.txt','uploads/evidencia-A.6.1-1778454550301.txt','A.6.1','2026-05-10 23:09:10'),(20,'evidencia-A.5.35-1778454555318.txt','uploads/evidencia-A.5.35-1778454555318.txt','A.5.35','2026-05-10 23:09:15'),(21,'evidencia-A.5.5-1778454558837.txt','uploads/evidencia-A.5.5-1778454558837.txt','A.5.5','2026-05-10 23:09:18'),(22,'evidencia-A.6.3-1778454563612.txt','uploads/evidencia-A.6.3-1778454563612.txt','A.6.3','2026-05-10 23:09:23'),(23,'evidencia-A.5.8-1778529645389.txt','uploads/evidencia-A.5.8-1778529645389.txt','A.5.8','2026-05-11 20:00:45'),(24,'evidencia-A.5.11-1778542644331.html','uploads/evidencia-A.5.11-1778542644331.html','A.5.11','2026-05-11 23:37:24'),(25,'evidencia-A.5.15-1778542684217.html','uploads/evidencia-A.5.15-1778542684217.html','A.5.15','2026-05-11 23:38:04'),(26,'evidencia-A.5.8-1778582103099.html','uploads/evidencia-A.5.8-1778582103099.html','A.5.8','2026-05-12 10:35:03');
/*!40000 ALTER TABLE `evidencias` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-13 20:56:55
