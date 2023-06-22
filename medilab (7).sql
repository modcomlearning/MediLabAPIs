-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 21, 2023 at 10:25 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medilab`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `phone` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `book_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `booked_for` varchar(100) NOT NULL,
  `dependant_id` int(11) DEFAULT NULL,
  `test_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `where_taken` text NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `lab_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`book_id`, `member_id`, `booked_for`, `dependant_id`, `test_id`, `appointment_date`, `appointment_time`, `where_taken`, `reg_date`, `latitude`, `longitude`, `status`, `lab_id`, `invoice_no`) VALUES
(3, 4, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-12 09:14:58', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(4, 4, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-12 09:24:37', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(5, 4, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-13 07:21:59', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(6, 4, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-13 07:22:55', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(7, 4, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-13 07:23:30', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(8, 4, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-13 07:33:20', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(9, 4, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-13 07:35:29', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(10, 5, 'Dependant', 4, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-19 07:48:41', '1.456789', '32.3456789o', 'Pending', 1, '5454545');

-- --------------------------------------------------------

--
-- Table structure for table `dependants`
--

CREATE TABLE `dependants` (
  `dependant_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `surname` text NOT NULL,
  `others` text NOT NULL,
  `dob` date NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dependants`
--

INSERT INTO `dependants` (`dependant_id`, `member_id`, `surname`, `others`, `dob`, `reg_date`) VALUES
(4, 4, 'alex', 'Doe', '2000-08-05', '2023-06-08 07:25:41'),
(5, 4, 'Joy', 'Doe', '1990-08-05', '2023-06-08 07:29:29'),
(6, 4, 'Eric', 'Doe', '1980-08-05', '2023-06-08 07:29:46'),
(7, 5, 'Tom', 'Glen', '1980-08-05', '2023-06-08 07:50:37'),
(8, 5, 'Alice', 'Glen', '1980-08-05', '2023-06-08 07:50:46'),
(9, 4, 'Jonah', 'Griffith', '1988-08-05', '2023-06-10 14:55:57'),
(10, 4, 'Alen', 'Griffith', '1988-08-05', '2023-06-10 15:55:50');

-- --------------------------------------------------------

--
-- Table structure for table `laboratories`
--

CREATE TABLE `laboratories` (
  `lab_id` int(11) NOT NULL,
  `lab_name` text NOT NULL,
  `permit_id` varchar(100) DEFAULT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `laboratories`
--

INSERT INTO `laboratories` (`lab_id`, `lab_name`, `permit_id`, `email`, `phone`, `password`, `role`, `reg_date`) VALUES
(1, 'Lancet Labs Kenya', '454545454', 'lancet@lancet.org', '0729225710', '123456', 'admin', '2023-05-31 09:08:17'),
(2, 'MedPath', 'dfds435435', 'medi@gmail.com', '7867867', '76867867867', 'admin', '2023-06-12 07:44:38'),
(3, 'MediHeal Lab', 'TTT666', 'mediheal@gmail.com', 'gAAAAABkirkdtK5r3oJ3EAxmYR7ex_HjtQi1-KkUknwnLkolHZbOWNg2oT2KwX1oSri4zXt5RV9L4UziVUSMxoYvtYrL24PcIA==', '$2b$12$TU9jWD7VZEkfs0fYz7CNnOfuYtmmc9z9bsAYxn1boBr6AQpQiCWM6', 'admin', '2023-06-15 07:09:17');

-- --------------------------------------------------------

--
-- Table structure for table `lab_tests`
--

CREATE TABLE `lab_tests` (
  `test_id` int(11) NOT NULL,
  `lab_id` int(11) NOT NULL,
  `test_name` text NOT NULL,
  `test_description` text NOT NULL,
  `test_cost` int(11) NOT NULL,
  `test_discount` int(11) NOT NULL,
  `availability` text NOT NULL,
  `more_info` varchar(100) DEFAULT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lab_tests`
--

INSERT INTO `lab_tests` (`test_id`, `lab_id`, `test_name`, `test_description`, `test_cost`, `test_discount`, `availability`, `more_info`, `reg_date`) VALUES
(1, 1, 'Covid 19 Test', 'This is a sample test', 350, 10, '', NULL, '2023-05-31 08:08:30'),
(2, 1, 'Example test 2', 'This is a test example', 1200, 15, '', NULL, '2023-06-12 06:47:40'),
(3, 2, 'Example Test 5', 'This an example test', 8, 10, '', NULL, '2023-06-12 06:48:42'),
(4, 3, 'Full Metabolic test', 'This i a nice test', 850, 10, 'Available', 'N/A', '2023-06-15 09:13:29'),
(5, 3, 'Blood Count test', 'This is a nice test', 500, 5, 'Available', 'N/A', '2023-06-15 09:13:56'),
(7, 2, 'Blood Count test', 'This is a nice test', 700, 0, 'Available', 'N/A', '2023-06-15 09:15:02');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL,
  `location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`location_id`, `location`) VALUES
(1, 'Nairobi'),
(2, 'Nakuru');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` int(11) NOT NULL,
  `surname` text NOT NULL,
  `others` text NOT NULL,
  `gender` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `dob` date NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `password` varchar(100) NOT NULL,
  `location_id` int(11) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`member_id`, `surname`, `others`, `gender`, `email`, `phone`, `dob`, `status`, `password`, `location_id`, `reg_date`) VALUES
(3, 'Jane', 'Doe', 'Female', 'gAAAAABkgDdTRBAsOqUVgtPEtfaLao6JxYzy034uwiUyAh1OtBE_XLKJmnz-EIc_0Yu2uSIM5UtlU4Y2bB4qeaAPM0EFtYTs5g==', 'gAAAAABkgDdTDapvDzkdIdpb8sn7JahYFxYq1kbRXR5ehw9VYx0NDcD4vlOUXn1or5EVFFC-_a0z84G68oNnsjc8VRToR1BkIA==', '2000-08-05', 1, '$2b$12$urbBQMaUmlVZ/19FAjhpgujnotT1T.Gn3yunVm6Oa1iiP3Izyri0S', 1, '2023-06-07 07:52:51'),
(4, 'alex', 'Doe', 'Female', 'gAAAAABkgEtE_uOHLLko1hulYkizV2uBUEsNA60dN5Mo1L9rueUzPOgT5r-mhaT_DvZBx87vNGaAncHzLkEpeHhA7J4wbBb-0Q==', 'gAAAAABkgEtEhZy_F7Rk6iqBEtmAxPB9nah9lEKkFiS4CXvDky7psTKi1339jLIF41THA5k1hs_NypRGWp2_Z8Lq3mRPRb0RAA==', '2000-08-05', 1, '$2b$12$yNrJe/w32J9.rUKSiQEsxO.w6pYAOcgWHiWqlDiORdBQKCXLojrSe', 1, '2023-06-07 09:17:57'),
(5, 'Glen', 'Doe', 'Female', 'gAAAAABkgYgc-vDzoAlC4GOqhv7-b54jh5jevbTy4-FwisRx1aAu-vYWSDeHhUSGdStoZixsAwVS5XMWzEDeve_tPMDNkNTdHQ==', 'gAAAAABkgYgcdMSoyiuc7o6B1srd1Qh0-nQPvf446GmEirRhxsU76HFs6DjmgoHw68_JFH0FxmtO6D4WXf6cCga2gKiM8W0w9A==', '2000-08-05', 1, '$2b$12$.asbTpAPyjD.sgHKant0Jez22It4cEaLTuxG3WC2bf7tbJxbN2N9e', 1, '2023-06-08 07:49:49');

-- --------------------------------------------------------

--
-- Table structure for table `nurses`
--

CREATE TABLE `nurses` (
  `nurse_id` int(11) NOT NULL,
  `surname` text NOT NULL,
  `others` text NOT NULL,
  `lab_id` int(11) NOT NULL,
  `gender` text NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurses`
--

INSERT INTO `nurses` (`nurse_id`, `surname`, `others`, `lab_id`, `gender`, `reg_date`, `email`, `phone`, `password`) VALUES
(1, 'Jackline', 'Boss', 1, 'Female', '2023-05-31 09:15:55', '', '', ''),
(2, 'Jacob', 'Johnaon', 1, 'Male', '2023-05-31 09:16:17', '', '', ''),
(3, 'clare', 'Johnson', 1, 'female', '2023-06-19 08:43:05', 'clare@gmail.com', 'gAAAAABkkBUZpJ4mWlcd3nVntaaSXCBPFIh_5rUkqUi6on1zXjbRhxHp1ZnbOfGAtKXOsx-tVwrV2oSUs1t0wOxed9A9tXL9Bg==', '$2b$12$55pTUC9yR1blyBPH8dMUOuiaLPkq2jrCSMICpm7i/jLhKDhe2F.JW'),
(4, 'Tom', 'Johnson', 1, 'male', '2023-06-19 08:46:01', 'tom@gmail.com', 'gAAAAABkkBXJNGyT4a1GNzaf-sxBtS4tDl9eMzSvFQ8bZpZFyLY3j6w_B1VH-vYJlhvLkiNsU0sx0J2R97zg9nLR0FWaiY4Khg==', '$2b$12$qeTp1M/v6aqyRsyUQku7QOSMuIqbPr8RC6byHoQqsyokbRTu47kDW'),
(5, 'Kim', 'Johnson', 1, 'male', '2023-06-20 08:20:34', 'kim@gmail.com', 'gAAAAABkkWFSen1w1xuagOsnAEvdmYIERtb8LIxFunkyhBPq-vsYqNtkNGEmE2PtWz_fTwcQVRfjlkAbWqlJRi451jl66X9Afg==', '$2b$12$/yNcJcd8WXISD6M.eX2ZYeVtg8xnfvLiPLplMfPMoRA5z1gT6X2zK'),
(6, 'Kim100', 'Johnson', 1, 'male', '2023-06-21 06:56:25', 'kim100@gmail.com', 'gAAAAABkkp8ZLd0Tq7Atk3HFYysKfz1TzX4FRZQErjEwEYxc21VFbFYj4AmLhfFxG3fd0-A_wVd1j2ZGdnN2PlWpIAsBZu0c2g==', '$2b$12$duGTMPkk9utCuAR8vklfBOf/zcBD75DjSyeRft87xc28aVsXmmqNa');

-- --------------------------------------------------------

--
-- Table structure for table `nurse_lab_allocations`
--

CREATE TABLE `nurse_lab_allocations` (
  `allocation_id` int(11) NOT NULL,
  `nurse_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `flag` varchar(50) NOT NULL DEFAULT 'active',
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurse_lab_allocations`
--

INSERT INTO `nurse_lab_allocations` (`allocation_id`, `nurse_id`, `invoice_no`, `flag`, `reg_date`) VALUES
(7, 1, '5454545', 'active', '2023-06-20 08:05:02');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `bookings_fk0` (`member_id`),
  ADD KEY `bookings_fk1` (`dependant_id`),
  ADD KEY `bookings_fk2` (`test_id`),
  ADD KEY `bookings_fk33` (`lab_id`),
  ADD KEY `invoice_no` (`invoice_no`);

--
-- Indexes for table `dependants`
--
ALTER TABLE `dependants`
  ADD PRIMARY KEY (`dependant_id`),
  ADD KEY `dependants_fk0` (`member_id`);

--
-- Indexes for table `laboratories`
--
ALTER TABLE `laboratories`
  ADD PRIMARY KEY (`lab_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD PRIMARY KEY (`test_id`),
  ADD KEY `lab_tests_fk0` (`lab_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`),
  ADD KEY `members_fk0` (`location_id`);

--
-- Indexes for table `nurses`
--
ALTER TABLE `nurses`
  ADD PRIMARY KEY (`nurse_id`),
  ADD UNIQUE KEY `surname` (`surname`) USING HASH,
  ADD KEY `nurses_fk0` (`lab_id`);

--
-- Indexes for table `nurse_lab_allocations`
--
ALTER TABLE `nurse_lab_allocations`
  ADD PRIMARY KEY (`allocation_id`),
  ADD KEY `nurse_id` (`nurse_id`),
  ADD KEY `invoice_no` (`invoice_no`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `invoice_no` (`invoice_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `dependants`
--
ALTER TABLE `dependants`
  MODIFY `dependant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `laboratories`
--
ALTER TABLE `laboratories`
  MODIFY `lab_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lab_tests`
--
ALTER TABLE `lab_tests`
  MODIFY `test_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nurses`
--
ALTER TABLE `nurses`
  MODIFY `nurse_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `nurse_lab_allocations`
--
ALTER TABLE `nurse_lab_allocations`
  MODIFY `allocation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_fk0` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  ADD CONSTRAINT `bookings_fk1` FOREIGN KEY (`dependant_id`) REFERENCES `dependants` (`dependant_id`),
  ADD CONSTRAINT `bookings_fk2` FOREIGN KEY (`test_id`) REFERENCES `lab_tests` (`test_id`),
  ADD CONSTRAINT `bookings_fk3` FOREIGN KEY (`lab_id`) REFERENCES `laboratories` (`lab_id`);

--
-- Constraints for table `dependants`
--
ALTER TABLE `dependants`
  ADD CONSTRAINT `dependants_fk0` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`);

--
-- Constraints for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD CONSTRAINT `lab_tests_fk0` FOREIGN KEY (`lab_id`) REFERENCES `laboratories` (`lab_id`);

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_fk0` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`);

--
-- Constraints for table `nurses`
--
ALTER TABLE `nurses`
  ADD CONSTRAINT `nurses_fk0` FOREIGN KEY (`lab_id`) REFERENCES `laboratories` (`lab_id`);

--
-- Constraints for table `nurse_lab_allocations`
--
ALTER TABLE `nurse_lab_allocations`
  ADD CONSTRAINT `nurse_lab_allocations_fk0` FOREIGN KEY (`nurse_id`) REFERENCES `nurses` (`nurse_id`),
  ADD CONSTRAINT `nurse_lab_allocations_fk1` FOREIGN KEY (`invoice_no`) REFERENCES `bookings` (`invoice_no`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_fk0` FOREIGN KEY (`invoice_no`) REFERENCES `bookings` (`invoice_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
