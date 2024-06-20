/*
 Navicat Premium Data Transfer

 Source Server         : local_mysql
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : db_dorm

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 30/12/2023 01:12:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin`  (
  `adminId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sex` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`adminId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES (1, 'admin', '111', 'Lero', 'M.', '123');

-- ----------------------------
-- Table structure for t_dormbuild
-- ----------------------------
DROP TABLE IF EXISTS `t_dormbuild`;
CREATE TABLE `t_dormbuild`  (
  `dormBuildId` int NOT NULL AUTO_INCREMENT,
  `dormBuildName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `dormBuildDetail` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dormBuildId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dormbuild
-- ----------------------------
INSERT INTO `t_dormbuild` VALUES (1, 'общежития № 1', 'Это общежитие 1.');
INSERT INTO `t_dormbuild` VALUES (4, 'общежития № 2', 'Это здание общежития для аспирантов.');
INSERT INTO `t_dormbuild` VALUES (5, 'общежития № 3', '..');
INSERT INTO `t_dormbuild` VALUES (6, 'общежития № 4', '');
INSERT INTO `t_dormbuild` VALUES (7, 'общежития № 5', '');
INSERT INTO `t_dormbuild` VALUES (8, 'общежития № 6', '');
INSERT INTO `t_dormbuild` VALUES (9, 'общежития № 7', '');
INSERT INTO `t_dormbuild` VALUES (10, 'общежития № 8', '');

-- ----------------------------
-- Table structure for t_dormmanager
-- ----------------------------
DROP TABLE IF EXISTS `t_dormmanager`;
CREATE TABLE `t_dormmanager`  (
  `dormManId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `dormBuildId` int NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sex` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tel` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dormManId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dormmanager
-- ----------------------------
INSERT INTO `t_dormmanager` VALUES (2, 'manager2', '123', 4, '小张', 'М.', '123');
INSERT INTO `t_dormmanager` VALUES (3, 'manager3', '123', 1, '小李', 'Ж.', '123');
INSERT INTO `t_dormmanager` VALUES (4, 'manager4', '123', 5, '小陈', 'М.', '123');
INSERT INTO `t_dormmanager` VALUES (5, 'manager5', '123', NULL, '小宋', 'М.', '123');
INSERT INTO `t_dormmanager` VALUES (7, 'manager6', '123', NULL, '呵呵 ', 'Ж.', '123');
INSERT INTO `t_dormmanager` VALUES (8, 'manager1', '123', 6, '小白', 'М.', '123');
INSERT INTO `t_dormmanager` VALUES (9, 'manager7', '123', 7, '哈哈', 'Ж.', '123');
INSERT INTO `t_dormmanager` VALUES (10, 'manager8', '123', 9, '121', 'М.', '123456');
INSERT INTO `t_dormmanager` VALUES (11, 'manager9', '123123', 10, '122', 'Ж.', '1233456');

-- ----------------------------
-- Table structure for t_record
-- ----------------------------
DROP TABLE IF EXISTS `t_record`;
CREATE TABLE `t_record`  (
  `recordId` int NOT NULL AUTO_INCREMENT,
  `studentNumber` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `studentName` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `dormBuildId` int NULL DEFAULT NULL,
  `dormName` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `detail` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`recordId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_record
-- ----------------------------
INSERT INTO `t_record` VALUES (1, '002', 'AAA', 4, '120', '2023-10-10', '123');
INSERT INTO `t_record` VALUES (3, '007', 'Ань', 1, '221', '2023-10-12', '123');
INSERT INTO `t_record` VALUES (4, '005', 'Сюй Хао', 4, '220', '2023-11-01', '...');
INSERT INTO `t_record` VALUES (5, '006', 'Ли', 4, '111', '2023-11-03', '00');
INSERT INTO `t_record` VALUES (6, '004', 'CCC', 6, '220', '2023-11-17', '....');
INSERT INTO `t_record` VALUES (7, '004', 'CCC', 6, '220', '2023-12-01', '22');

-- ----------------------------
-- Table structure for t_student
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student`  (
  `studentId` int NOT NULL AUTO_INCREMENT,
  `stuNum` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `dormBuildId` int NULL DEFAULT NULL,
  `dormName` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sex` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tel` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`studentId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES (2, '000', '123', 'AAA', 4, '120', 'М.', '32');
INSERT INTO `t_student` VALUES (3, '003', '123', 'BBB', 5, '201', 'М.', '2');
INSERT INTO `t_student` VALUES (4, '004', '123', 'CCC', 6, '220', 'Ж.', '1');
INSERT INTO `t_student` VALUES (5, '005', '123', 'Сюй Хао', 4, '220', 'М.', '123');
INSERT INTO `t_student` VALUES (6, '006', '123', 'Ли', 4, '111', 'Ж.', '111');
INSERT INTO `t_student` VALUES (9, '007', '123', 'Ань', 1, '221', 'М.', '123');
INSERT INTO `t_student` VALUES (28, '001', '123', 'ФИО', 1, '111', 'М.', '123');
INSERT INTO `t_student` VALUES (29, '008', '123', 'DDD', 6, '123', 'М.', '123');
INSERT INTO `t_student` VALUES (30, '009', '123', 'EEE', 5, '123', 'М.', '123');
INSERT INTO `t_student` VALUES (31, '010', '123', 'FFF', 4, '222', 'Ж.', '111');
INSERT INTO `t_student` VALUES (32, '011', '123', 'GGG', 1, '101', 'Ж.', '123123');
INSERT INTO `t_student` VALUES (33, '012', '123123', 'HHH', 4, '101', 'Ж.', '122333');

SET FOREIGN_KEY_CHECKS = 1;
