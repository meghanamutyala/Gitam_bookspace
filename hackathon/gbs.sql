-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 26, 2024 at 12:57 PM
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
-- Database: `gbs`
--

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `book_id` int(11) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `book_name` varchar(255) DEFAULT NULL,
  `book_type` varchar(255) DEFAULT NULL,
  `book_cond` varchar(255) DEFAULT NULL,
  `book_descr` varchar(255) DEFAULT NULL,
  `book_img` varchar(255) DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `stat` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`book_id`, `user_id`, `book_name`, `book_type`, `book_cond`, `book_descr`, `book_img`, `cost`, `tags`, `stat`) VALUES
(1, 'u1', 'Introduction to Algorithms', 'Textbook', 'Good', 'Comprehensive guide to algorithms', 'algorithms.jpg', 50, 'Algorithms, CS', 'Available'),
(2, 'u2', 'Mechanical Vibrations', 'Textbook', 'Like New', 'Detailed study on vibrations in mechanical systems', 'vibrations.jpg', 75, 'Vibrations, ME', 'Available'),
(3, 'u3', 'Electric Circuits', 'Textbook', 'Used', 'Fundamentals of electric circuits', 'circuits.jpg', 40, 'Circuits, EE', 'Available'),
(4, 'user1', 'Introduction to Algorithms', 'Textbook', 'Good', 'A comprehensive book on algorithms.', 'algo.jpg', 50, 'algorithms, computer science, textbook', 'available'),
(5, 'user2', 'Thermodynamics: An Engineering Approach', 'Textbook', 'Fair', 'An essential book for thermodynamics.', 'thermo.jpg', 30, 'thermodynamics, engineering, textbook', 'available'),
(6, 'user3', 'The Art of Electronics', 'Textbook', 'Excellent', 'A detailed guide to electronic circuit design.', 'electronics.jpg', 70, 'electronics, engineering, textbook', 'available'),
(7, 'user1', 'One piece', 'notes', 'good', 'notes ', 'static/uploads\\banner2.jpg', 50, '', 'Available'),
(8, 'user1', 'something', 'notes', 'kjdshckjd', 'sjkbdskj', 'static/uploads\\banner.jpg,static/uploads\\banner2.jpg', 23, '', 'Available'),
(9, 'alice@example.com', 'Introduction to Algorithms', 'Textbook', 'New', 'A comprehensive textbook on algorithms.', 'algorithms.jpg', 50, 'algorithms, computer science', 'available'),
(10, 'bob@example.com', 'Engineering Mechanics', 'Textbook', 'Used', 'A textbook on the principles of mechanics.', 'mechanics.jpg', 30, 'mechanics, engineering', 'available'),
(11, 'carol@example.com', 'Circuits and Systems', 'Textbook', 'Good', 'A textbook on electrical circuits.', 'circuits.jpg', 40, 'circuits, electrical', 'available'),
(12, 'dave@example.com', 'The Great Gatsby', 'story', 'New', 'A classic novel by F. Scott Fitzgerald.', 'gatsby.jpg', 15, 'classic, novel', 'available'),
(13, 'eve@example.com', 'To Kill a Mockingbird', 'story', 'Used', 'A novel by Harper Lee.', 'mockingbird.jpg', 10, 'classic, novel', 'available'),
(14, 'frank@example.com', '1984', 'story', 'Good', 'A novel by George Orwell.', '1984.jpg', 12, 'dystopian, novel', 'available'),
(15, 'grace@example.com', 'Calculus Class Notes', 'notes', 'New', 'Class notes for calculus.', 'calculus_notes.jpg', 20, 'calculus, math', 'available'),
(16, 'heidi@example.com', 'Physics Class Notes', 'notes', 'Used', 'Class notes for physics.', 'physics_notes.jpg', 18, 'physics, science', 'available'),
(17, 'ivan@example.com', 'Chemistry Class Notes', 'notes', 'Good', 'Class notes for chemistry.', 'chemistry_notes.jpg', 22, 'chemistry, science', 'available');

-- --------------------------------------------------------

--
-- Table structure for table `book_order`
--

CREATE TABLE `book_order` (
  `book_id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `ord_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_order`
--

INSERT INTO `book_order` (`book_id`, `user_id`, `ord_date`) VALUES
(1, 'alice@example.com', '2024-05-26'),
(1, 'bob@example.com', '2024-05-26'),
(1, 'user1', '2024-05-26'),
(1, 'user2', '2024-05-01'),
(2, 'alice@example.com', '2024-05-26'),
(2, 'user1', '2024-05-26'),
(2, 'user3', '2024-05-02'),
(3, 'user1', '2024-05-03'),
(4, 'user1', '2024-05-26'),
(6, 'alice@example.com', '2024-05-26'),
(9, 'bob@example.com', '2024-05-01'),
(10, 'alice@example.com', '2024-05-26'),
(10, 'carol@example.com', '2024-05-02'),
(11, 'alice@example.com', '2024-05-26'),
(11, 'dave@example.com', '2024-05-03'),
(12, 'eve@example.com', '2024-05-04'),
(13, 'frank@example.com', '2024-05-05'),
(14, 'grace@example.com', '2024-05-06'),
(15, 'heidi@example.com', '2024-05-07'),
(16, 'ivan@example.com', '2024-05-08'),
(17, 'alice@example.com', '2024-05-09');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `book_id` int(11) NOT NULL,
  `seller_id` varchar(255) NOT NULL,
  `buyer_id` varchar(255) NOT NULL,
  `review` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`book_id`, `seller_id`, `buyer_id`, `review`, `rating`) VALUES
(1, 'user1', 'user2', 'Great book on algorithms. Very helpful.', 4.5),
(2, 'user2', 'user3', 'Good condition, but some pages were marked.', 3.8),
(3, 'user3', 'user1', 'Excellent condition and very informative.', 5),
(9, 'alice@example.com', 'bob@example.com', 'Great book, highly recommend!', 5),
(10, 'bob@example.com', 'carol@example.com', 'Very useful textbook.', 4.5),
(11, 'carol@example.com', 'dave@example.com', 'Good condition, helpful for my course.', 4),
(12, 'dave@example.com', 'eve@example.com', 'Loved this classic novel.', 5),
(13, 'eve@example.com', 'frank@example.com', 'A timeless read.', 4.5),
(14, 'frank@example.com', 'grace@example.com', 'Interesting story, well-preserved book.', 4),
(15, 'grace@example.com', 'heidi@example.com', 'Very detailed notes, helped a lot.', 4.5),
(16, 'heidi@example.com', 'ivan@example.com', 'Good quality notes.', 4),
(17, 'ivan@example.com', 'alice@example.com', 'Comprehensive and well-organized.', 5);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` varchar(255) NOT NULL,
  `psw` varchar(255) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `Addrs` varchar(255) DEFAULT NULL,
  `Contact` varchar(255) DEFAULT NULL,
  `user_img` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `psw`, `year`, `branch`, `Addrs`, `Contact`, `user_img`, `name`) VALUES
('alice@example.com', 'password123', 'Sophomore', 'Computer Science', '123 Maple St', '123-456-7890', 'alice.jpg', 'Alice Johnson'),
('bob@example.com', 'password123', 'Senior', 'Mechanical Engineering', '456 Oak St', '123-456-7891', 'bob.jpg', 'Bob Smith'),
('carol@example.com', 'password123', 'Junior', 'Electrical Engineering', '789 Pine St', '123-456-7892', 'carol.jpg', 'Carol White'),
('dave@example.com', 'password123', 'Sophomore', 'Civil Engineering', '321 Elm St', '123-456-7893', 'dave.jpg', 'Dave Brown'),
('eve@example.com', 'password123', 'Freshman', 'Computer Science', '654 Cedar St', '123-456-7894', 'eve.jpg', 'Eve Davis'),
('fnd@g.in', 'djfnsdjf', 'fdf', 'dfdsf', 'dsfsf', '123456', NULL, 'fefdf'),
('frank@example.com', 'password123', 'Senior', 'Computer Science', '987 Spruce St', '123-456-7895', 'frank.jpg', 'Frank Wilson'),
('grace@example.com', 'password123', 'Junior', 'Mechanical Engineering', '111 Birch St', '123-456-7896', 'grace.jpg', 'Grace Lee'),
('heidi@example.com', 'password123', 'Senior', 'Electrical Engineering', '222 Palm St', '123-456-7897', 'heidi.jpg', 'Heidi King'),
('ivan@example.com', 'password123', 'Sophomore', 'Civil Engineering', '333 Walnut St', '123-456-7898', 'ivan.jpg', 'Ivan Black'),
('u1', 'password123', 'Sophomore', 'Computer Science', '123 Main St', '555-1234', 'img1.jpg', 'John Doe'),
('u1@m.in', '12345', '3rd yesr', 'cse', 'something something', '123456', '', 'meghs'),
('u2', 'password456', 'Junior', 'Mechanical Engineering', '456 Oak Ave', '555-5678', 'img2.jpg', 'Jane Smith'),
('u3', 'password789', 'Senior', 'Electrical Engineering', '789 Pine Rd', '555-9012', 'img3.jpg', 'Alice Johnson'),
('u4', 'password', '3rd yesr', 'cse', 'something something', '123456', '', NULL),
('u5', 'pass', '3rd yesr', 'cse', 'something something', '123456', '', NULL),
('user1', 'password123', 'Sophomore', 'Computer Science', '123 Maple St, Springfield, IL', '555-1234', 'alice.jpg', 'Alice Johnson'),
('user2', 'password456', 'Senior', 'Mechanical Engineering', '456 Oak St, Springfield, IL', '555-5678', 'bob.jpg', 'Bob Smith'),
('user3', 'password789', 'Junior', 'Electrical Engineering', '789 Pine St, Springfield, IL', '555-8765', 'carol.jpg', 'Carol Davis');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `book_order`
--
ALTER TABLE `book_order`
  ADD PRIMARY KEY (`book_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`book_id`,`seller_id`,`buyer_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `book_order`
--
ALTER TABLE `book_order`
  ADD CONSTRAINT `book_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `book_order_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `ratings_ibfk_3` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
