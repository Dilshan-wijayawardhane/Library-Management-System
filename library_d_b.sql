-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2026 at 08:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_d_b`
--

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `book_id` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `borrowed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`book_id`, `title`, `author`, `borrowed`) VALUES
('B001', 'English', 'Mr.Amal Gunadasa', 0),
('B002', 'Tamil', 'Mr.Gunadaram', 0),
('B007', 'Maths', 'Mr.Chinthaka', 0),
('B010', 'CINEC', 'Mr.Naveen', 0),
('B012', 'Database Part1', 'Mr.Namal', 0),
('B013', 'OOP Part1', 'Mr.Namal', 0);

-- --------------------------------------------------------

--
-- Table structure for table `borrowrecord`
--

CREATE TABLE `borrowrecord` (
  `record_id` int(11) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `item_id` varchar(20) NOT NULL,
  `borrow_date` date NOT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowrecord`
--

INSERT INTO `borrowrecord` (`record_id`, `user_id`, `item_id`, `borrow_date`, `return_date`) VALUES
(18, 'U002', 'LI002', '2026-01-08', '2026-01-08'),
(19, 'U002', 'LI002', '2026-01-08', '2026-01-08'),
(20, 'U002', 'LI002', '2026-01-08', '2026-01-08'),
(21, 'U002', 'LI008', '2026-01-09', '2026-01-09'),
(22, 'U004', 'LI013', '2026-01-10', '2026-01-10'),
(23, 'U004', 'LI013', '2026-01-10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `libraryitem`
--

CREATE TABLE `libraryitem` (
  `item_id` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `borrowed` tinyint(1) DEFAULT 0,
  `type` varchar(50) NOT NULL,
  `author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `libraryitem`
--

INSERT INTO `libraryitem` (`item_id`, `title`, `borrowed`, `type`, `author`) VALUES
('LI002', 'Tamil', 0, 'Book', 'Mr.Gunadaram'),
('LI003', 'Sri Lanka', 0, 'Magazine', 'Mr.Pawan Silva'),
('LI004', 'Phython Concepts', 0, 'Book', 'Mrs.Pawani Gunadasa'),
('LI005', 'Sinhala song', 0, 'CD', 'Mr.Gunadasa Kapuge'),
('LI007', 'Maths', 0, 'Book', 'Mr.Chinthaka'),
('LI008', 'Daily', 0, 'Newspaper', 'Mr.Navan'),
('LI010', 'CINEC', 0, 'Book', 'Mr.Naveen'),
('LI011', 'Spyder Man', 0, 'CD', 'Mr.Sunil'),
('LI012', 'Database Part1', 0, 'Book', 'Mr.Namal'),
('LI013', 'OOP Part1', 1, 'Book', 'Mr.Namal');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` varchar(20) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `role`) VALUES
('U001', 'admin', 'admin1234#', 'ADMIN'),
('U002', 'Malan234', 'malan34##', 'STAFF'),
('U003', 'prasadi123', 'pmasd623#', 'LECTURER'),
('U004', 'admin_updated', 'newpass', 'ADMIN'),
('U006', 'dilshan123', 'dilshan123##', 'LECTURER');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `borrowrecord`
--
ALTER TABLE `borrowrecord`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `libraryitem`
--
ALTER TABLE `libraryitem`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `borrowrecord`
--
ALTER TABLE `borrowrecord`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrowrecord`
--
ALTER TABLE `borrowrecord`
  ADD CONSTRAINT `borrowrecord_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `borrowrecord_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `libraryitem` (`item_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
