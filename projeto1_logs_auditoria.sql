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
-- Table structure for table `logs_auditoria`
--

DROP TABLE IF EXISTS `logs_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_auditoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_controlo` varchar(50) DEFAULT NULL,
  `acao` varchar(100) DEFAULT NULL,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_auditoria`
--

LOCK TABLES `logs_auditoria` WRITE;
/*!40000 ALTER TABLE `logs_auditoria` DISABLE KEYS */;
INSERT INTO `logs_auditoria` VALUES (1,'A.5.1','Alterou estado para CONFORME','2026-04-27 15:44:32','Nuno Carvalho'),(2,'A.5.1','Alterou estado para PENDENTE','2026-04-27 15:44:33','Nuno Carvalho'),(3,'A.5.1','Alterou estado para CONFORME','2026-04-27 15:44:34','Nuno Carvalho'),(4,'A.5.10','Alterou estado para CONFORME','2026-04-27 15:44:35','Nuno Carvalho'),(5,'A.5.10','Alterou estado para PENDENTE','2026-04-27 15:44:35','Nuno Carvalho'),(6,'A.5.1','Alterou estado para PENDENTE','2026-04-27 15:44:36','Nuno Carvalho'),(7,'A.5.10','Alterou estado para CONFORME','2026-04-27 15:44:37','Nuno Carvalho'),(8,'A.5.11','Alterou estado para CONFORME','2026-04-27 15:44:38','Nuno Carvalho'),(9,'A.5.12','Alterou estado para CONFORME','2026-04-27 15:44:40','Nuno Carvalho'),(10,'A.5.12','Alterou estado para PENDENTE','2026-04-27 15:44:40','Nuno Carvalho'),(11,'A.5.11','Alterou estado para PENDENTE','2026-04-27 15:44:41','Nuno Carvalho'),(12,'A.5.10','Alterou estado para PENDENTE','2026-04-27 15:44:41','Nuno Carvalho'),(13,'A.5.1','Alterou estado para CONFORME','2026-04-29 19:47:02','Nuno Carvalho'),(14,'A.5.10','Alterou estado para CONFORME','2026-04-29 19:47:03','Nuno Carvalho'),(15,'A.5.10','Alterou estado para PENDENTE','2026-04-29 19:47:08','Nuno Carvalho'),(16,'A.5.1','Alterou estado para PENDENTE','2026-04-29 19:47:09','Nuno Carvalho'),(17,'A.5.10','Alterou estado para CONFORME','2026-05-10 17:56:06','Nuno Carvalho'),(18,'A.5.11','Alterou estado para CONFORME','2026-05-10 17:56:07','Nuno Carvalho'),(19,'A.5.10','Alterou estado para PENDENTE','2026-05-10 17:56:08','Nuno Carvalho'),(20,'A.5.11','Alterou estado para PENDENTE','2026-05-10 17:56:09','Nuno Carvalho'),(21,'A.5.11','Alterou para CONFORME','2026-05-10 19:26:21','Nuno Carvalho'),(22,'A.5.10','Gerou evidência via IA','2026-05-10 20:29:28','Sistema AI'),(23,'A.5.12','Gerou evidência via IA','2026-05-10 20:29:41','Sistema AI'),(24,'A.5.17','Gerou evidência via IA','2026-05-10 20:30:00','Sistema AI'),(25,'A.5.22','Gerou evidência via IA','2026-05-10 20:31:34','Sistema AI'),(26,'A.5.13','Gerou evidência via IA','2026-05-10 20:40:53','Sistema AI'),(27,'A.5.23','Gerou evidência via IA','2026-05-10 20:41:56','Sistema AI'),(28,'A.5.10','Alterou para PENDENTE','2026-05-10 20:42:23','Nuno Carvalho'),(29,'A.5.10','Alterou para CONFORME','2026-05-10 20:42:25','Nuno Carvalho'),(30,'A.5.25','Gerou evidência via IA','2026-05-10 20:42:36','Sistema AI'),(31,'A.5.19','Gerou evidência via IA','2026-05-10 21:19:27','Sistema AI'),(32,'A.5.1','Alterou para PENDENTE','2026-05-10 22:32:57','Nuno Carvalho'),(33,'A.5.1','Evidência gerada via IA','2026-05-10 22:48:04','Sistema'),(34,'A.7.1','Evidência gerada via IA','2026-05-10 22:49:00','Sistema'),(35,'A.8.9','Evidência gerada via IA','2026-05-10 22:58:18','Sistema'),(36,'A.5.30','Evidência gerada via IA','2026-05-10 23:09:35','Sistema'),(37,'A.5.18','Evidência gerada via IA','2026-05-10 23:16:25','Sistema'),(38,'A.5.33','Evidência gerada via IA','2026-05-10 23:22:58','Sistema'),(39,'A.6.5','Evidência gerada via IA','2026-05-10 23:26:05','Sistema'),(40,'A.5.1','Alterou para PENDENTE','2026-05-11 00:00:42','Nuno Carvalho'),(41,'A.5.1','Alterou para CONFORME','2026-05-11 00:00:43','Nuno Carvalho'),(42,'A.5.20','Evidência gerada via IA','2026-05-11 00:00:52','Sistema'),(43,'A.5.36','Evidência gerada via IA','2026-05-11 00:08:51','Sistema'),(44,'A.5.7','Evidência gerada via IA','2026-05-11 00:09:04','Sistema'),(45,'A.6.1','Evidência gerada via IA','2026-05-11 00:09:10','Sistema'),(46,'A.5.35','Evidência gerada via IA','2026-05-11 00:09:15','Sistema'),(47,'A.5.5','Evidência gerada via IA','2026-05-11 00:09:18','Sistema'),(48,'A.6.3','Evidência gerada via IA','2026-05-11 00:09:23','Sistema'),(49,'A.5.8','Alterou para CONFORME','2026-05-11 21:00:43','Nuno Carvalho'),(50,'A.5.8','Alterou para PENDENTE','2026-05-11 21:00:44','Nuno Carvalho'),(51,'A.5.8','Evidência gerada via IA','2026-05-11 21:00:45','Sistema'),(52,'A.7.2','Alterou para CONFORME','2026-05-11 22:23:00','Nuno Carvalho'),(53,'A.8.10','Alterou para CONFORME','2026-05-11 22:23:40','Nuno Carvalho'),(54,'A.8.1','Alterou para CONFORME','2026-05-11 22:23:41','Nuno Carvalho'),(55,'A.7.8','Alterou para CONFORME','2026-05-11 22:23:41','Nuno Carvalho'),(56,'A.7.7','Alterou para CONFORME','2026-05-11 22:23:41','Nuno Carvalho'),(57,'A.7.6','Alterou para CONFORME','2026-05-11 22:23:42','Nuno Carvalho'),(58,'A.8.17','Alterou para CONFORME','2026-05-11 22:23:43','Nuno Carvalho'),(59,'A.8.18','Alterou para CONFORME','2026-05-11 22:23:43','Nuno Carvalho'),(60,'A.8.16','Alterou para CONFORME','2026-05-11 22:23:44','Nuno Carvalho'),(61,'A.8.15','Alterou para CONFORME','2026-05-11 22:23:44','Nuno Carvalho'),(62,'A.8.13','Alterou para CONFORME','2026-05-11 22:23:45','Nuno Carvalho'),(63,'A.8.20','Alterou para CONFORME','2026-05-11 22:23:47','Nuno Carvalho'),(64,'A.8.21','Alterou para CONFORME','2026-05-11 22:23:47','Nuno Carvalho'),(65,'A.8.22','Alterou para CONFORME','2026-05-11 22:23:48','Nuno Carvalho'),(66,'A.8.23','Alterou para CONFORME','2026-05-11 22:23:48','Nuno Carvalho'),(67,'A.8.21','Alterou para PENDENTE','2026-05-11 22:23:52','Nuno Carvalho'),(68,'A.8.33','Alterou para CONFORME','2026-05-11 22:23:55','Nuno Carvalho'),(69,'A.8.32','Alterou para CONFORME','2026-05-11 22:23:56','Nuno Carvalho'),(70,'A.8.31','Alterou para CONFORME','2026-05-11 22:23:56','Nuno Carvalho'),(71,'A.8.30','Alterou para CONFORME','2026-05-11 22:23:57','Nuno Carvalho'),(72,'A.8.27','Alterou para CONFORME','2026-05-11 22:23:58','Nuno Carvalho'),(73,'A.8.26','Alterou para CONFORME','2026-05-11 22:23:59','Nuno Carvalho'),(74,'A.8.28','Alterou para CONFORME','2026-05-11 22:23:59','Nuno Carvalho'),(75,'A.8.29','Alterou para CONFORME','2026-05-11 22:24:00','Nuno Carvalho'),(76,'A.5.26','Alterou para CONFORME','2026-05-11 22:28:18','Nuno Carvalho'),(77,'A.5.26','Alterou para PENDENTE','2026-05-11 22:28:21','Nuno Carvalho'),(78,'A.5.37','Alterou para CONFORME','2026-05-11 22:28:44','Nuno Carvalho'),(79,'A.5.3','Alterou para CONFORME','2026-05-11 22:32:40','Nuno Carvalho'),(80,'A.5.3','Alterou para PENDENTE','2026-05-11 22:32:41','Nuno Carvalho'),(81,'A.5.3','Alterou para CONFORME','2026-05-11 22:32:42','Nuno Carvalho'),(82,'A.8.6','Alterou para CONFORME','2026-05-11 22:32:48','Nuno Carvalho'),(83,'A.8.7','Alterou para CONFORME','2026-05-11 22:32:49','Nuno Carvalho'),(84,'A.8.4','Alterou para CONFORME','2026-05-11 22:32:50','Nuno Carvalho'),(85,'A.8.15','Alterou para CONFORME','2026-05-11 23:20:21','Nuno Carvalho'),(86,'A.8.15','Risco Mitigado e Plano de Ação registado','2026-05-11 23:31:25','Nuno Carvalho'),(87,'A.5.11','Evidência gerada e Documento HTML criado','2026-05-12 00:37:24','Sistema'),(88,'A.5.15','Evidência gerada e Documento HTML criado','2026-05-12 00:38:04','Sistema'),(89,'A.5.14','Alterou para CONFORME','2026-05-12 00:41:30','Nuno Carvalho'),(90,'A.5.14','Alterou para PENDENTE','2026-05-12 00:41:31','Nuno Carvalho'),(91,'A.5.14','Alterou para PENDENTE','2026-05-12 00:41:39','Nuno Carvalho'),(92,'A.5.14','Alterou para CONFORME','2026-05-12 00:41:42','Nuno Carvalho'),(93,'A.5.1','Alterou para PENDENTE','2026-05-12 00:45:49','Nuno Carvalho'),(94,'A.5.8','Evidência gerada e Documento HTML criado','2026-05-12 11:35:03','Sistema'),(95,'A.5.1','Risco Mitigado e Plano de Ação registado','2026-05-12 11:41:50','Nuno Carvalho');
/*!40000 ALTER TABLE `logs_auditoria` ENABLE KEYS */;
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
