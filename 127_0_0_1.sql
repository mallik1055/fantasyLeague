-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2014 at 09:52 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fantasyleague`
--

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  `role` enum('batsman','bowler','allrounder','wicketkeeper') NOT NULL,
  `price` int(11) NOT NULL,
  `image_url` char(50) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`player_id`, `name`, `role`, `price`, `image_url`) VALUES
(1, 'Robin Uthappa', 'batsman', 10, '/fantasyLeague/images/1.png'),
(2, 'Dwayne Smith', 'batsman', 10, '/fantasyLeague/images/2.png'),
(3, 'Glenn Maxwell', 'batsman', 20, '/fantasyLeague/images/3.png'),
(4, 'David Warner', 'batsman', 20, '/fantasyLeague/images/4.png'),
(5, 'Suresh Raina', 'allrounder', 20, '/fantasyLeague/images/5.png'),
(6, 'Virender Sehwag', 'allrounder', 10, '/fantasyLeague/images/6.png'),
(7, 'David Miller', 'batsman', 20, '/fantasyLeague/images/7.png'),
(8, 'JP Duminy', 'batsman', 10, '/fantasyLeague/images/8.png'),
(9, 'Brendon McCullum', 'wicketkeeper', 10, '/fantasyLeague/images/9.png'),
(10, 'Manish Pandey', 'batsman', 10, '/fantasyLeague/images/10.png'),
(11, 'M S Dhoni', 'wicketkeeper', 20, '/fantasyLeague/images/11.png'),
(12, 'Adam Gilchrist', 'wicketkeeper', 10, '/fantasyLeague/images/12.jpg'),
(13, 'Dinesh Karthik', 'wicketkeeper', 10, '/fantasyLeague/images/13.png'),
(14, 'Rayudu', 'wicketkeeper', 10, '/fantasyLeague/images/14.png'),
(15, 'Ravindra Jadeja', 'allrounder', 20, '/fantasyLeague/images/15.png'),
(16, 'Yuvraj Singh', 'allrounder', 10, '/fantasyLeague/images/16.png'),
(17, 'Sunil Narine', 'bowler', 20, '/fantasyLeague/images/17.png'),
(18, 'Bhuvaneshwar Kumar', 'bowler', 10, '/fantasyLeague/images/18.png'),
(19, 'R Ashwin', 'bowler', 10, '/fantasyLeague/images/19.png'),
(20, 'Lasith Malinga', 'bowler', 20, '/fantasyLeague/images/20.png'),
(21, 'Kieron Pollard', 'allrounder', 10, '/fantasyLeague/images/21.png'),
(22, 'Varun Aaron', 'bowler', 10, '/fantasyLeague/images/22.png'),
(23, 'Mitchell Johnson', 'bowler', 10, '/fantasyLeague/images/23.png'),
(24, 'Dale Steyn', 'bowler', 10, '/fantasyLeague/images/24.png');

-- --------------------------------------------------------

--
-- Table structure for table `user_lines`
--

CREATE TABLE IF NOT EXISTS `user_lines` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `name` char(20) NOT NULL,
  `teamname` char(20) NOT NULL,
  `balance` int(11) NOT NULL DEFAULT '100',
  `last_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `userId` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user_lines`
--

INSERT INTO `user_lines` (`user_id`, `username`, `name`, `teamname`, `balance`, `last_updated_on`) VALUES
(1, 'GUEST', 'GUEST', 'Thunder 8', 0, '2014-12-07 20:28:54');

-- --------------------------------------------------------

--
-- Table structure for table `user_team`
--

CREATE TABLE IF NOT EXISTS `user_team` (
  `user_id` int(10) NOT NULL,
  `player_id` int(10) NOT NULL,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_team`
--

INSERT INTO `user_team` (`user_id`, `player_id`) VALUES
(1, 1),
(1, 3),
(1, 10),
(1, 12),
(1, 19),
(1, 20),
(1, 21),
(1, 22);
--
-- Database: `test`
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
