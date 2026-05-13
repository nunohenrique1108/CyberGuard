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
-- Table structure for table `auditorias`
--

DROP TABLE IF EXISTS `auditorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditorias` (
  `id_controlo` varchar(10) NOT NULL,
  `id_dominio` varchar(10) DEFAULT NULL,
  `nome_controlo` varchar(255) NOT NULL,
  `estado` enum('CONFORME','PENDENTE','NÃO CONFORME') DEFAULT 'PENDENTE',
  `risco` enum('BAIXO','MÉDIO','ALTO','CRÍTICO') DEFAULT 'MÉDIO',
  `data_atualizacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_empresa` int DEFAULT NULL,
  `conforme` tinyint(1) DEFAULT '0',
  `plano_acao` text,
  PRIMARY KEY (`id_controlo`),
  KEY `id_dominio` (`id_dominio`),
  KEY `fk_empresa` (`id_empresa`),
  CONSTRAINT `auditorias_ibfk_1` FOREIGN KEY (`id_dominio`) REFERENCES `dominios` (`id`),
  CONSTRAINT `fk_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditorias`
--

LOCK TABLES `auditorias` WRITE;
/*!40000 ALTER TABLE `auditorias` DISABLE KEYS */;
INSERT INTO `auditorias` VALUES ('A.5.1',NULL,'Políticas de segurança da informação.','CONFORME','BAIXO','2026-05-12 10:41:50',1,1,'[Registado por Nuno Carvalho em 12/05/2026, 11:41:50]\nPlano de Ação: Atualizar a política de passwords e forçar a rotação criptográfica. Recomenda-se a ativação do módulo de auditoria de logs diários para identificar tentativas de intrusão.'),('A.5.10',NULL,'Uso aceitável de informações e outros ativos.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.11',NULL,'Devolução de ativos.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.12',NULL,'Classificação da informação.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.13',NULL,'Rotulagem da informação.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.14',NULL,'Transferência de informação.','CONFORME','BAIXO','2026-05-11 23:41:42',1,0,NULL),('A.5.15',NULL,'Controlo de acessos.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.16',NULL,'Gestão de identidade.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.17',NULL,'Informação de autenticação.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.18',NULL,'Direitos de acesso.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.19',NULL,'Segurança da informação nas relações com fornecedores.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.2',NULL,'Funções e responsabilidades de segurança da informação.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.20',NULL,'Tratamento da segurança da informação em acordos com fornecedores.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.21',NULL,'Gestão da segurança da informação na cadeia de fornecimento de TIC.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.22',NULL,'Monitorização, análise e avaliação de serviços de fornecedores.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.23',NULL,'Segurança da informação no uso de serviços na cloud.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.24',NULL,'Planeamento e preparação da gestão de incidentes de segurança.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.25',NULL,'Avaliação e decisão sobre eventos de segurança da informação.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.26',NULL,'Resposta a incidentes de segurança da informação.','PENDENTE','BAIXO','2026-05-11 21:28:21',1,0,NULL),('A.5.27',NULL,'Aprender com incidentes de segurança da informação.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.28',NULL,'Recolha de evidências (Provas forenses).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.29',NULL,'Segurança da informação durante disrupções (Continuidade de negócio).','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.3',NULL,'Separação de funções (Segregation of duties).','CONFORME','BAIXO','2026-05-11 21:32:42',1,0,NULL),('A.5.30',NULL,'Prontidão das TIC para a continuidade do negócio.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.31',NULL,'Requisitos legais, estatutários, regulamentares e contratuais.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.32',NULL,'Direitos de propriedade intelectual (DPI).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.33',NULL,'Proteção de registos (Records protection).','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.34',NULL,'Privacidade e proteção de dados pessoais (PII).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.35',NULL,'Revisão independente da segurança da informação.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.36',NULL,'Conformidade com políticas, regras e normas de segurança.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.37',NULL,'Procedimentos operacionais documentados.','CONFORME','BAIXO','2026-05-11 21:28:44',1,0,NULL),('A.5.4',NULL,'Responsabilidades da gestão (Management responsibilities).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.5',NULL,'Contacto com autoridades.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.6',NULL,'Contacto com grupos de interesse especial.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.7',NULL,'Inteligência sobre ameaças (Threat intelligence).','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.8',NULL,'Segurança da informação na gestão de projetos.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.5.9',NULL,'Inventário de informações e outros ativos associados.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.1',NULL,'Verificação de antecedentes (Screening).','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.2',NULL,'Termos e condições de emprego.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.3',NULL,'Consciencialização, educação e treino em segurança da informação.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.4',NULL,'Processo disciplinar.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.5',NULL,'Responsabilidades após rescisão ou alteração de emprego.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.6',NULL,'Acordos de confidencialidade ou não divulgação (NDA).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.7',NULL,'Trabalho remoto (Teletrabalho).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.6.8',NULL,'Notificação de eventos de segurança da informação.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.1',NULL,'Perímetros de segurança física.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.10',NULL,'Meios de armazenamento (Storage media).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.11',NULL,'Utilitários de suporte (energia, climatização).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.12',NULL,'Segurança de cablagem.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.13',NULL,'Manutenção de equipamentos.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.14',NULL,'Eliminação segura ou reutilização de equipamentos.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.2',NULL,'Controlos de entrada física.','CONFORME','BAIXO','2026-05-11 21:23:00',1,0,NULL),('A.7.3',NULL,'Segurança de escritórios, salas e instalações.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.4',NULL,'Monitorização de segurança física.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.5',NULL,'Proteção contra ameaças físicas e ambientais.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.7.6',NULL,'Trabalho em áreas seguras.','CONFORME','BAIXO','2026-05-11 21:23:42',1,0,NULL),('A.7.7',NULL,'Secretária limpa e ecrã limpo.','CONFORME','BAIXO','2026-05-11 21:23:41',1,0,NULL),('A.7.8',NULL,'Localização e proteção de equipamentos.','CONFORME','BAIXO','2026-05-11 21:23:41',1,0,NULL),('A.7.9',NULL,'Segurança de ativos fora das instalações.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.1',NULL,'Dispositivos de utilizador final (User endpoint devices).','CONFORME','BAIXO','2026-05-11 21:23:41',1,0,NULL),('A.8.10',NULL,'Eliminação de informações.','CONFORME','BAIXO','2026-05-11 21:23:40',1,0,NULL),('A.8.11',NULL,'Mascaramento de dados (Data masking).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.12',NULL,'Prevenção de vazamento de dados (DLP).','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.13',NULL,'Cópias de segurança de informações (Backups).','CONFORME','BAIXO','2026-05-11 21:23:45',1,0,NULL),('A.8.14',NULL,'Redundância de instalações de processamento de informação.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.15',NULL,'Registo de eventos (Logging).','CONFORME','CRÍTICO','2026-05-11 22:31:25',1,1,'[Registado por Nuno Carvalho em 11/05/2026, 23:31:25]\nPlano de Ação: Isolar a rede afetada numa VLAN dedicada e aplicar regras restritas de Firewall. Agendar um teste de penetração (Pentest) nos próximos 15 dias para validar a mitigação.'),('A.8.16',NULL,'Atividades de monitorização.','CONFORME','BAIXO','2026-05-11 21:23:44',1,0,NULL),('A.8.17',NULL,'Sincronização de relógios.','CONFORME','BAIXO','2026-05-11 21:23:43',1,0,NULL),('A.8.18',NULL,'Uso de programas utilitários privilegiados.','CONFORME','BAIXO','2026-05-11 21:23:43',1,0,NULL),('A.8.19',NULL,'Instalação de software em sistemas operacionais.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.2',NULL,'Direitos de acesso privilegiado.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.20',NULL,'Segurança de redes.','CONFORME','BAIXO','2026-05-11 21:23:47',1,0,NULL),('A.8.21',NULL,'Segurança dos serviços de rede.','PENDENTE','BAIXO','2026-05-11 21:23:52',1,0,NULL),('A.8.22',NULL,'Separação de redes.','CONFORME','BAIXO','2026-05-11 21:23:48',1,0,NULL),('A.8.23',NULL,'Filtro web (Web filtering).','CONFORME','BAIXO','2026-05-11 21:23:48',1,0,NULL),('A.8.24',NULL,'Uso de criptografia.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.25',NULL,'Ciclo de vida de desenvolvimento seguro.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.26',NULL,'Requisitos de segurança da aplicação.','CONFORME','BAIXO','2026-05-11 21:23:59',1,0,NULL),('A.8.27',NULL,'Princípios de arquitetura e engenharia de sistemas seguros.','CONFORME','BAIXO','2026-05-11 21:23:58',1,0,NULL),('A.8.28',NULL,'Codificação segura (Secure coding).','CONFORME','BAIXO','2026-05-11 21:23:59',1,0,NULL),('A.8.29',NULL,'Testes de segurança em desenvolvimento e aceitação.','CONFORME','BAIXO','2026-05-11 21:24:00',1,0,NULL),('A.8.3',NULL,'Restrição de acesso à informação.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.30',NULL,'Desenvolvimento externalizado (Outsourced development).','CONFORME','BAIXO','2026-05-11 21:23:57',1,0,NULL),('A.8.31',NULL,'Separação de ambientes de desenvolvimento, teste e produção.','CONFORME','BAIXO','2026-05-11 21:23:56',1,0,NULL),('A.8.32',NULL,'Gestão de mudanças (Change management).','CONFORME','BAIXO','2026-05-11 21:23:56',1,0,NULL),('A.8.33',NULL,'Informação de teste (Test information).','CONFORME','BAIXO','2026-05-11 21:23:55',1,0,NULL),('A.8.34',NULL,'Proteção de sistemas de informação durante testes de auditoria.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.4',NULL,'Acesso ao código-fonte.','CONFORME','BAIXO','2026-05-11 21:32:50',1,0,NULL),('A.8.5',NULL,'Autenticação segura.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.6',NULL,'Gestão de capacidade.','CONFORME','BAIXO','2026-05-11 21:32:48',1,0,NULL),('A.8.7',NULL,'Proteção contra malware.','CONFORME','BAIXO','2026-05-11 21:32:49',1,0,NULL),('A.8.8',NULL,'Gestão de vulnerabilidades técnicas.','PENDENTE','BAIXO','2026-05-11 21:02:07',1,0,NULL),('A.8.9',NULL,'Gestão de configurações.','CONFORME','BAIXO','2026-05-11 21:02:07',1,0,NULL);
/*!40000 ALTER TABLE `auditorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dominios`
--

DROP TABLE IF EXISTS `dominios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dominios` (
  `id` varchar(10) NOT NULL,
  `nome` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dominios`
--

LOCK TABLES `dominios` WRITE;
/*!40000 ALTER TABLE `dominios` DISABLE KEYS */;
INSERT INTO `dominios` VALUES ('A.12','Segurança das Operações'),('A.5','Políticas de Segurança da Informação'),('A.9','Controlo de Acesso');
/*!40000 ALTER TABLE `dominios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nome_empresa` varchar(100) NOT NULL,
  `nif` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `nif` (`nif`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'CyberGuard GRC','500123456');
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `utilizadores`
--

DROP TABLE IF EXISTS `utilizadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `cargo` varchar(50) DEFAULT 'Auditor',
  `email` varchar(100) DEFAULT NULL,
  `secret_2fa` varchar(255) DEFAULT NULL,
  `is_2fa_active` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilizadores`
--

LOCK TABLES `utilizadores` WRITE;
/*!40000 ALTER TABLE `utilizadores` DISABLE KEYS */;
INSERT INTO `utilizadores` VALUES (1,'Nuno Admin','nuno','12345','Auditor Principal',NULL,NULL,0),(2,'Nuno Carvalho','Nunaiko','Snolinhaa1','Auditor',NULL,NULL,0),(3,'Nuno Carvalho','nunohenrique1107','Snolinhaa1','Auditor','nunohenrique1108@gmail.com','LJ4DKO2UOAZE2OJJMESTOUDRMJSWW4ZWIUSVA6STLI7DC6ZJPNXA',1);
/*!40000 ALTER TABLE `utilizadores` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-13 20:59:44
