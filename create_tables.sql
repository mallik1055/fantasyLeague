# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: us-cdbr-iron-east-04.cleardb.net (MySQL 5.5.56-log)
# Database: heroku_2d4cb57104aa354
# Generation Time: 2020-02-14 10:11:02 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table players
# ------------------------------------------------------------

DROP TABLE IF EXISTS `players`;

CREATE TABLE `players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  `role` enum('batsman','bowler','allrounder','wicketkeeper') NOT NULL,
  `price` int(11) NOT NULL,
  `image_url` char(50) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;

INSERT INTO `players` (`player_id`, `name`, `role`, `price`, `image_url`)
VALUES
	(1,'Robin Uthappa','batsman',10,'/images/1.png'),
	(2,'Dwayne Smith','batsman',10,'/images/2.png'),
	(3,'Glenn Maxwell','batsman',20,'/images/3.png'),
	(4,'David Warner','batsman',20,'/images/4.png'),
	(5,'Suresh Raina','allrounder',20,'/images/5.png'),
	(6,'Virender Sehwag','allrounder',10,'/images/6.png'),
	(7,'David Miller','batsman',20,'/images/7.png'),
	(8,'JP Duminy','batsman',10,'/images/8.png'),
	(9,'Brendon McCullum','wicketkeeper',10,'/images/9.png'),
	(10,'Manish Pandey','batsman',10,'/images/10.png'),
	(11,'M S Dhoni','wicketkeeper',20,'/images/11.png'),
	(12,'Adam Gilchrist','wicketkeeper',10,'/images/12.jpg'),
	(13,'Dinesh Karthik','wicketkeeper',10,'/images/13.png'),
	(14,'Rayudu','wicketkeeper',10,'/images/14.png'),
	(15,'Ravindra Jadeja','allrounder',20,'/images/15.png'),
	(16,'Yuvraj Singh','allrounder',10,'/images/16.png'),
	(17,'Sunil Narine','bowler',20,'/images/17.png'),
	(18,'Bhuvaneshwar Kumar','bowler',10,'/images/18.png'),
	(19,'R Ashwin','bowler',10,'/images/19.png'),
	(20,'Lasith Malinga','bowler',20,'/images/20.png'),
	(21,'Kieron Pollard','allrounder',10,'/images/21.png'),
	(22,'Varun Aaron','bowler',10,'/images/22.png'),
	(23,'Mitchell Johnson','bowler',10,'/images/23.png'),
	(24,'Dale Steyn','bowler',10,'/images/24.png');

/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_lines
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_lines`;

CREATE TABLE `user_lines` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `name` char(20) NOT NULL,
  `teamname` char(20) NOT NULL,
  `balance` int(11) NOT NULL DEFAULT '100',
  `last_updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `userId` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `user_lines` WRITE;
/*!40000 ALTER TABLE `user_lines` DISABLE KEYS */;

INSERT INTO `user_lines` (`user_id`, `username`, `name`, `teamname`, `balance`, `last_updated_on`)
VALUES
	(1,'GUEST','GUEST','Deccan Chargers',0,'2020-02-14 10:10:45');

/*!40000 ALTER TABLE `user_lines` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_team
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_team`;

CREATE TABLE `user_team` (
  `user_id` int(10) NOT NULL,
  `player_id` int(10) NOT NULL,
  UNIQUE KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `user_team` WRITE;
/*!40000 ALTER TABLE `user_team` DISABLE KEYS */;

INSERT INTO `user_team` (`user_id`, `player_id`)
VALUES
	(1,1),
	(1,2),
	(1,4),
	(1,9),
	(1,15),
	(1,19),
	(1,22),
	(1,24);

/*!40000 ALTER TABLE `user_team` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
