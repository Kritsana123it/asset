-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2025 at 09:39 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_asset`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL,
  `asset_code` varchar(50) NOT NULL,
  `asset_name` varchar(255) NOT NULL,
  `category_id` varchar(100) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`asset_id`, `asset_code`, `asset_name`, `category_id`, `purchase_date`, `price`, `image`, `created_at`) VALUES
(1, 'EQ001', 'คอมพิวเตอร์ All-in-One Dell', 'อุปกรณ์คอมพิวเตอร์', '2024-01-15', '25000.00', 'asset_1763711563_69201a4b3f86c.jpg', '2025-11-21 07:48:36'),
(2, 'EQ002', 'เครื่องพิมพ์เลเซอร์ HP LaserJet', 'อุปกรณ์สำนักงาน', '2024-02-20', '8500.00', 'asset_1763711740_69201afc5f15b.jpg', '2025-11-21 07:48:36'),
(3, 'EQ003', 'โน้ตบุ๊ค Lenovo ThinkPad', 'อุปกรณ์คอมพิวเตอร์', '2024-03-10', '32000.00', 'asset_1763711650_69201aa233f87.png', '2025-11-21 07:48:36'),
(4, 'EQ004', 'เครื่องปรับอากาศ Daikin 18000 BTU', 'เครื่องใช้ไฟฟ้า', '2024-01-05', '18900.00', 'asset_1763711964_69201bdc28c0e.png', '2025-11-21 07:48:36'),
(5, 'EQ005', 'โต๊ะทำงาน 120x60 ซม.', 'เฟอร์นิเจอร์', '2024-02-15', '3500.00', 'asset_1763712098_69201c625181c.jpg', '2025-11-21 07:48:36'),
(6, 'EQ006', 'เก้าอี้สำนักงาน Ergonomic', 'เฟอร์นิเจอร์', '2024-02-15', '4200.00', 'asset_1763712108_69201c6cad61f.jpg', '2025-11-21 07:48:36'),
(7, 'EQ007', 'เครื่องสแกนเนอร์ Canon', 'อุปกรณ์สำนักงาน', '2024-03-01', '6500.00', 'asset_1763711763_69201b13362de.png', '2025-11-21 07:48:36'),
(8, 'EQ008', 'จอคอมพิวเตอร์ 27 นิ้ว LG', 'อุปกรณ์คอมพิวเตอร์', '2024-01-20', '7800.00', 'asset_1763711659_69201aabebfef.jpg', '2025-11-21 07:48:36'),
(9, 'EQ009', 'เครื่องถ่ายเอกสาร Xerox', 'อุปกรณ์สำนักงาน', '2024-02-10', '45000.00', 'asset_1763711776_69201b2094762.jpg', '2025-11-21 07:48:36'),
(10, 'EQ010', 'ตู้เก็บเอกสาร 4 ลิ้นชัก', 'เฟอร์นิเจอร์', '2024-01-25', '5500.00', 'asset_1763712117_69201c75241f3.png', '2025-11-21 07:48:36'),
(11, 'EQ011', 'เครื่องคอมพิวเตอร์ PC ประกอบ', 'อุปกรณ์คอมพิวเตอร์', '2024-03-15', '22000.00', 'asset_1763711673_69201ab9a5575.jpg', '2025-11-21 07:48:36'),
(12, 'EQ012', 'เครื่องฉายโปรเจคเตอร์', 'อุปกรณ์สำนักงาน', '2024-02-28', '15000.00', 'asset_1763711799_69201b37458d1.jfif', '2025-11-21 07:48:36'),
(13, 'EQ013', 'เครื่องปั๊มน้ำ', 'เครื่องใช้ไฟฟ้า', '2024-01-10', '4800.00', 'asset_1763711970_69201be2e97db.jpg', '2025-11-21 07:48:36'),
(14, 'EQ014', 'โทรศัพท์สำนักงาน Panasonic', 'อุปกรณ์สำนักงาน', '2024-03-05', '2500.00', 'asset_1763711808_69201b40be93e.jpg', '2025-11-21 07:48:36'),
(15, 'EQ015', 'เครื่องทำลายเอกสาร', 'อุปกรณ์สำนักงาน', '2024-02-25', '3200.00', 'asset_1763711847_69201b6700fa0.jfif', '2025-11-21 07:48:36'),
(16, 'EQ016', 'UPS สำรองไฟ 1000VA', 'อุปกรณ์คอมพิวเตอร์', '2024-03-12', '4500.00', 'asset_1763711681_69201ac1d85fa.jpg', '2025-11-21 07:48:36'),
(17, 'EQ017', 'พัดลมอุตสาหกรรม 24 นิ้ว', 'เครื่องใช้ไฟฟ้า', '2024-01-18', '3800.00', 'asset_1763711981_69201bed9be83.jpg', '2025-11-21 07:48:36'),
(18, 'EQ018', 'ตู้แช่น้ำ', 'เครื่องใช้ไฟฟ้า', '2024-02-05', '12500.00', 'asset_1763711989_69201bf564fde.jpg', '2025-11-21 07:48:36'),
(19, 'EQ019', 'โต๊ะประชุม 8 ที่นั่ง', 'เฟอร์นิเจอร์', '2024-01-30', '18000.00', 'asset_1763712127_69201c7f16e66.jpg', '2025-11-21 07:48:36'),
(20, 'EQ020', 'กล้อง CCTV ชุด 4 ตัว', 'อื่นๆ', '2024-03-08', '9500.00', 'asset_1763712159_69201c9f6b2cd.jfif', '2025-11-21 07:48:36'),
(23, 'EQ077', 'Test', 'อื่นๆ', '2025-11-07', '10000000.00', 'asset_1763712892_69201f7c1e024.jfif', '2025-11-21 08:14:52');

-- --------------------------------------------------------

--
-- Table structure for table `asset_categories`
--

CREATE TABLE `asset_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `firstName`, `lastName`, `phone`, `username`, `password`) VALUES
(0, 'one', 'onew', '1', 'one', '$2y$10$FWNBJavDvVqOuNQfS6SscOdZzgEVYM3ywnDxZjFYf5LPoVUdnOC/i');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`asset_id`);

--
-- Indexes for table `asset_categories`
--
ALTER TABLE `asset_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `asset_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `asset_categories`
--
ALTER TABLE `asset_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
