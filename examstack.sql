/*
Navicat MySQL Data Transfer

Source Server         : server
Source Server Version : 50534
Source Host           : 218.244.144.149:3306
Source Database       : examstack

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2015-08-30 00:11:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `et_comment`
-- ----------------------------
DROP TABLE IF EXISTS `et_comment`;
CREATE TABLE `et_comment` (
  `comment_id` int(10) NOT NULL,
  `question_id` int(10) NOT NULL,
  `index_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `content_msg` mediumtext NOT NULL,
  `quoto_id` int(10) NOT NULL DEFAULT '0',
  `re_id` int(10) NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `fk_q_id` (`question_id`),
  KEY `fk_u_id` (`user_id`),
  CONSTRAINT `et_comment_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`),
  CONSTRAINT `et_comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `et_department`
-- ----------------------------
DROP TABLE IF EXISTS `et_department`;
CREATE TABLE `et_department` (
  `dep_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(200) NOT NULL,
  `memo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_department
-- ----------------------------
INSERT INTO `et_department` VALUES ('1', '计划财务部', '计划财务部');
INSERT INTO `et_department` VALUES ('2', '人力资源部', '人力资源部');
INSERT INTO `et_department` VALUES ('4', '市场拓展部', '市场拓展部');

-- ----------------------------
-- Table structure for `et_exam`
-- ----------------------------
DROP TABLE IF EXISTS `et_exam`;
CREATE TABLE `et_exam` (
  `id` int(11) NOT NULL,
  `exam_name` varchar(100) NOT NULL,
  `exam_subscribe` varchar(500) DEFAULT NULL,
  `exam_type` tinyint(4) NOT NULL COMMENT '公有、私有、模拟考试',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `exam_paper_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_2pid` (`exam_paper_id`),
  CONSTRAINT `fk_exam_2pid` FOREIGN KEY (`exam_paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_exam
-- ----------------------------

-- ----------------------------
-- Table structure for `et_exam_2_paper`
-- ----------------------------
DROP TABLE IF EXISTS `et_exam_2_paper`;
CREATE TABLE `et_exam_2_paper` (
  `exam_id` int(11) NOT NULL,
  `paper_id` int(11) NOT NULL,
  UNIQUE KEY `idx_exam_epid` (`exam_id`,`paper_id`),
  KEY `fk_exam_pid` (`paper_id`),
  CONSTRAINT `fk_exam_eid` FOREIGN KEY (`exam_id`) REFERENCES `et_exam` (`id`),
  CONSTRAINT `fk_exam_pid` FOREIGN KEY (`paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_exam_2_paper
-- ----------------------------

-- ----------------------------
-- Table structure for `et_exam_paper`
-- ----------------------------
DROP TABLE IF EXISTS `et_exam_paper`;
CREATE TABLE `et_exam_paper` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  `paper_type` varchar(40) NOT NULL DEFAULT '1' COMMENT '0 真题 1 模拟 2 专家',
  `field_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_exam_paper
-- ----------------------------

-- ----------------------------
-- Table structure for `et_field`
-- ----------------------------
DROP TABLE IF EXISTS `et_field`;
CREATE TABLE `et_field` (
  `field_id` int(5) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_field
-- ----------------------------
INSERT INTO `et_field` VALUES ('1', '驾校科目一理论考试', '驾校科目一理论考试', '1');
INSERT INTO `et_field` VALUES ('4', '公务员申论', '公务员申论', '0');
INSERT INTO `et_field` VALUES ('5', '医药行业考试', '医药行业考试', '0');

-- ----------------------------
-- Table structure for `et_group`
-- ----------------------------
DROP TABLE IF EXISTS `et_group`;
CREATE TABLE `et_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(40) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_group_uid` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_group
-- ----------------------------
INSERT INTO `et_group` VALUES ('1', '人力资源部', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('2', 'yh1122的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('3', 'yh1123的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('4', 'yh1124的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('5', 'yh1125的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('6', 'yh1126的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('7', 'yh1127的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('8', 'yh1128的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('9', 'yh1129的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('10', 'yh1130的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('11', 'yh1131的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('12', 'yh1132的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('13', 'yh1133的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('14', 'yh1134的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('15', 'yh1135的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('16', 'yh1136的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('17', 'yh1137的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('18', 'yh1138的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('19', 'yh1139的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('20', 'yh1140的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('21', 'yh1141的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('22', 'yh1142的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('23', 'yh1143的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('24', 'yh2的默认分组', '2015-08-09 21:07:58', '2', '0');
INSERT INTO `et_group` VALUES ('34', '默认分组', '2015-08-15 21:09:56', '5', '0');
INSERT INTO `et_group` VALUES ('35', '默认分组', '2015-08-15 21:13:41', '6', '0');
INSERT INTO `et_group` VALUES ('36', '默认分组', '2015-08-15 21:16:17', '7', '0');
INSERT INTO `et_group` VALUES ('37', '默认分组', '2015-08-17 23:16:54', '8', '0');
INSERT INTO `et_group` VALUES ('38', '默认分组', '2015-08-17 23:54:47', '9', '0');
INSERT INTO `et_group` VALUES ('39', '默认分组', '2015-08-17 23:55:36', '1', '0');
INSERT INTO `et_group` VALUES ('40', '默认分组', '2015-08-17 23:55:51', '11', '0');
INSERT INTO `et_group` VALUES ('41', '默认分组', '2015-08-17 23:59:17', '12', '0');
INSERT INTO `et_group` VALUES ('42', '默认分组', '2015-08-17 23:59:38', '13', '0');
INSERT INTO `et_group` VALUES ('43', '默认分组', '2015-08-18 00:12:22', '14', '0');
INSERT INTO `et_group` VALUES ('44', '默认分组', '2015-08-18 08:53:54', '15', '0');
INSERT INTO `et_group` VALUES ('45', '默认分组', '2015-08-18 20:35:08', '16', '0');
INSERT INTO `et_group` VALUES ('46', '默认分组', '2015-08-18 20:43:31', '18', '0');
INSERT INTO `et_group` VALUES ('47', '人力资源部', '2015-08-18 21:10:19', '5', '0');
INSERT INTO `et_group` VALUES ('48', '默认分组', '2015-08-18 21:50:33', '20', '0');
INSERT INTO `et_group` VALUES ('49', '我的分组', '2015-08-18 22:14:49', '5', '0');
INSERT INTO `et_group` VALUES ('50', '我的分组1', '2015-08-18 22:18:24', '5', '0');
INSERT INTO `et_group` VALUES ('52', '我的分组2', '2015-08-18 22:20:29', '5', '0');
INSERT INTO `et_group` VALUES ('53', '我的分组4', '2015-08-18 22:22:29', '5', '0');
INSERT INTO `et_group` VALUES ('54', '我的分组4', '2015-08-18 22:22:30', '5', '0');
INSERT INTO `et_group` VALUES ('55', '我的分组4', '2015-08-18 22:22:31', '5', '0');
INSERT INTO `et_group` VALUES ('56', '我的分组7', '2015-08-18 22:24:05', '5', '0');
INSERT INTO `et_group` VALUES ('57', 'fine team', '2015-08-19 20:49:50', '1', '0');
INSERT INTO `et_group` VALUES ('59', '我的分组', '2015-08-19 20:55:05', '1', '0');
INSERT INTO `et_group` VALUES ('60', '财务部', '2015-08-19 21:22:45', '1', '0');
INSERT INTO `et_group` VALUES ('61', '信息技术部', '2015-08-19 21:24:03', '1', '0');
INSERT INTO `et_group` VALUES ('63', '默认分组', '2015-08-19 21:39:27', '21', '1');
INSERT INTO `et_group` VALUES ('64', '人力资源部', '2015-08-19 21:54:55', '1', '0');
INSERT INTO `et_group` VALUES ('65', '默认分组', '2015-08-26 21:50:24', '38', '1');
INSERT INTO `et_group` VALUES ('66', '默认分组', '2015-08-26 21:54:56', '40', '1');
INSERT INTO `et_group` VALUES ('67', '默认分组', '2015-08-26 21:56:11', '41', '1');
INSERT INTO `et_group` VALUES ('68', '默认分组', '2015-08-26 21:59:08', '42', '1');
INSERT INTO `et_group` VALUES ('69', '默认分组', '2015-08-26 22:26:31', '44', '1');
INSERT INTO `et_group` VALUES ('70', '默认分组', '2015-08-26 22:28:09', '45', '1');
INSERT INTO `et_group` VALUES ('71', '默认分组', '2015-08-26 22:30:24', '46', '1');
INSERT INTO `et_group` VALUES ('72', '默认分组', '2015-08-26 22:31:06', '47', '1');
INSERT INTO `et_group` VALUES ('73', '默认分组', '2015-08-26 22:32:51', '48', '1');
INSERT INTO `et_group` VALUES ('74', '默认分组', '2015-08-29 23:21:01', '54', '1');

-- ----------------------------
-- Table structure for `et_knowledge_point`
-- ----------------------------
DROP TABLE IF EXISTS `et_knowledge_point`;
CREATE TABLE `et_knowledge_point` (
  `point_id` int(5) NOT NULL AUTO_INCREMENT,
  `point_name` varchar(100) NOT NULL,
  `field_id` int(5) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) DEFAULT '1' COMMENT '1:正常 0：废弃',
  PRIMARY KEY (`point_id`),
  KEY `fk_knowledge_field` (`field_id`),
  CONSTRAINT `et_knowledge_point_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `et_field` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_knowledge_point
-- ----------------------------
INSERT INTO `et_knowledge_point` VALUES ('1', '道路交通安全法律、法规和规章 ', '1', '这是一个测试', '0');
INSERT INTO `et_knowledge_point` VALUES ('3', '安全行车、文明驾驶基础知识 ', '1', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('4', '机动车驾驶操作相关基础知识', '1', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('6', '常识判断', '4', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('18', '言语理解与表达', '4', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('19', '判断推理', '4', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('20', '数量关系 ', '4', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('21', '资料分析', '4', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('22', '基本医药行业', '5', null, '0');
INSERT INTO `et_knowledge_point` VALUES ('23', '儿科考试呢', '5', null, '0');

-- ----------------------------
-- Table structure for `et_menu_item`
-- ----------------------------
DROP TABLE IF EXISTS `et_menu_item`;
CREATE TABLE `et_menu_item` (
  `menu_id` varchar(50) NOT NULL,
  `menu_name` varchar(100) NOT NULL,
  `menu_href` varchar(200) NOT NULL,
  `menu_seq` int(5) NOT NULL,
  `authority` varchar(20) NOT NULL,
  `parent_id` varchar(50) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_menu_item
-- ----------------------------
INSERT INTO `et_menu_item` VALUES ('question', '试题管理', 'admin/question/question-list', '1001', 'ROLE_ADMIN', '-1', 'fa-cloud', '1');
INSERT INTO `et_menu_item` VALUES ('question-list', '试题管理', 'admin/question/question-list', '100101', 'ROLE_ADMIN', 'question', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('question-add', '添加试题', 'admin/question/question-add', '100102', 'ROLE_ADMIN', 'question', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('question-import', '导入试题', 'admin/question/question-import', '100103', 'ROLE_ADMIN', 'question', 'fa-cloud-upload', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper', '试卷管理', 'admin/exampaper/exampaper-list', '1002', 'ROLE_ADMIN', '-1', 'fa-file-text-o', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-list', '试卷管理', 'admin/exampaper/exampaper-list', '100201', 'ROLE_ADMIN', 'exampaper', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-add', '创建新试卷', 'admin/exampaper/exampaper-add', '100202', 'ROLE_ADMIN', 'exampaper', 'fa-leaf', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-edit', '修改试卷', '', '100203', 'ROLE_ADMIN', 'exampaper', 'fa-pencil', '0');
INSERT INTO `et_menu_item` VALUES ('exampaper-preview', '预览试卷', '', '100204', 'ROLE_ADMIN', 'exampaper', 'fa-eye', '0');
INSERT INTO `et_menu_item` VALUES ('exam', '考试管理', 'admin/exam/exam-list', '1003', 'ROLE_ADMIN', '-1', 'fa-trophy', '1');
INSERT INTO `et_menu_item` VALUES ('exam-list', '考试管理', 'admin/exam/exam-list', '100301', 'ROLE_ADMIN', 'exam', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exam-add', '发布考试', 'admin/exam/exam-add', '100302', 'ROLE_ADMIN', 'exam', 'fa-plus-square-o', '1');
INSERT INTO `et_menu_item` VALUES ('exam-student-list', '学员名单', '', '100303', 'ROLE_ADMIN', 'exam', 'fa-sitemap', '0');
INSERT INTO `et_menu_item` VALUES ('student-answer-sheet', '学员试卷', '', '100304', 'ROLE_ADMIN', 'exam', 'fa-file-o', '0');
INSERT INTO `et_menu_item` VALUES ('mark-exampaper', '人工阅卷', '', '100305', 'ROLE_ADMIN', 'exam', 'fa-circle-o-notch', '0');
INSERT INTO `et_menu_item` VALUES ('user', '用户管理', 'admin/user/student-list', '1005', 'ROLE_ADMIN', '-1', 'fa-user', '1');
INSERT INTO `et_menu_item` VALUES ('student-list', '用户管理', 'admin/user/student-list', '100501', 'ROLE_ADMIN', 'user', 'fa-users', '1');
INSERT INTO `et_menu_item` VALUES ('student-examhistory', '考试历史', '', '100502', 'ROLE_ADMIN', 'user', 'fa-glass', '0');
INSERT INTO `et_menu_item` VALUES ('student-profile', '学员资料', '', '100503', 'ROLE_ADMIN', 'user', 'fa-flag-o', '0');
INSERT INTO `et_menu_item` VALUES ('teacher-list', '教师管理', 'admin/user/teacher-list', '100504', 'ROLE_ADMIN', 'user', 'fa-cubes', '1');
INSERT INTO `et_menu_item` VALUES ('teacher-profile', '教师资料', '', '100505', 'ROLE_ADMIN', 'user', null, '0');
INSERT INTO `et_menu_item` VALUES ('training', '培训', 'admin/training/training-list', '1004', 'ROLE_ADMIN', '-1', 'fa-dashboard', '1');
INSERT INTO `et_menu_item` VALUES ('training-list', '培训管理', 'admin/training/training-list', '100401', 'ROLE_ADMIN', 'training', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('training-add', '添加培训', 'admin/training/training-add', '100402', 'ROLE_ADMIN', 'training', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('student-practice-status', '学习进度', '', '100403', 'ROLE_ADMIN', 'training', 'fa-rocket', '0');
INSERT INTO `et_menu_item` VALUES ('student-training-history', '培训进度', '', '100404', 'ROLE_ADMIN', 'training', 'fa-star-half-full', '0');
INSERT INTO `et_menu_item` VALUES ('common', '通用数据', 'admin/common/tag-list', '1006', 'ROLE_ADMIN', '-1', 'fa-cubes', '1');
INSERT INTO `et_menu_item` VALUES ('tag-list', '标签管理', 'admin/common/tag-list', '100601', 'ROLE_ADMIN', 'common', 'fa-tags', '1');
INSERT INTO `et_menu_item` VALUES ('field-list', '专业题库', 'admin/common/field-list', '100602', 'ROLE_ADMIN', 'common', 'fa-anchor', '1');
INSERT INTO `et_menu_item` VALUES ('knowledge-list', '知识分类', 'admin/common/knowledge-list/0', '100603', 'ROLE_ADMIN', 'common', 'fa-flag', '1');
INSERT INTO `et_menu_item` VALUES ('question', '试题管理', 'teacher/question/question-list', '2001', 'ROLE_TEACHER', '-1', 'fa-cloud', '1');
INSERT INTO `et_menu_item` VALUES ('question-list', '试题管理', 'teacher/question/question-list', '200101', 'ROLE_TEACHER', 'question', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('question-add', '添加试题', 'teacher/question/question-add', '200102', 'ROLE_TEACHER', 'question', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('question-import', '导入试题', 'teacher/question/question-import', '200103', 'ROLE_TEACHER', 'question', 'fa-cloud-upload', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper', '试卷管理', 'teacher/exampaper/exampaper-list', '2002', 'ROLE_TEACHER', '-1', 'fa-file-text-o', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-list', '试卷管理', 'teacher/exampaper/exampaper-list', '200201', 'ROLE_TEACHER', 'exampaper', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-add', '创建新试卷', 'teacher/exampaper/exampaper-add', '200202', 'ROLE_TEACHER', 'exampaper', 'fa-leaf', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-edit', '修改试卷', '', '200203', 'ROLE_TEACHER', 'exampaper', 'fa-pencil', '0');
INSERT INTO `et_menu_item` VALUES ('exampaper-preview', '预览试卷', '', '200204', 'ROLE_TEACHER', 'exampaper', 'fa-eye', '0');
INSERT INTO `et_menu_item` VALUES ('exam', '考试管理', 'teacher/exam/exam-list', '2003', 'ROLE_TEACHER', '-1', 'fa-trophy', '1');
INSERT INTO `et_menu_item` VALUES ('exam-list', '考试管理', 'teacher/exam/exam-list', '200301', 'ROLE_TEACHER', 'exam', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exam-add', '发布考试', 'teacher/exam/exam-add', '200302', 'ROLE_TEACHER', 'exam', 'fa-plus-square-o', '1');
INSERT INTO `et_menu_item` VALUES ('exam-student-list', '学员名单', '', '200303', 'ROLE_TEACHER', 'exam', 'fa-sitemap', '0');
INSERT INTO `et_menu_item` VALUES ('student-answer-sheet', '学员试卷', '', '200304', 'ROLE_TEACHER', 'exam', 'fa-file-o', '0');
INSERT INTO `et_menu_item` VALUES ('mark-exampaper', '人工阅卷', '', '200305', 'ROLE_TEACHER', 'exam', 'fa-circle-o-notch', '0');
INSERT INTO `et_menu_item` VALUES ('user', '用户管理', 'teacher/user/student-list', '2005', 'ROLE_TEACHER', '-1', 'fa-user', '1');
INSERT INTO `et_menu_item` VALUES ('student-list', '用户管理', 'teacher/user/student-list', '200501', 'ROLE_TEACHER', 'user', 'fa-users', '1');
INSERT INTO `et_menu_item` VALUES ('student-examhistory', '考试历史', '', '200502', 'ROLE_TEACHER', 'user', 'fa-glass', '0');
INSERT INTO `et_menu_item` VALUES ('student-profile', '学员资料', '', '200503', 'ROLE_TEACHER', 'user', 'fa-flag-o', '0');
INSERT INTO `et_menu_item` VALUES ('training', '培训', 'teacher/training/training-list', '2004', 'ROLE_TEACHER', '-1', 'fa-dashboard', '1');
INSERT INTO `et_menu_item` VALUES ('training-list', '培训管理', 'teacher/training/training-list', '200401', 'ROLE_TEACHER', 'training', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('training-add', '添加培训', 'teacher/training/training-add', '200402', 'ROLE_TEACHER', 'training', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('student-practice-status', '学习进度', '', '200403', 'ROLE_TEACHER', 'training', 'fa-rocket', '0');
INSERT INTO `et_menu_item` VALUES ('student-training-history', '培训进度', '', '200404', 'ROLE_TEACHER', 'training', 'fa-star-half-full', '0');
INSERT INTO `et_menu_item` VALUES ('system', '系统设置', 'teacher/system/teacher-list', '1007', 'ROLE_ADMIN', '-1', 'fa-cog', '1');
INSERT INTO `et_menu_item` VALUES ('admin-list', '管理员列表', 'teacher/system/teacher-list', '100701', 'ROLE_ADMIN', 'system', 'fa-group', '1');
INSERT INTO `et_menu_item` VALUES ('admin-add', '添加管理员', 'teacher/system/teacher-add', '100702', 'ROLE_ADMIN', 'system', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('backup', '数据备份', 'teacher/system/backup', '100703', 'ROLE_ADMIN', 'system', 'fa-share-square-o', '1');
INSERT INTO `et_menu_item` VALUES ('news-list', '系统公告', 'teacher/system/news-list', '100704', 'ROLE_ADMIN', 'system', 'fa-volume-up', '1');
INSERT INTO `et_menu_item` VALUES ('news-add', '发布公告', 'teacher/system/news-add', '100705', 'ROLE_ADMIN', 'system', 'fa-list-alt', '1');
INSERT INTO `et_menu_item` VALUES ('dep-list', '部门管理', 'admin/common/dep-list', '100604', 'ROLE_ADMIN', 'common', 'fa-leaf', '1');

-- ----------------------------
-- Table structure for `et_news`
-- ----------------------------
DROP TABLE IF EXISTS `et_news`;
CREATE TABLE `et_news` (
  `id` int(11) NOT NULL,
  `titile` varchar(100) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_expire` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否过期',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 新闻， 1 系统信息',
  `group_id` int(11) NOT NULL DEFAULT '-1' COMMENT '此系统属于哪个组',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `et_news_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_news
-- ----------------------------

-- ----------------------------
-- Table structure for `et_practice_paper`
-- ----------------------------
DROP TABLE IF EXISTS `et_practice_paper`;
CREATE TABLE `et_practice_paper` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_practice_paper
-- ----------------------------

-- ----------------------------
-- Table structure for `et_question`
-- ----------------------------
DROP TABLE IF EXISTS `et_question`;
CREATE TABLE `et_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `question_type_id` int(11) NOT NULL COMMENT '题型',
  `duration` int(11) DEFAULT NULL COMMENT '试题考试时间',
  `points` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试题可见性',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(20) NOT NULL DEFAULT 'admin' COMMENT '创建者',
  `last_modify` timestamp NULL DEFAULT NULL,
  `answer` mediumtext NOT NULL,
  `expose_times` int(11) NOT NULL DEFAULT '2',
  `right_times` int(11) NOT NULL DEFAULT '1',
  `wrong_times` int(11) NOT NULL DEFAULT '1',
  `difficulty` int(5) NOT NULL DEFAULT '1',
  `analysis` mediumtext,
  `reference` varchar(1000) DEFAULT NULL,
  `examing_point` varchar(5000) DEFAULT NULL,
  `keyword` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_type_id` (`question_type_id`),
  KEY `et_question_ibfk_5` (`creator`),
  CONSTRAINT `et_question_ibfk_1` FOREIGN KEY (`question_type_id`) REFERENCES `et_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question
-- ----------------------------
INSERT INTO `et_question` VALUES ('5', '111', '{\"title\":\"111\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"1\",\"B\":\"1\",\"C\":\"1\",\"D\":\"1\"},\"choiceImgList\":{}}', '1', null, '0', null, '0', '2015-08-06 23:25:19', 'liupan', null, 'A', '2', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `et_question` VALUES ('13', '世界四大洋中面积最小', '{\"title\":\"世界四大洋中面积最小的是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"太平洋\",\"B\":\"大西洋\",\"C\":\"印度洋\",\"D\":\"北冰洋\"},\"choiceImgList\":{}}', '1', null, '0', null, '0', '2015-08-26 21:34:45', 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('14', '世界上海拔最高的山峰', '{\"title\":\"世界上海拔最高的山峰是哪一座 ?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"乔戈里峰 \",\"B\":\"干城章嘉峰 \",\"C\":\"珠穆朗玛峰 \",\"D\":\"公格尔山峰\"},\"choiceImgList\":{}}', '1', null, '0', null, '0', '2015-08-26 21:35:33', 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('15', '\"鲁\"是我国哪个省份', '{\"title\":\"\\\"鲁\\\"是我国哪个省份的简称 :\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"河北 \",\"B\":\"吉林 \",\"C\":\"山东 \",\"D\":\"山西\"},\"choiceImgList\":{}}', '1', null, '0', null, '0', '2015-08-26 21:36:00', 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('16', '驾驶机动车在隧道、陡', '{\"title\":\"驾驶机动车在隧道、陡坡等特殊路段不得超车。\",\"titleImg\":\"\",\"choiceList\":{},\"choiceImgList\":{}}', '3', null, '0', null, '0', '2015-08-26 21:40:20', 'teacher', null, 'T', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('17', '驾驶机动车行经城市没', '{\"title\":\"驾驶机动车行经城市没有列车通过的铁路道口时允许超车。\",\"titleImg\":\"\",\"choiceList\":{},\"choiceImgList\":{}}', '3', null, '0', null, '0', '2015-08-26 21:40:39', 'teacher', null, 'T', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('18', '测试A', '{\"title\":\"测试A\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"A\",\"B\":\"B\",\"C\":\"C\",\"D\":\"D\"},\"choiceImgList\":{}}', '1', null, '0', null, '0', '2015-08-28 21:25:31', 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');

-- ----------------------------
-- Table structure for `et_question_2_point`
-- ----------------------------
DROP TABLE IF EXISTS `et_question_2_point`;
CREATE TABLE `et_question_2_point` (
  `question_2_point_id` int(10) NOT NULL AUTO_INCREMENT,
  `question_id` int(10) DEFAULT NULL,
  `point_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`question_2_point_id`),
  KEY `fk_question_111` (`question_id`),
  KEY `fk_point_111` (`point_id`),
  CONSTRAINT `et_question_2_point_ibfk_1` FOREIGN KEY (`point_id`) REFERENCES `et_knowledge_point` (`point_id`) ON DELETE CASCADE,
  CONSTRAINT `et_question_2_point_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_2_point
-- ----------------------------
INSERT INTO `et_question_2_point` VALUES ('40', '5', '1');
INSERT INTO `et_question_2_point` VALUES ('50', '14', '6');
INSERT INTO `et_question_2_point` VALUES ('52', '13', '1');
INSERT INTO `et_question_2_point` VALUES ('53', '15', '6');
INSERT INTO `et_question_2_point` VALUES ('54', '16', '1');
INSERT INTO `et_question_2_point` VALUES ('55', '17', '1');
INSERT INTO `et_question_2_point` VALUES ('56', '18', '22');

-- ----------------------------
-- Table structure for `et_question_2_tag`
-- ----------------------------
DROP TABLE IF EXISTS `et_question_2_tag`;
CREATE TABLE `et_question_2_tag` (
  `question_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`question_tag_id`),
  KEY `fk_question_tag_tid` (`tag_id`),
  KEY `fk_question_tag_qid` (`question_id`),
  CONSTRAINT `et_question_2_tag_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `et_question_2_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `et_tag` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_2_tag
-- ----------------------------
INSERT INTO `et_question_2_tag` VALUES ('77', '13', '6', '2015-08-26 21:36:15', '0');

-- ----------------------------
-- Table structure for `et_question_history`
-- ----------------------------
DROP TABLE IF EXISTS `et_question_history`;
CREATE TABLE `et_question_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_right` tinyint(4) NOT NULL DEFAULT '1',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`),
  KEY `fk_hist_uid` (`user_id`),
  KEY `fk_hist_qid` (`question_id`),
  CONSTRAINT `fk_hist_qid` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hist_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_history
-- ----------------------------

-- ----------------------------
-- Table structure for `et_question_type`
-- ----------------------------
DROP TABLE IF EXISTS `et_question_type`;
CREATE TABLE `et_question_type` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `subjective` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_type
-- ----------------------------
INSERT INTO `et_question_type` VALUES ('1', '单选题', '0');
INSERT INTO `et_question_type` VALUES ('2', '多选题', '0');
INSERT INTO `et_question_type` VALUES ('3', '判断题', '0');
INSERT INTO `et_question_type` VALUES ('4', '填空题', '0');
INSERT INTO `et_question_type` VALUES ('5', '简答题', '1');
INSERT INTO `et_question_type` VALUES ('6', '论述题', '1');
INSERT INTO `et_question_type` VALUES ('7', '分析题', '1');

-- ----------------------------
-- Table structure for `et_reference`
-- ----------------------------
DROP TABLE IF EXISTS `et_reference`;
CREATE TABLE `et_reference` (
  `reference_id` int(5) NOT NULL,
  `reference_name` varchar(200) NOT NULL,
  `memo` varchar(200) DEFAULT NULL,
  `state` decimal(10,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_reference
-- ----------------------------

-- ----------------------------
-- Table structure for `et_role`
-- ----------------------------
DROP TABLE IF EXISTS `et_role`;
CREATE TABLE `et_role` (
  `id` int(11) NOT NULL,
  `authority` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_role
-- ----------------------------
INSERT INTO `et_role` VALUES ('1', 'ROLE_ADMIN', '超级管理员', 'admin');
INSERT INTO `et_role` VALUES ('2', 'ROLE_TEACHER', '教师', 'teacher');
INSERT INTO `et_role` VALUES ('3', 'ROLE_STUDENT', '学员', 'student');

-- ----------------------------
-- Table structure for `et_tag`
-- ----------------------------
DROP TABLE IF EXISTS `et_tag`;
CREATE TABLE `et_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(100) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` int(11) NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `memo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `fk_tag_creator` (`creator`),
  CONSTRAINT `et_tag_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_tag
-- ----------------------------
INSERT INTO `et_tag` VALUES ('3', '易错题', '2015-08-07 20:42:00', '1', '0', '易错题');
INSERT INTO `et_tag` VALUES ('4', '简单', '2015-08-16 17:46:42', '1', '0', '简单');
INSERT INTO `et_tag` VALUES ('5', '交通信号灯', '2015-08-16 17:46:54', '1', '0', '交通信号灯');
INSERT INTO `et_tag` VALUES ('6', '送分题', '2015-08-16 22:23:59', '1', '0', '送分题');

-- ----------------------------
-- Table structure for `et_user`
-- ----------------------------
DROP TABLE IF EXISTS `et_user`;
CREATE TABLE `et_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `user_name` varchar(50) NOT NULL COMMENT '账号',
  `true_name` varchar(50) NOT NULL COMMENT '真实姓名',
  `national_id` varchar(20) NOT NULL,
  `password` char(80) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone_num` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '激活状态：0-未激活 1-激活',
  `field_id` int(10) NOT NULL,
  `last_login_time` timestamp NULL DEFAULT NULL,
  `login_time` timestamp NULL DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL COMMENT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `idx_user_uid` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of et_user
-- ----------------------------
INSERT INTO `et_user` VALUES ('1', 'admin', 'admin', '1111', '260acbffd3c30786febc29d7dd71a9880a811e77', '11', '111', '2015-08-06 11:31:54', '1', '1', '1', '2015-08-06 11:31:34', '2015-08-06 11:31:50', null, '1');
INSERT INTO `et_user` VALUES ('5', 'teacher', 'liupan', '11111111', 'fc14eb915a2b7ac17624e49b707a58ef84171b9c', '1111@111.com', '11111111', '2015-08-15 21:09:53', '0', '1', '1', null, null, null, '111111');
INSERT INTO `et_user` VALUES ('6', 'zhangsan', 'liupan', '111111111', '95bd4178668f455f506744b7ed3c5babf76012d5', '1111@111.com', '11111111', '2015-08-18 21:34:31', '0', '1', '1', null, null, '1111111111', '111111');
INSERT INTO `et_user` VALUES ('29', 'ASDFDSFS', 'ASDFASDF', '444444444444444444', 'bc359aa88add02452c6cfbe5d92ed982ca72c72f', 'aaa@aaa.com', '13333333333', '2015-08-29 23:30:25', '0', '1', '0', null, null, null, 'afdasdfas');
INSERT INTO `et_user` VALUES ('30', 'test1', 'noman', '444432132132132132', '59e6bf3069205880807a30963c411ee91e7c8cf3', '333@333.com', '13333333333', '2015-08-29 23:31:56', '0', '1', '0', null, null, null, '112121212');
INSERT INTO `et_user` VALUES ('34', '44442asdf', 'asdfasdfasf', '444444444444444444', '510c394e9640f6c9e67ca2f2eb42f774409b8a91', '123@111.com', '13333333333', '2015-08-20 23:18:52', '1', '1', '0', null, null, null, '123123123');
INSERT INTO `et_user` VALUES ('35', 'carman', 'carman', '156555555555555555', '426448e4ef8d63f4fa4d568ded1952ee9ee35ca6', 'dsadsa@dasd', '18655455555', '2015-08-25 21:20:32', '1', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('36', 'jayyh1', 'dasdas', '125555555555555555', 'b860d8eb1adbd0e52dcead7f39b7e5dd200ac85d', 'sadsa@adsdas.com', '18655554444', '2015-08-29 23:32:15', '0', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('37', 'jayyh', 'dsad', '155565444444444444', '6b372ff870031d1837d4eebfd1db66614d70ba4c', 'dasds@dasd.com', '18655524444', '2015-08-29 23:59:12', '0', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('38', 'newTeacher', 'dasdsa', '555555555555555555', '80c2037ce8d424a7fc2df5374089bb727b43f92f', 'sadasd@asdasd.cc', '18654455653', '2015-08-29 23:39:32', '0', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('40', 'newTeacher1', 'sadsadsad', '555555555555555555', '6c4fad289e724e1cc9fd9a5c60776f5f54ea434f', 'sdasd@dasds.sd', '18655554444', '2015-08-26 21:54:56', '1', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('41', 'teacher2', 'ddsadsa', '555555555555555555', '21e0aba50598f3230ba285f8d8a45d5579dbbb84', 'dsadas@adsds.cc', '18655554444', '2015-08-26 21:56:11', '1', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('42', 'WWWW', 'dsadsad', '555555555555555555', 'fd389104f468b1d1a8792e7a29136bc29c6a22ee', 'dasdaSD@dasdsad.cc', '18655554444', '2015-08-29 23:39:43', '0', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('43', 'AAAA', 'dsada', '544444444444444444', '876b84830a6dad9fd5e5d3b63551062a89bdcbe9', 'sads@asds.cc', '18222554444', '2015-08-29 23:40:01', '0', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('44', 'WWWWW', 'WWWWW', '444444444444444444', '663d9e05f445d1da948fc2acf47692252815dbc9', '3333@222.COM', '13333333333', '2015-08-26 22:26:31', '1', '1', '0', null, null, null, 'ADSFASDF');
INSERT INTO `et_user` VALUES ('45', 'WWWWWW', 'WWWWW', '444444444444444444', '1c377b91560db8dc75d93281c67f020f17ab085a', '333@222.COM', '13333333333', '2015-08-26 22:28:09', '1', '1', '0', null, null, null, 'WWWWW');
INSERT INTO `et_user` VALUES ('46', 'aaaaaa', 'AAAAAAA', '444444444444444444', 'c8843d65c988e6b5b6f8b4b939c1d4269dbf443b', 'ADSFA@AAA.COM', '13333333333', '2015-08-26 22:30:24', '1', '1', '0', null, null, null, 'ADFAFAAAAAAA');
INSERT INTO `et_user` VALUES ('47', 'aaaaaaaa', 'AAAAAAA', '444444444444444444', '39ec96ce9fedb2b12b061a90934db6987d9d14ab', '3333@2222.COM', '13333333333', '2015-08-26 22:31:06', '1', '1', '0', null, null, null, 'ADSFASDFASDF');
INSERT INTO `et_user` VALUES ('48', 'bbbbbb', 'BBBBBB', '444444444444444444', '3651a1fab18616503806900a228bed4978b4856f', '333@DDAF.COM', '13333333333', '2015-08-29 23:21:32', '0', '1', '0', null, null, null, 'BBBBBB');
INSERT INTO `et_user` VALUES ('49', 'greedisgood', 'ddssdf1231', '420000000000000000', 'c0e39c74246ab85621127eae9d53bc66045c104a', '33333@222.com', '13333333333', '2015-08-28 00:10:12', '-1', '1', '0', null, null, null, 'hello123');
INSERT INTO `et_user` VALUES ('50', '康勇华', '康勇华', '320623197707126058', '620a81d5e3811538d34052f4b5826e65fb792669', 'jackykang@189.cn', '13358180123', '2015-08-28 21:28:59', '1', '1', '0', null, null, null, 'KCWX');
INSERT INTO `et_user` VALUES ('51', '严欢严欢', '严欢', '511555555555555555', '7c031c13e7fd3a8c78b3cb97d86d5015679668ed', 'sadsad@dasdsa.cc', '18655554444', '2015-08-29 09:58:13', '-1', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('53', 'asdf1112asdf', '12121212', '333333333333333333', 'f914fc8df6080596799786fad624e03e432efc3e', '13313@111.com', '13333333333', '2015-08-29 22:57:34', '-1', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('54', 'zhaobenshan', '赵本山', '444444444444444444', '3479d50dd85dbed02e65cde072ee1244e2bbf1ef', '3333@222.com', '13333333333', '2015-08-29 23:21:01', '1', '1', '0', null, null, null, '');
INSERT INTO `et_user` VALUES ('55', 'songzy', '宋祖英', '444444444444444444', '297a5e987898e080f32b1f2249fc38c206cb2d87', '4444@222.com', '13333333333', '2015-08-29 23:29:55', '1', '1', '0', null, null, null, '');

-- ----------------------------
-- Table structure for `et_user_2_department`
-- ----------------------------
DROP TABLE IF EXISTS `et_user_2_department`;
CREATE TABLE `et_user_2_department` (
  `user_id` int(11) NOT NULL,
  `dep_id` int(11) NOT NULL,
  KEY `fk_ud_uid` (`user_id`),
  KEY `fk_ud_did` (`dep_id`),
  CONSTRAINT `fk_ud_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ud_did` FOREIGN KEY (`dep_id`) REFERENCES `et_department` (`dep_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_2_department
-- ----------------------------
INSERT INTO `et_user_2_department` VALUES ('53', '2');
INSERT INTO `et_user_2_department` VALUES ('54', '2');
INSERT INTO `et_user_2_department` VALUES ('48', '2');
INSERT INTO `et_user_2_department` VALUES ('29', '4');
INSERT INTO `et_user_2_department` VALUES ('30', '1');
INSERT INTO `et_user_2_department` VALUES ('36', '1');
INSERT INTO `et_user_2_department` VALUES ('38', '1');
INSERT INTO `et_user_2_department` VALUES ('42', '4');
INSERT INTO `et_user_2_department` VALUES ('43', '4');
INSERT INTO `et_user_2_department` VALUES ('37', '2');

-- ----------------------------
-- Table structure for `et_user_2_group`
-- ----------------------------
DROP TABLE IF EXISTS `et_user_2_group`;
CREATE TABLE `et_user_2_group` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_admin` tinyint(4) DEFAULT '0',
  UNIQUE KEY `idx_user_guid` (`group_id`,`user_id`) USING BTREE,
  KEY `idx_user_gid` (`group_id`),
  KEY `idx_user_uid` (`user_id`),
  CONSTRAINT `fk_et_user_group_et_group_1` FOREIGN KEY (`group_id`) REFERENCES `et_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_et_user_group_et_user_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_2_group
-- ----------------------------
INSERT INTO `et_user_2_group` VALUES ('34', '29', '2015-08-25 21:27:46', '0');
INSERT INTO `et_user_2_group` VALUES ('47', '36', '2015-08-25 21:28:26', '0');
INSERT INTO `et_user_2_group` VALUES ('52', '34', '2015-08-25 21:27:53', '0');
INSERT INTO `et_user_2_group` VALUES ('57', '50', '2015-08-28 21:28:59', '0');
INSERT INTO `et_user_2_group` VALUES ('59', '35', '2015-08-25 21:20:39', '0');
INSERT INTO `et_user_2_group` VALUES ('61', '50', '2015-08-29 09:40:30', '0');

-- ----------------------------
-- Table structure for `et_user_2_role`
-- ----------------------------
DROP TABLE IF EXISTS `et_user_2_role`;
CREATE TABLE `et_user_2_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `et_r_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`),
  CONSTRAINT `fk_user_rid` FOREIGN KEY (`role_id`) REFERENCES `et_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_2_role
-- ----------------------------
INSERT INTO `et_user_2_role` VALUES ('1', '1');
INSERT INTO `et_user_2_role` VALUES ('5', '2');
INSERT INTO `et_user_2_role` VALUES ('6', '2');
INSERT INTO `et_user_2_role` VALUES ('29', '3');
INSERT INTO `et_user_2_role` VALUES ('30', '3');
INSERT INTO `et_user_2_role` VALUES ('34', '3');
INSERT INTO `et_user_2_role` VALUES ('35', '3');
INSERT INTO `et_user_2_role` VALUES ('36', '3');
INSERT INTO `et_user_2_role` VALUES ('37', '3');
INSERT INTO `et_user_2_role` VALUES ('38', '2');
INSERT INTO `et_user_2_role` VALUES ('40', '2');
INSERT INTO `et_user_2_role` VALUES ('41', '2');
INSERT INTO `et_user_2_role` VALUES ('42', '2');
INSERT INTO `et_user_2_role` VALUES ('43', '3');
INSERT INTO `et_user_2_role` VALUES ('44', '2');
INSERT INTO `et_user_2_role` VALUES ('45', '2');
INSERT INTO `et_user_2_role` VALUES ('46', '2');
INSERT INTO `et_user_2_role` VALUES ('47', '2');
INSERT INTO `et_user_2_role` VALUES ('48', '2');
INSERT INTO `et_user_2_role` VALUES ('49', '3');
INSERT INTO `et_user_2_role` VALUES ('50', '3');
INSERT INTO `et_user_2_role` VALUES ('51', '3');
INSERT INTO `et_user_2_role` VALUES ('53', '3');
INSERT INTO `et_user_2_role` VALUES ('54', '2');
INSERT INTO `et_user_2_role` VALUES ('55', '3');

-- ----------------------------
-- Table structure for `et_user_exam_history`
-- ----------------------------
DROP TABLE IF EXISTS `et_user_exam_history`;
CREATE TABLE `et_user_exam_history` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) NOT NULL,
  `exam_paper_id` int(10) NOT NULL,
  `enabled` tinyint(4) DEFAULT NULL,
  `point` int(5) DEFAULT '0',
  `seri_no` varchar(30) NOT NULL,
  `content` mediumtext,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `answer_sheet` mediumtext,
  `duration` int(10) NOT NULL,
  `point_get` float(10,1) NOT NULL DEFAULT '0.0',
  `submit_time` timestamp NULL DEFAULT NULL,
  `mark` tinyint(4) DEFAULT '0',
  `verify_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_exam_his_seri_no` (`seri_no`),
  UNIQUE KEY `idx_exam_pid` (`exam_id`,`exam_paper_id`),
  KEY `fk_exam_his_uid` (`user_id`),
  KEY `fk_exam_paper_id` (`exam_paper_id`),
  CONSTRAINT `fk_exam_his_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`),
  CONSTRAINT `fk_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `et_exam` (`id`),
  CONSTRAINT `fk_exam_paper_id` FOREIGN KEY (`exam_paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_exam_history
-- ----------------------------

-- ----------------------------
-- Table structure for `et_user_question_history`
-- ----------------------------
DROP TABLE IF EXISTS `et_user_question_history`;
CREATE TABLE `et_user_question_history` (
  `hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `right_times` int(10) NOT NULL DEFAULT '0',
  `wrong_times` int(10) NOT NULL DEFAULT '0',
  `last_status` tinyint(1) NOT NULL DEFAULT '0',
  `modify_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hist_id`),
  UNIQUE KEY `idx_u_q_hist_userid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_question_history
-- ----------------------------

-- ----------------------------
-- Table structure for `t_c3p0`
-- ----------------------------
DROP TABLE IF EXISTS `t_c3p0`;
CREATE TABLE `t_c3p0` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_c3p0
-- ----------------------------
