-- GIMMOBLIER2026 - export public assaini
-- Schema complet; donnees de reference uniquement.
-- Comptes, sessions, jetons et donnees personnelles exclus.


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
DROP TABLE IF EXISTS `app_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_params` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_params_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `booking_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `color` varchar(255) NOT NULL DEFAULT 'f0f0f0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `checkin` date NOT NULL,
  `checkout` date NOT NULL,
  `nb_days` int(11) NOT NULL,
  `amount` double NOT NULL,
  `nb_guest` int(11) NOT NULL,
  `status_id` bigint(20) unsigned NOT NULL,
  `payment_method` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `realestate_id` bigint(20) unsigned NOT NULL,
  `client_review_id` bigint(20) unsigned DEFAULT NULL,
  `host_review_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_intent` varchar(255) DEFAULT NULL,
  `is_cron_pass` tinyint(1) NOT NULL DEFAULT 0,
  `type_id` bigint(20) unsigned DEFAULT NULL,
  `night_price` double DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `type_guest` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_status_id_foreign` (`status_id`),
  KEY `bookings_payment_method_foreign` (`payment_method`),
  KEY `bookings_client_id_foreign` (`client_id`),
  KEY `bookings_realestate_id_foreign` (`realestate_id`),
  KEY `bookings_client_review_id_foreign` (`client_review_id`),
  KEY `bookings_host_review_id_foreign` (`host_review_id`),
  KEY `bookings_type_id_foreign` (`type_id`),
  KEY `bookings_created_by_foreign` (`created_by`),
  CONSTRAINT `bookings_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`),
  CONSTRAINT `bookings_client_review_id_foreign` FOREIGN KEY (`client_review_id`) REFERENCES `client_reviews` (`id`),
  CONSTRAINT `bookings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `managers` (`id`),
  CONSTRAINT `bookings_host_review_id_foreign` FOREIGN KEY (`host_review_id`) REFERENCES `host_reviews` (`id`),
  CONSTRAINT `bookings_payment_method_foreign` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`id`),
  CONSTRAINT `bookings_realestate_id_foreign` FOREIGN KEY (`realestate_id`) REFERENCES `realstates` (`id`),
  CONSTRAINT `bookings_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `booking_statuses` (`id`),
  CONSTRAINT `bookings_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `type_bookings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `type` varchar(255) NOT NULL DEFAULT 'fixed',
  `document` varchar(255) DEFAULT NULL,
  `verification_document` varchar(255) DEFAULT NULL,
  `realestate_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `charges_realestate_id_foreign` (`realestate_id`),
  CONSTRAINT `charges_realestate_id_foreign` FOREIGN KEY (`realestate_id`) REFERENCES `realstates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `region_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cities_region_id_foreign` (`region_id`),
  CONSTRAINT `cities_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `client_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rate` double NOT NULL DEFAULT 0,
  `comment` varchar(250) NOT NULL,
  `cleanliness` double NOT NULL DEFAULT 0,
  `accuracy` double NOT NULL DEFAULT 0,
  `communication` double NOT NULL DEFAULT 0,
  `location` double NOT NULL DEFAULT 0,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_reviews_client_id_foreign` (`client_id`),
  CONSTRAINT `client_reviews_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `contact_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `is_replied` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `note` text DEFAULT NULL,
  `owner_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned DEFAULT NULL,
  `realestate_id` bigint(20) unsigned DEFAULT NULL,
  `signed_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'client',
  PRIMARY KEY (`id`),
  KEY `contracts_owner_id_foreign` (`owner_id`),
  KEY `contracts_client_id_foreign` (`client_id`),
  KEY `contracts_realestate_id_foreign` (`realestate_id`),
  CONSTRAINT `contracts_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`),
  CONSTRAINT `contracts_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`),
  CONSTRAINT `contracts_realestate_id_foreign` FOREIGN KEY (`realestate_id`) REFERENCES `realstates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `memberOne` bigint(20) unsigned NOT NULL,
  `memberTwo` bigint(20) unsigned NOT NULL,
  `never_seen_messages` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_message_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conversations_memberone_foreign` (`memberOne`),
  KEY `conversations_membertwo_foreign` (`memberTwo`),
  KEY `conversations_last_message_id_foreign` (`last_message_id`),
  CONSTRAINT `conversations_last_message_id_foreign` FOREIGN KEY (`last_message_id`) REFERENCES `messages` (`id`),
  CONSTRAINT `conversations_memberone_foreign` FOREIGN KEY (`memberOne`) REFERENCES `users` (`id`),
  CONSTRAINT `conversations_membertwo_foreign` FOREIGN KEY (`memberTwo`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `host_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rate` double NOT NULL DEFAULT 0,
  `comment` varchar(250) NOT NULL,
  `cleanliness` double NOT NULL DEFAULT 0,
  `communication` double NOT NULL DEFAULT 0,
  `observance_house_rules` double NOT NULL DEFAULT 0,
  `host_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `host_reviews_host_id_foreign` (`host_id`),
  CONSTRAINT `host_reviews_host_id_foreign` FOREIGN KEY (`host_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`generated_conversions`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_order_column_index` (`order_column`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) unsigned NOT NULL,
  `receiver_id` bigint(20) unsigned NOT NULL,
  `text` text NOT NULL,
  `conversation_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_sender_id_foreign` (`sender_id`),
  KEY `messages_receiver_id_foreign` (`receiver_id`),
  KEY `messages_conversation_id_foreign` (`conversation_id`),
  CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`),
  CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `operation_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operation_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operation_types_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owners` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rib` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realestate_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realestate_favorites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `realestate_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `realestate_favorites_user_id_foreign` (`user_id`),
  KEY `realestate_favorites_realestate_id_foreign` (`realestate_id`),
  CONSTRAINT `realestate_favorites_realestate_id_foreign` FOREIGN KEY (`realestate_id`) REFERENCES `realstates` (`id`),
  CONSTRAINT `realestate_favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realestate_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realestate_feature` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `realstate_id` bigint(20) unsigned NOT NULL,
  `feature_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `realestate_feature_realstate_id_foreign` (`realstate_id`),
  KEY `realestate_feature_feature_id_foreign` (`feature_id`),
  CONSTRAINT `realestate_feature_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`),
  CONSTRAINT `realestate_feature_realstate_id_foreign` FOREIGN KEY (`realstate_id`) REFERENCES `realstates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realestate_rapports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realestate_rapports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  `realestate_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `realestate_rapports_realestate_id_foreign` (`realestate_id`),
  CONSTRAINT `realestate_rapports_realestate_id_foreign` FOREIGN KEY (`realestate_id`) REFERENCES `realstates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realstate_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realstate_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `realstate_categories_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realstate_etats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realstate_etats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `etat` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `realstate_etats_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realstate_review_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realstate_review_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `color` varchar(255) NOT NULL DEFAULT 'f0f0f0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `realstate_review_status_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realstate_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realstate_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `color` varchar(255) NOT NULL DEFAULT 'f0f0f0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `realstate_status_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `realstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realstates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `description` varchar(500) NOT NULL,
  `surface` int(11) NOT NULL,
  `price` double NOT NULL,
  `address` varchar(250) NOT NULL,
  `date_construction` date DEFAULT NULL,
  `nb_etage` smallint(6) DEFAULT NULL,
  `nb_rooms` smallint(6) DEFAULT NULL,
  `etage` smallint(6) DEFAULT NULL,
  `nb_bathroom` smallint(6) DEFAULT NULL,
  `rate` double NOT NULL DEFAULT 0,
  `nb_raters` int(11) NOT NULL DEFAULT 0,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `owner_id` bigint(20) unsigned DEFAULT NULL,
  `host_id` bigint(20) unsigned NOT NULL,
  `status_id` bigint(20) unsigned NOT NULL,
  `review_status_id` bigint(20) unsigned NOT NULL,
  `city_id` bigint(20) unsigned NOT NULL,
  `etat_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `tour_360_url` varchar(255) DEFAULT NULL,
  `cleaning_status` enum('cleaning','cleaned') DEFAULT NULL,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `realstates_category_id_foreign` (`category_id`),
  KEY `realstates_transaction_id_foreign` (`transaction_id`),
  KEY `realstates_owner_id_foreign` (`owner_id`),
  KEY `realstates_host_id_foreign` (`host_id`),
  KEY `realstates_status_id_foreign` (`status_id`),
  KEY `realstates_review_status_id_foreign` (`review_status_id`),
  KEY `realstates_city_id_foreign` (`city_id`),
  KEY `realstates_etat_id_foreign` (`etat_id`),
  KEY `realstates_booking_id_foreign` (`booking_id`),
  CONSTRAINT `realstates_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `realstates_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `realstate_categories` (`id`),
  CONSTRAINT `realstates_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  CONSTRAINT `realstates_etat_id_foreign` FOREIGN KEY (`etat_id`) REFERENCES `realstate_etats` (`id`),
  CONSTRAINT `realstates_host_id_foreign` FOREIGN KEY (`host_id`) REFERENCES `users` (`id`),
  CONSTRAINT `realstates_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`),
  CONSTRAINT `realstates_review_status_id_foreign` FOREIGN KEY (`review_status_id`) REFERENCES `realstate_status` (`id`),
  CONSTRAINT `realstates_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `realstate_status` (`id`),
  CONSTRAINT `realstates_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `type_transactions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `regions_country_id_foreign` (`country_id`),
  CONSTRAINT `regions_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `scheduled_charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_charges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `amount` double NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'fixed',
  `recurrence_type` varchar(255) NOT NULL,
  `recurrence_value` varchar(255) DEFAULT NULL,
  `realestate_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduled_charges_realestate_id_foreign` (`realestate_id`),
  CONSTRAINT `scheduled_charges_realestate_id_foreign` FOREIGN KEY (`realestate_id`) REFERENCES `realstates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sliders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sliders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `user_id` bigint(20) unsigned NOT NULL,
  `operation_id` bigint(20) unsigned NOT NULL,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_commission` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `transactions_user_id_foreign` (`user_id`),
  KEY `transactions_operation_id_foreign` (`operation_id`),
  KEY `transactions_booking_id_foreign` (`booking_id`),
  CONSTRAINT `transactions_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `transactions_operation_id_foreign` FOREIGN KEY (`operation_id`) REFERENCES `operation_types` (`id`),
  CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `type_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `type_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_transactions_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `color` varchar(255) NOT NULL DEFAULT 'f0f0f0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_status_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_types_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `balance` double NOT NULL DEFAULT 0,
  `tel` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `rate` double NOT NULL DEFAULT 0,
  `nb_raters` int(11) NOT NULL DEFAULT 0,
  `otp_expire_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type_id` bigint(20) unsigned NOT NULL,
  `status_id` bigint(20) unsigned DEFAULT NULL,
  `city_id` bigint(20) unsigned DEFAULT NULL,
  `host_rate` double NOT NULL DEFAULT 0,
  `host_nb_raters` int(11) NOT NULL DEFAULT 0,
  `identity_status` enum('pending','valid','invalid') NOT NULL DEFAULT 'invalid',
  `agence` tinyint(1) NOT NULL DEFAULT 0,
  `rib` varchar(255) DEFAULT NULL,
  `from_platform` tinyint(1) NOT NULL DEFAULT 1,
  `documents` varchar(255) DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_type_id_foreign` (`type_id`),
  KEY `users_status_id_foreign` (`status_id`),
  KEY `users_city_id_foreign` (`city_id`),
  CONSTRAINT `users_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  CONSTRAINT `users_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`),
  CONSTRAINT `users_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `user_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `whatsapp_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `whatsapp_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message_name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



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

LOCK TABLES `booking_statuses` WRITE;
/*!40000 ALTER TABLE `booking_statuses` DISABLE KEYS */;
INSERT INTO `booking_statuses` (`id`, `status`, `code`, `created_at`, `updated_at`, `color`) VALUES (1,'Pay�','payed','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(2,'En attente','pending','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(3,'Rejet�','rejected','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(4,'Confirm�','confirmed','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0');
/*!40000 ALTER TABLE `booking_statuses` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` (`id`, `name`, `latitude`, `longitude`, `region_id`, `created_at`, `updated_at`) VALUES (1,'Agadir',NULL,NULL,1,'2026-03-17 14:52:21','2026-03-17 14:52:21'),(2,'Tanger',NULL,NULL,2,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(3,'Tétouan',NULL,NULL,2,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(4,'Al Hoceïma',NULL,NULL,2,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(5,'Chefchaouen',NULL,NULL,2,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(6,'Larache',NULL,NULL,2,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(7,'Oujda',NULL,NULL,3,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(8,'Nador',NULL,NULL,3,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(9,'Berkane',NULL,NULL,3,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(10,'Driouch',NULL,NULL,3,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(11,'Taourirt',NULL,NULL,3,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(12,'Fès',NULL,NULL,4,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(13,'Meknès',NULL,NULL,4,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(14,'Taza',NULL,NULL,4,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(15,'Ifrane',NULL,NULL,4,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(16,'Sefrou',NULL,NULL,4,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(17,'Rabat',NULL,NULL,5,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(18,'Salé',NULL,NULL,5,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(19,'Kénitra',NULL,NULL,5,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(20,'Skhirat',NULL,NULL,5,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(21,'Témara',NULL,NULL,5,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(22,'Khémisset',NULL,NULL,5,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(23,'Béni Mellal',NULL,NULL,6,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(24,'Khénifra',NULL,NULL,6,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(25,'Azilal',NULL,NULL,6,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(26,'Fquih Ben Salah',NULL,NULL,6,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(27,'Casablanca',NULL,NULL,7,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(28,'Mohammadia',NULL,NULL,7,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(29,'El Jadida',NULL,NULL,7,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(30,'Settat',NULL,NULL,7,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(31,'Berrechid',NULL,NULL,7,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(32,'Marrakech',NULL,NULL,8,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(33,'Safi',NULL,NULL,8,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(34,'Essaouira',NULL,NULL,8,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(35,'El Kelaâ des Sraghna',NULL,NULL,8,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(36,'Errachidia',NULL,NULL,9,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(37,'Ouarzazate',NULL,NULL,9,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(38,'Midelt',NULL,NULL,9,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(39,'Zagora',NULL,NULL,9,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(40,'Inezgane',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(41,'Aït Melloul',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(42,'Tiznit',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(43,'Taroudant',NULL,NULL,1,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(44,'Guelmim',NULL,NULL,10,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(45,'Tan-Tan',NULL,NULL,10,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(46,'Sidi Ifni',NULL,NULL,10,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(47,'Laâyoune',NULL,NULL,11,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(48,'Boujdour',NULL,NULL,11,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(49,'Smara',NULL,NULL,11,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(50,'Dakhla',NULL,NULL,12,'2026-03-24 13:29:17','2026-03-24 13:29:17');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` (`id`, `name`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (1,'Maroc',NULL,NULL,'2026-03-17 14:52:21','2026-03-17 14:52:21');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` (`id`, `name`, `description`, `icon`, `created_at`, `updated_at`) VALUES (1,'Wi-Fi','Connexion internet haut débit',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(2,'Climatisation','Air conditionné',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(3,'Ascenseur','Accès par ascenseur',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(4,'Parking','Place de stationnement',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(5,'Piscine','Accès à une piscine',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(6,'Cuisine équipée','Cuisine avec électroménager',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(7,'Terrasse','Espace extérieur privé',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(8,'Vue sur mer','Vue panoramique sur la mer',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(9,'Gardiennage','Sécurité 24h/24',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(10,'Meublé','Logement entièrement meublé',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(11,'Chauffage','Chauffage central ou individuel',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04'),(12,'Balcon','Petit espace extérieur',NULL,'2026-03-24 14:45:04','2026-03-24 14:45:04');
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'1025_03_10_133253_create_countries_table',1),(5,'1025_03_10_133332_create_regions_table',1),(6,'1025_03_10_133339_create_cities_table',1),(7,'2025_02_23_163130_create_user_types_table',1),(8,'2025_02_23_163208_create_user_statuses_table',1),(9,'2025_02_23_163627_add_users_relations',1),(10,'2025_03_05_233303_create_personal_access_tokens_table',1),(11,'2025_03_07_003340_create_realstate_review_statuses_table',1),(12,'2025_03_07_003422_create_realstate_statuses_table',1),(13,'2025_03_07_003514_create_realstate_categories_table',1),(14,'2025_03_07_003911_create_type_transactions_table',1),(15,'2025_03_07_004043_create_owners_table',1),(16,'2025_03_07_004846_create_realstate_etats_table',1),(17,'2025_03_07_005012_create_features_table',1),(18,'2025_03_07_005615_create_realstates_table',1),(19,'2025_03_09_230533_create_media_table',1),(20,'2025_03_12_230207_create_realestate_feature_table',1),(21,'2025_05_01_200339_create_sliders_table',1),(22,'2025_05_13_203339_create_client_reviews_table',1),(23,'2025_05_13_203351_create_host_reviews_table',1),(24,'2025_05_18_182001_create_booking_statuses_table',1),(25,'2025_05_18_182016_create_payment_methods_table',1),(26,'2025_05_18_182126_create_bookings_table',1),(27,'2025_07_12_211111_add_is_delete_to_realstate',1),(28,'2025_07_15_234637_update_users_table',1),(29,'2025_07_19_003826_create_realestate_favorites_table',1),(30,'2025_07_19_202904_create_contact_messages_table',1),(31,'2025_07_22_112512_update_realestate_table',1),(32,'2025_07_22_113931_update_users_table',1),(33,'2025_07_22_224000_create_operation_types_table',1),(34,'2025_07_22_224108_create_transactions_table',1),(35,'2025_07_22_230709_update_booking_table',1),(36,'2025_07_22_231613_create_app_params_table',1),(37,'2025_07_29_154129_add_is_cron_pass_bookings_table',1),(38,'2025_07_29_181824_add_is_commission_transactions_table',1),(39,'2025_08_11_221446_create_conversations_table',1),(40,'2025_08_11_221448_create_messages_table',1),(41,'2025_08_11_222551_add_last_message_column_conversations_table',1),(42,'2025_09_15_230603_create_managers_table',1),(43,'2025_09_16_001058_create_permission_tables',1),(44,'2025_09_17_205413_create_type_bookings_table',1),(45,'2025_09_17_211320_add_type_to_bookings_table',1),(46,'2025_09_17_230301_add_from_platform_users_table',1),(47,'2025_09_18_093329_create_realestate_contracts_table',1),(48,'2025_09_18_164331_create_charges_table',1),(49,'2025_09_23_160545_add_color_to_status_tables',1),(50,'2025_10_28_190614_add_column_sliders_table',1),(51,'2025_11_20_021047_add_rib_to_owners_table',1),(52,'2025_11_22_005544_create_realestate_rapports_table',1),(53,'2025_12_16_150208_add_cleaning_status_to_realestate',1),(54,'2025_12_17_150900_add_documents_to_users',1),(55,'2026_01_03_234820_add_booking_column_to_realstates',1),(56,'2026_01_06_161303_add_column_to_bookings',1),(57,'2026_01_06_161327_add_tel_column_to_managers',1),(58,'2026_01_08_232447_create_whatsapp_messages_table',1),(59,'2026_01_09_011208_add_country_code_users',1),(60,'2026_01_17_031909_add_type_guest_to_bookings',1),(61,'2026_01_28_014102_add_soft_deleted_to_managers',1),(62,'2026_03_25_133400_update_type_guest_on_bookings_table',2),(63,'2026_03_30_141700_update_charges_table',3),(64,'2026_03_30_141800_create_scheduled_charges_table',3),(65,'2026_03_30_141900_add_status_and_type_to_charges_table',4),(66,'2026_03_30_142000_add_type_to_scheduled_charges_table',4),(67,'2026_04_01_143421_add_price_and_type_to_contracts_table',5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `operation_types` WRITE;
/*!40000 ALTER TABLE `operation_types` DISABLE KEYS */;
INSERT INTO `operation_types` (`id`, `type`, `code`, `created_at`, `updated_at`) VALUES (1,'Transfert','transfert','2026-03-17 14:51:18','2026-03-17 14:51:18');
/*!40000 ALTER TABLE `operation_types` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES (1,'create_property','managers','2026-03-17 12:45:30','2026-03-17 13:17:34'),(2,'update_property','managers','2026-03-17 12:45:30','2026-03-17 13:17:34'),(3,'create_reservation','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(4,'extend_reservation','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(5,'reduce_reservation','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(6,'confirm_checkout','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(7,'confirm_checkin','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(8,'view_reservations','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(9,'create_owner','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(10,'update_owner','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(11,'view_owners','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(12,'finish_cleaning','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(13,'create_charge','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(14,'view_charges','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(15,'create_client','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(16,'update_client','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(17,'view_clients','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(18,'view_users','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(19,'create_user','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(20,'view_available_properties','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(21,'view_reserved_properties','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(22,'view_cleaning_properties','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(23,'view_today_checkouts','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(24,'view_reports','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(25,'create_report','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(26,'view_reclamations','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(27,'create_reclamation','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(28,'close_reclamation','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(29,'view_slider','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(30,'create_slider','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(31,'activate_slider','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(32,'activate_announce','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(33,'cancel_announce','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(34,'view_stats','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(35,'view_contract','managers','2026-03-17 12:45:30','2026-03-17 13:17:35'),(36,'create_contract','managers','2026-03-17 12:45:30','2026-03-17 13:17:35');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `realstate_categories` WRITE;
/*!40000 ALTER TABLE `realstate_categories` DISABLE KEYS */;
INSERT INTO `realstate_categories` (`id`, `category`, `code`, `created_at`, `updated_at`) VALUES (1,'Appartement','apartment','2026-03-17 14:51:18','2026-03-17 14:51:18'),(2,'Villa','villa','2026-03-17 14:51:18','2026-03-17 14:51:18'),(3,'Studio','studio','2026-03-17 14:51:18','2026-03-17 14:51:18'),(4,'Locaux commerciaux','commercial','2026-03-17 14:51:18','2026-03-24 13:29:16'),(5,'Appartements','apartments','2026-03-24 13:29:16','2026-03-24 13:29:16'),(6,'Maisons','houses','2026-03-24 13:29:16','2026-03-24 13:29:16'),(7,'Villas & maisons de luxe','villas','2026-03-24 13:29:16','2026-03-24 13:29:16'),(8,'Riad','riad','2026-03-24 13:29:16','2026-03-24 13:29:16'),(9,'Bureaux','offices','2026-03-24 13:29:16','2026-03-24 13:29:16'),(10,'Terrains','land','2026-03-24 13:29:16','2026-03-24 13:29:16'),(11,'Fermes','farms','2026-03-24 13:29:16','2026-03-24 13:29:16');
/*!40000 ALTER TABLE `realstate_categories` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `realstate_etats` WRITE;
/*!40000 ALTER TABLE `realstate_etats` DISABLE KEYS */;
INSERT INTO `realstate_etats` (`id`, `etat`, `code`, `created_at`, `updated_at`) VALUES (1,'Neuf','new','2026-03-17 14:51:18','2026-03-17 14:51:18'),(2,'Bon état','good','2026-03-17 14:51:18','2026-03-17 14:51:18'),(3,'A rénover','to-renovate','2026-03-17 14:51:18','2026-03-17 14:51:18');
/*!40000 ALTER TABLE `realstate_etats` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `realstate_review_status` WRITE;
/*!40000 ALTER TABLE `realstate_review_status` DISABLE KEYS */;
INSERT INTO `realstate_review_status` (`id`, `status`, `code`, `created_at`, `updated_at`, `color`) VALUES (1,'Légal','legal','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(2,'Illégal','illegal','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(3,'En cours','in-review','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0');
/*!40000 ALTER TABLE `realstate_review_status` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `realstate_status` WRITE;
/*!40000 ALTER TABLE `realstate_status` DISABLE KEYS */;
INSERT INTO `realstate_status` (`id`, `status`, `code`, `created_at`, `updated_at`, `color`) VALUES (1,'Actif','active','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(2,'En attente','pending','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(3,'En pause','paused','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0');
/*!40000 ALTER TABLE `realstate_status` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` (`id`, `name`, `latitude`, `longitude`, `country_id`, `created_at`, `updated_at`) VALUES (1,'Souss-Massa',NULL,NULL,1,'2026-03-17 14:52:21','2026-03-17 14:52:21'),(2,'Tanger-Tétouan-Al Hoceïma',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(3,'L\'Oriental',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(4,'Fès-Meknès',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(5,'Rabat-Salé-Kénitra',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(6,'Béni Mellal-Khénifra',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(7,'Casablanca-Settat',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(8,'Marrakech-Safi',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(9,'Drâa-Tafilalet',NULL,NULL,1,'2026-03-24 13:29:16','2026-03-24 13:29:16'),(10,'Guelmim-Oued Noun',NULL,NULL,1,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(11,'Laâyoune-Sakia El Hamra',NULL,NULL,1,'2026-03-24 13:29:17','2026-03-24 13:29:17'),(12,'Dakhla-Oued Ed-Dahab',NULL,NULL,1,'2026-03-24 13:29:17','2026-03-24 13:29:17');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES (1,'super-admin','managers','2026-03-17 12:45:31','2026-03-17 12:45:31'),(2,'admin','managers','2026-03-25 12:46:05','2026-03-25 12:46:05');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `sliders` WRITE;
/*!40000 ALTER TABLE `sliders` DISABLE KEYS */;
INSERT INTO `sliders` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES (1,'yassine','yassine Ait El haroich',1,'2026-04-02 13:49:16','2026-04-27 10:30:59'),(2,'slide test','I am testing slide',0,'2026-04-23 10:41:21','2026-04-27 10:30:59');
/*!40000 ALTER TABLE `sliders` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `type_bookings` WRITE;
/*!40000 ALTER TABLE `type_bookings` DISABLE KEYS */;
INSERT INTO `type_bookings` (`id`, `type`, `code`, `created_at`, `updated_at`) VALUES (1,'Realworld','realworld','2026-03-25 12:24:22','2026-03-25 12:24:22'),(2,'Platform','platform','2026-04-16 11:23:26','2026-04-16 11:23:26');
/*!40000 ALTER TABLE `type_bookings` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `type_transactions` WRITE;
/*!40000 ALTER TABLE `type_transactions` DISABLE KEYS */;
INSERT INTO `type_transactions` (`id`, `type`, `code`, `created_at`, `updated_at`) VALUES (1,'Vente','sale','2026-03-17 14:51:18','2026-03-17 14:51:18'),(2,'Location','rent','2026-03-17 14:51:18','2026-03-17 14:51:18'),(3,'Location vacances','vacation_rental','2026-03-24 13:29:16','2026-03-24 13:29:16');
/*!40000 ALTER TABLE `type_transactions` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` (`id`, `status`, `code`, `created_at`, `updated_at`, `color`) VALUES (1,'Actif','active','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0'),(2,'Inactif','inactive','2026-03-17 14:51:18','2026-03-17 14:51:18','f0f0f0');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `user_types` WRITE;
/*!40000 ALTER TABLE `user_types` DISABLE KEYS */;
INSERT INTO `user_types` (`id`, `type`, `code`, `created_at`, `updated_at`) VALUES (1,'Client','client','2026-03-17 14:51:17','2026-03-17 14:51:17'),(2,'Hôte','host','2026-03-17 14:51:17','2026-03-17 14:51:17');
/*!40000 ALTER TABLE `user_types` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

