-- =============================================
-- Course Management System — H2 Schema
-- =============================================

CREATE TABLE IF NOT EXISTS building (
    id   VARCHAR(20)  NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS department (
    id          VARCHAR(20)  NOT NULL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    building_id VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS instructor (
    id             VARCHAR(20)  NOT NULL PRIMARY KEY,
    department_id  VARCHAR(20),
    Chinese_name   VARCHAR(100),
    English_name   VARCHAR(100),
    image          VARCHAR(255),
    title          VARCHAR(50),
    degree         VARCHAR(100),
    research_field VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS users (
    id            VARCHAR(20)  NOT NULL PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    department_id VARCHAR(20),
    password      VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS course (
    id                 VARCHAR(20)  NOT NULL PRIMARY KEY,
    name               VARCHAR(200) NOT NULL,
    credit             INT          NOT NULL,
    hours              INT          NOT NULL,
    max_student_number INT          NOT NULL,
    building_id        VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS course_time (
    id     VARCHAR(20) NOT NULL,
    `time` VARCHAR(10) NOT NULL,
    PRIMARY KEY (id, `time`)
);

CREATE TABLE IF NOT EXISTS course_classroom (
    id        VARCHAR(20) NOT NULL,
    classroom VARCHAR(20) NOT NULL,
    PRIMARY KEY (id, classroom)
);

CREATE TABLE IF NOT EXISTS course_instructor_id (
    id            VARCHAR(20) NOT NULL,
    instructor_id VARCHAR(20) NOT NULL,
    PRIMARY KEY (id, instructor_id)
);

CREATE TABLE IF NOT EXISTS course_category (
    id       VARCHAR(20)  NOT NULL,
    category VARCHAR(100) NOT NULL,
    PRIMARY KEY (id, category)
);

CREATE TABLE IF NOT EXISTS take (
    user_id   VARCHAR(20) NOT NULL,
    course_id VARCHAR(20) NOT NULL,
    `time`    VARCHAR(50),
    score     VARCHAR(10),
    PRIMARY KEY (user_id, course_id)
);

CREATE TABLE IF NOT EXISTS minimum_credit (
    department_id                                              VARCHAR(20) NOT NULL PRIMARY KEY,
    basic_science                                              INT DEFAULT 0,
    compulsory_course                                          INT DEFAULT 0,
    elective_program_course                                    INT DEFAULT 0,
    elective_professional_course                               INT DEFAULT 0,
    free_elective_course                                       INT DEFAULT 0,
    cross_disciplinary_program                                 INT DEFAULT 0,
    school_basic_core_curriculum_course                        INT DEFAULT 0,
    school_domain_core_curriculum_course                       INT DEFAULT 0,
    school_language_course                                     INT DEFAULT 0,
    school_pe_course                                           INT DEFAULT 0,
    school_service_learning_course                             INT DEFAULT 0,
    school_student_academic_research_ethics_education_course   INT DEFAULT 0,
    school_online_gender_equality_education_course             INT DEFAULT 0
);
