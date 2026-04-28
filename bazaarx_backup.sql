-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: bazaarx
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `bazaarx`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bazaarx` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bazaarx`;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,9,7,1),(2,9,17,1),(3,9,9,1),(9,6,2,1),(11,6,8,1),(17,10,14,1),(18,10,4,1),(28,5,14,1),(29,5,14,1),(30,5,17,1),(31,5,9,1),(32,5,15,1),(33,5,15,1),(35,4,9,1),(36,4,12,1),(37,4,4,1),(38,4,2,1),(39,4,9,1),(40,4,9,1),(41,4,17,1),(43,11,14,1),(45,12,4,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `total` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,80000,'2026-04-16 15:45:38'),(2,1,47991,'2026-04-17 09:10:49'),(3,1,0,'2026-04-17 09:11:03'),(4,1,24900,'2026-04-17 09:11:16'),(5,4,79999,'2026-04-17 10:38:39'),(6,8,399,'2026-04-17 10:49:34'),(7,6,27399,'2026-04-17 15:10:35'),(8,4,0,'2026-04-17 15:22:30'),(9,11,0,'2026-04-18 03:39:40');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `description` text,
  `rating` float DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `image` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,'Samsung Galaxy S24','Electronics',89999,7,'Latest Samsung flagship with AI features',4.5,10,'https://images.unsplash.com/photo-1705585174953-9b2aa8afc174?q=80&w=732&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),(3,'boAt Airdopes 141','Electronics',1499,50,'Wireless earbuds with long battery',4.2,20,'https://images.unsplash.com/photo-1623788728910-23180a99871d?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Ym9BdCUyMGFpcnBvZHMlMjAxNDF8ZW58MHx8MHx8fDA%3D'),(4,'Apple AirPods Pro','Electronics',24900,8,'Active noise cancellation earbuds',4.8,5,'https://images.unsplash.com/photo-1603351154351-5e2d0600bb77?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YXBwbGUlMjBhaXJwb2RzJTIwcHJvfGVufDB8fDB8fHww'),(5,'Noise Smartwatch','Electronics',3499,30,'Fitness smartwatch AMOLED display',4.1,15,'https://images.unsplash.com/photo-1720665977720-6a4b93638645?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fG5vaXNlJTIwc21hcnR3YXRjaHxlbnwwfHwwfHx8MA%3D%3D'),(6,'HP Pavilion Laptop','Electronics',52999,5,'i5 laptop for students',4.3,8,'https://images.unsplash.com/photo-1663354027456-ce6a7e07d212?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGhwJTIwcGF2aWxsaW9uJTIwbGFwdG9wfGVufDB8fDB8fHww'),(7,'Sony WH-1000XM5','Electronics',28990,12,'Premium noise cancelling headphones',4.9,0,'https://images.unsplash.com/photo-1755719401541-d78b9bc9b514?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c29ueSUyMHdoLTEwMDB4bTV8ZW58MHx8MHx8fDA%3D'),(8,'Nike Dri-FIT T-Shirt','Clothing',1995,40,'Comfortable sports t-shirt',4.4,25,'https://images.unsplash.com/photo-1585036398651-c89d459f07b7?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bmlrZSUyMGRyaS1GSVQlMjBULXNoaXJ0fGVufDB8fDB8fHww'),(9,'Levis Slim Jeans','Clothing',3999,25,'Stylish slim fit jeans',4.6,15,'https://images.unsplash.com/photo-1694725369452-6cfadad90af3?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGxldmlzJTIwc2xpbSUyMGplYW5zfGVufDB8fDB8fHww'),(10,'Puma Hoodie','Clothing',2799,18,'Warm hoodie for winter',4.2,20,'https://images.unsplash.com/photo-1580978021225-24447a465bb3?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHVtYSUyMGhvZGRpZXxlbnwwfHwwfHx8MA%3D%3D'),(11,'H&M Floral Dress','Clothing',1499,22,'Light summer dress',4.3,10,'https://plus.unsplash.com/premium_photo-1723535671118-ae4028123e40?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZmxvcmFsJTIwZHJlc3N8ZW58MHx8MHx8fDA%3D'),(12,'Adidas Running Shoes','Clothing',6999,14,'Lightweight running shoes',4.7,5,'https://images.unsplash.com/photo-1656057903797-175389ce695d?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8QURJREFTJTIwUlVOTklORyUyMFNTSE9FU3xlbnwwfHwwfHx8MA%3D%3D'),(13,'Zara Blazer','Clothing',4990,9,'Formal blazer for office',4.5,0,'https://images.unsplash.com/photo-1681991724832-56e4ccc04415?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8emFyYSUyMGJsYXplcnxlbnwwfHwwfHx8MA%3D%3D'),(14,'Atomic Habits','Books',399,100,'Build good habits easily',4.9,20,'https://images.unsplash.com/photo-1598301257942-e6bde1d2149b?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXRvbWljJTIwaGFiaXRzfGVufDB8fDB8fHww'),(15,'The Alchemist','Books',299,75,'Famous inspirational novel',4.8,15,'https://images.unsplash.com/photo-1627023813330-c7d58fe34835?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dGhlJTIwYWxjaGVtaXN0cyUyMGJvb2t8ZW58MHx8MHx8fDA%3D'),(16,'Rich Dad Poor Dad','Books',349,60,'Financial knowledge book',4.7,10,'https://images.unsplash.com/photo-1625887261994-b843b2e5d82e?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmljaCUyMGRhZCUyMHBvb3IlMjBkYWQlMjBib29rfGVufDB8fDB8fHww'),(17,'Python Crash Course','Books',699,35,'Beginner programming guide',4.8,5,'https://images.unsplash.com/photo-1702047048032-e734daa2473d?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHB5dGhvbiUyMGNyYXNoJTIwY291cnNlJTIwYm9va3xlbnwwfHwwfHx8MA%3D%3D'),(18,'Deep Work','Books',449,45,'Improve focus and productivity',4.6,12,'https://images.unsplash.com/photo-1711185895262-f14ad4d4eeac?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZGVlcCUyMHdvcmslMjBib29rfGVufDB8fDB8fHww'),(19,'Prestige Induction','Home & Kitchen',3295,20,'Efficient cooking appliance',4.4,18,'https://images.unsplash.com/photo-1588279102625-58a9efdac2a8?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJlc3RpZ2UlMjBpbmR1Y3Rpb258ZW58MHx8MHx8fDA%3D'),(20,'Philips Air Fryer','Home & Kitchen',7995,10,'Healthy air frying',4.6,22,'https://images.unsplash.com/photo-1695089028114-ce28248f0ab9?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhpbGlwcyUyMGFpciUyMGZyeWVyfGVufDB8fDB8fHww'),(21,'Milton Bottle','Home & Kitchen',599,80,'Steel insulated bottle',4.5,10,'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Ym90dGxlfGVufDB8fDB8fHww'),(22,'Non-Stick Pan','Home & Kitchen',899,35,'Durable cooking pan',4.3,15,'https://images.unsplash.com/photo-1624031000828-dba1b7a3e4ce?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bm9uJTIwc3RpY2wlMjBwYW58ZW58MHx8MHx8fDA%3D'),(23,'Yoga Mat','Sports',799,45,'Anti-slip exercise mat',4.4,10,'https://plus.unsplash.com/premium_photo-1675155952889-abb299df1fe7?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8eW9nYSUyMG1hdHxlbnwwfHwwfHx8MA%3D%3D'),(24,'Dumbbells 5kg','Sports',999,30,'Gym equipment for home',4.5,20,'https://images.unsplash.com/photo-1648659125396-5bf148702e3d?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZHVtYmVsJTIwNXxlbnwwfHwwfHx8MA%3D%3D'),(25,'Cricket Bat','Sports',2499,15,'Professional cricket bat',4.6,8,'https://images.unsplash.com/photo-1646282814550-f521d9b57a59?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JpY2tldCUyMGJhdHxlbnwwfHwwfHx8MA%3D%3D'),(26,'Football','Sports',799,25,'Match quality football',4.3,5,'https://plus.unsplash.com/premium_photo-1661868926397-0083f0503c07?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vdGJhbGx8ZW58MHx8MHx8fDA%3D'),(27,'Backpack 30L','Sports',1999,18,'Water resistant backpack',4.5,15,'https://images.unsplash.com/photo-1514524865930-188150490d83?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmFjayUyMHBhY2t8ZW58MHx8MHx8fDA%3D'),(28,'Lakme Primer','Beauty',349,60,'Makeup primer SPF',4.4,12,'https://plus.unsplash.com/premium_photo-1760636026097-cb63c943d9fb?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fHByaW1lcnxlbnwwfHwwfHx8MA%3D%3D'),(29,'Nykaa Mascara','Beauty',399,55,'Volume mascara',4.3,8,'https://images.unsplash.com/photo-1631214540553-ff044a3ff1d4?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFzY2FyYXxlbnwwfHwwfHx8MA%3D%3D'),(30,'Nivea Moisturizer','Beauty',299,90,'Daily skin cream',4.7,5,'https://images.unsplash.com/photo-1771764704818-863592175d07?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bml2ZWElMjBtb2lzdHVyaXplcnxlbnwwfHwwfHx8MA%3D%3D'),(31,'Dove Shampoo','Beauty',449,70,'Hair repair shampoo',4.5,10,'https://images.unsplash.com/photo-1672330427989-7676be4a34bc?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG92ZSUyMHNoYW1wb298ZW58MHx8MHx8fDA%3D'),(32,'iPhone 15','Electronics',80000,10,'Apple latest phone',4.8,5,'https://images.unsplash.com/photo-1695048132832-b41495f12eb4?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aXBob25lJTIwMTV8ZW58MHx8MHx8fDA%3D'),(33,'MacBook Air M2','Electronics',105000,6,'Apple lightweight laptop',4.9,3,'https://images.unsplash.com/photo-1639586657928-a2ba10f027ac?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bWFjJTIwYm9vayUyMGFpciUyMG0yfGVufDB8fDB8fHww'),(34,'Realme Narzo','Electronics',12999,20,'Budget smartphone',4.2,12,'https://images.unsplash.com/photo-1695499405433-63b7d42e7326?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVhbG1lfGVufDB8fDB8fHww'),(35,'Gaming Mouse RGB','Electronics',1499,35,'RGB gaming mouse',4.3,18,'https://images.unsplash.com/photo-1627745214193-2bcefc681524?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2FtaW5nJTIwbW91c2UlMjByZ2J8ZW58MHx8MHx8fDA%3D'),(37,'Pears Soap','Beauty',343,34,'Pears soap for this summer.',NULL,NULL,'https://images.unsplash.com/photo-1697636283708-8308bef947b8?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVhcnMlMjBzb2FwfGVufDB8fDB8fHww'),(38,'UV Doux Sunscreen','Beauty',780,19,'Protection form harsh uv rays.',NULL,NULL,'https://plus.unsplash.com/premium_photo-1750182349971-4e3f32b3105c?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXYlMjBkb3V4fGVufDB8fDB8fHww'),(40,'IKEA Cloths Hanger','Home & Kitchen',2300,10,'To dry wet clothes indoors.',NULL,NULL,'https://images.unsplash.com/photo-1657981190914-e7bc1cba612e?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aWtlYSUyMGNsb3RocyUyMGhhbmdlcnxlbnwwfHwwfHx8MA%3D%3D'),(42,'Pillow Cover','Home & Kitchen',90,34,'Silk Pillow covers for comfort.',4,0,'https://images.unsplash.com/photo-1606796913622-568a03126269?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2lsayUyMHBpbGxvdyUyMGNvdmVyfGVufDB8fDB8fHww'),(43,'Short Dress','Clothing',999,20,'Cute dress for summers',NULL,NULL,'https://images.unsplash.com/photo-1730140762604-c35f81d47b11?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2hvcnQlMjBkcmVzc3xlbnwwfHwwfHx8MA%3D%3D'),(44,'High heels','Clothing',7999,0,'Brown colored high heels.',NULL,NULL,'https://images.unsplash.com/photo-1637002932871-13be6fd3feb8?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjBhbmQlMjByZWQlMjBoaWdoJTIwaGVlbHN8ZW58MHx8MHx8fDA%3D');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'myname','myname@gmail.com','myname','user'),(4,'Admin','admin@bazaarx.com','admin123','admin'),(5,'meenakshi','meenakshi@gmail.com','meenakshi','user'),(6,'payal','payal@gmail.com','payal','user'),(7,'arya','arya@gmail.com','arya','user'),(8,'Robin hood','robin@gmail.com','robin','user'),(9,'riya','riya@gmail.com','riya','user'),(10,'jimmy','jimmy@gmail.com','jimmy','user'),(11,'john','john@gmail.com','john','user'),(12,'veena ','veena@gmail.com','veena','user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-20 21:17:55
