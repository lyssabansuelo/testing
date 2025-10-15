-- Schema for drugstore app

CREATE DATABASE IF NOT EXISTS `drugstore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `drugstore`;

-- Users
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('admin','member') NOT NULL DEFAULT 'member',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Products
CREATE TABLE IF NOT EXISTS `products` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `medicineId` VARCHAR(100) NOT NULL UNIQUE,
  `supplierName` VARCHAR(255) NOT NULL,
  `medicineName` VARCHAR(255) DEFAULT NULL,
  `genericName` VARCHAR(255) NOT NULL,
  `brandName` VARCHAR(255) NOT NULL,
  `category` VARCHAR(150) NOT NULL,
  `description` TEXT,
  `form` VARCHAR(100) DEFAULT NULL,
  `strength` VARCHAR(100) DEFAULT NULL,
  `unit` VARCHAR(50) DEFAULT NULL,
  `reorderLevel` INT DEFAULT 0,
  `price` DECIMAL(10,2) NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `deliveryDate` DATE NOT NULL,
  `imageUrl` VARCHAR(500) DEFAULT NULL,
  `barcode` VARCHAR(150) NOT NULL UNIQUE,
  PRIMARY KEY (`id`),
  INDEX (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Receipts
CREATE TABLE IF NOT EXISTS `receipts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(255) DEFAULT NULL,
  `customer_address` VARCHAR(255) DEFAULT NULL,
  `customer_tin` VARCHAR(50) DEFAULT NULL,
  `total_price` DECIMAL(12,2) NOT NULL,
  `discount_percent` DECIMAL(5,2) DEFAULT 0.00,
  `discount_amount` DECIMAL(12,2) DEFAULT 0.00,
  `net_pay` DECIMAL(12,2) NOT NULL,
  `cash_given` DECIMAL(12,2) DEFAULT 0.00,
  `change_amount` DECIMAL(12,2) DEFAULT 0.00,
  `payment_method` VARCHAR(50) DEFAULT 'cash',
  `vatable_sale` DECIMAL(12,2) DEFAULT 0.00,
  `vat_amount` DECIMAL(12,2) DEFAULT 0.00,
  `transaction_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Receipt Items
CREATE TABLE IF NOT EXISTS `receipt_items` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `receipt_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `product_name` VARCHAR(255) NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_receipt` (`receipt_id`),
  KEY `idx_product` (`product_id`),
  CONSTRAINT `fk_receipt_items_receipt` FOREIGN KEY (`receipt_id`) REFERENCES `receipts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_receipt_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
