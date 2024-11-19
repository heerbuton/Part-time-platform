/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80036
Source Host           : localhost:3306
Source Database       : 软件工程

Target Server Type    : MYSQL
Target Server Version : 80036
File Encoding         : 65001

Date: 2024-11-14 23:11:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for application
-- ----------------------------
DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
  `ApplicationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `JobID` int DEFAULT NULL,
  `ApplicationDate` date DEFAULT NULL,
  `Status` enum('待审','接受','拒绝') NOT NULL,
  PRIMARY KEY (`ApplicationID`),
  KEY `UserID` (`UserID`),
  KEY `JobID` (`JobID`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `application_ibfk_2` FOREIGN KEY (`JobID`) REFERENCES `job` (`JobID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for chat_session
-- ----------------------------
DROP TABLE IF EXISTS `chat_session`;
CREATE TABLE `chat_session` (
  `SessionID` int NOT NULL AUTO_INCREMENT,
  `EmployerID` int NOT NULL,
  `UserID` int NOT NULL,
  `InitiatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `LastMessageDate` datetime DEFAULT NULL,
  PRIMARY KEY (`SessionID`),
  KEY `EmployerID` (`EmployerID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `chat_session_ibfk_1` FOREIGN KEY (`EmployerID`) REFERENCES `employer` (`EmployerID`),
  CONSTRAINT `chat_session_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `CompanyID` int NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(255) NOT NULL,
  `Website` varchar(255) DEFAULT NULL,
  `Industry` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CompanyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for employer
-- ----------------------------
DROP TABLE IF EXISTS `employer`;
CREATE TABLE `employer` (
  `EmployerID` int NOT NULL AUTO_INCREMENT,
  `CompanyID` int DEFAULT NULL,
  `ContactPerson` varchar(255) DEFAULT NULL,
  `ContactInfo` text,
  `Address` text,
  `RoleID` int DEFAULT NULL,
  PRIMARY KEY (`EmployerID`),
  KEY `CompanyID` (`CompanyID`),
  KEY `fk_employer_role` (`RoleID`),
  CONSTRAINT `employer_ibfk_1` FOREIGN KEY (`CompanyID`) REFERENCES `company` (`CompanyID`),
  CONSTRAINT `fk_employer_role` FOREIGN KEY (`RoleID`) REFERENCES `role` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job` (
  `JobID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Description` text,
  `Salary` decimal(10,2) DEFAULT NULL,
  `JobType` enum('全职','兼职') NOT NULL,
  `PostDate` date DEFAULT NULL,
  `Deadline` date DEFAULT NULL,
  `EmployerID` int DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`JobID`),
  KEY `EmployerID` (`EmployerID`),
  CONSTRAINT `job_ibfk_1` FOREIGN KEY (`EmployerID`) REFERENCES `employer` (`EmployerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for jobrequiredskill
-- ----------------------------
DROP TABLE IF EXISTS `jobrequiredskill`;
CREATE TABLE `jobrequiredskill` (
  `JobID` int NOT NULL,
  `SkillID` int NOT NULL,
  `Necessity` enum('必须','可选') NOT NULL,
  PRIMARY KEY (`JobID`,`SkillID`),
  KEY `SkillID` (`SkillID`),
  CONSTRAINT `jobrequiredskill_ibfk_1` FOREIGN KEY (`JobID`) REFERENCES `job` (`JobID`),
  CONSTRAINT `jobrequiredskill_ibfk_2` FOREIGN KEY (`SkillID`) REFERENCES `skill` (`SkillID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `MessageID` int NOT NULL AUTO_INCREMENT,
  `SessionID` int NOT NULL,
  `SenderID` int NOT NULL,
  `Content` text NOT NULL,
  `SentDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `IsRead` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`MessageID`),
  KEY `SessionID` (`SessionID`),
  KEY `SenderID` (`SenderID`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`SessionID`) REFERENCES `chat_session` (`SessionID`),
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`SenderID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `PermissionID` int NOT NULL AUTO_INCREMENT,
  `PermissionName` varchar(255) NOT NULL,
  PRIMARY KEY (`PermissionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(255) NOT NULL,
  `Permissions` text,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for rolepermission
-- ----------------------------
DROP TABLE IF EXISTS `rolepermission`;
CREATE TABLE `rolepermission` (
  `RoleID` int NOT NULL,
  `PermissionID` int NOT NULL,
  PRIMARY KEY (`RoleID`,`PermissionID`),
  KEY `PermissionID` (`PermissionID`),
  CONSTRAINT `rolepermission_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `role` (`RoleID`),
  CONSTRAINT `rolepermission_ibfk_2` FOREIGN KEY (`PermissionID`) REFERENCES `permission` (`PermissionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for skill
-- ----------------------------
DROP TABLE IF EXISTS `skill`;
CREATE TABLE `skill` (
  `SkillID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`SkillID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ContactInfo` text,
  `Address` text,
  `RoleID` int DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `role` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for userskill
-- ----------------------------
DROP TABLE IF EXISTS `userskill`;
CREATE TABLE `userskill` (
  `UserID` int NOT NULL,
  `SkillID` int NOT NULL,
  `Proficiency` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UserID`,`SkillID`),
  KEY `SkillID` (`SkillID`),
  CONSTRAINT `userskill_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `userskill_ibfk_2` FOREIGN KEY (`SkillID`) REFERENCES `skill` (`SkillID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
DROP TRIGGER IF EXISTS `update_last_message_date`;
DELIMITER ;;
CREATE TRIGGER `update_last_message_date` AFTER INSERT ON `message` FOR EACH ROW BEGIN
  UPDATE chat_session
  SET LastMessageDate = NEW.SentDate
  WHERE SessionID = NEW.SessionID;
END
;;
DELIMITER ;
