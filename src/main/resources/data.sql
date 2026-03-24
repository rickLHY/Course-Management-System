-- =============================================
-- Course Management System — Mock Data
-- =============================================

-- Buildings
INSERT INTO building(id, name) VALUES ('B01', '工程館');
INSERT INTO building(id, name) VALUES ('B02', '理學院');
INSERT INTO building(id, name) VALUES ('B03', '人文大樓');

-- Departments
INSERT INTO department(id, name, building_id) VALUES ('CS',  '資訊工程學系', 'B01');
INSERT INTO department(id, name, building_id) VALUES ('EE',  '電機工程學系', 'B01');
INSERT INTO department(id, name, building_id) VALUES ('ME',  '機械工程學系', 'B02');

-- Instructors
INSERT INTO instructor(id, department_id, Chinese_name, English_name, title, degree, research_field)
    VALUES ('T001', 'CS', '陳大文', 'David Chen',   '教授',   'Ph.D. MIT',         '人工智慧, 機器學習');
INSERT INTO instructor(id, department_id, Chinese_name, English_name, title, degree, research_field)
    VALUES ('T002', 'CS', '李小華', 'Alice Lee',    '副教授', 'Ph.D. Stanford',    '資料庫, 大數據');
INSERT INTO instructor(id, department_id, Chinese_name, English_name, title, degree, research_field)
    VALUES ('T003', 'EE', '王志明', 'Michael Wang', '教授',   'Ph.D. NTU',         '嵌入式系統, IoT');
INSERT INTO instructor(id, department_id, Chinese_name, English_name, title, degree, research_field)
    VALUES ('T004', 'ME', '林美麗', 'Emily Lin',    '助理教授', 'Ph.D. NCKU',       '熱流, 能源');

-- Users (password = MD5("password") = 5f4dcc3b5aa765d61d8327deb882cf99)
INSERT INTO users(id, name, department_id, password)
    VALUES ('demo',      '示範學生',   'CS', '5f4dcc3b5aa765d61d8327deb882cf99');
INSERT INTO users(id, name, department_id, password)
    VALUES ('B11234567', '張小明',     'EE', '5f4dcc3b5aa765d61d8327deb882cf99');

-- Courses
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('CS101', '程式設計',         3, 3, 60, 'B01');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('CS201', '資料結構',         3, 3, 50, 'B01');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('CS301', '機器學習導論',     3, 3, 40, 'B01');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('CS302', '資料庫系統',       3, 3, 45, 'B01');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('MATH101', '線性代數',       3, 3, 80, 'B02');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('MATH102', '微積分',         4, 4, 100, 'B02');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('EE201', '電路學',           3, 3, 50, 'B01');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('GE001', '英文寫作',         2, 2, 30, 'B03');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('PE001', '體育',             1, 2, 50, 'B03');
INSERT INTO course(id, name, credit, hours, max_student_number, building_id)
    VALUES ('SE001', '服務學習',         0, 1, 60, 'B03');

-- Course times
INSERT INTO course_time(id, `time`) VALUES ('CS101',   'M1');
INSERT INTO course_time(id, `time`) VALUES ('CS101',   'M2');
INSERT INTO course_time(id, `time`) VALUES ('CS101',   'M3');
INSERT INTO course_time(id, `time`) VALUES ('CS201',   'T1');
INSERT INTO course_time(id, `time`) VALUES ('CS201',   'T2');
INSERT INTO course_time(id, `time`) VALUES ('CS201',   'T3');
INSERT INTO course_time(id, `time`) VALUES ('CS301',   'W3');
INSERT INTO course_time(id, `time`) VALUES ('CS301',   'W4');
INSERT INTO course_time(id, `time`) VALUES ('CS301',   'W5');
INSERT INTO course_time(id, `time`) VALUES ('CS302',   'R1');
INSERT INTO course_time(id, `time`) VALUES ('CS302',   'R2');
INSERT INTO course_time(id, `time`) VALUES ('CS302',   'R3');
INSERT INTO course_time(id, `time`) VALUES ('MATH101', 'F1');
INSERT INTO course_time(id, `time`) VALUES ('MATH101', 'F2');
INSERT INTO course_time(id, `time`) VALUES ('MATH101', 'F3');
INSERT INTO course_time(id, `time`) VALUES ('MATH102', 'M6');
INSERT INTO course_time(id, `time`) VALUES ('MATH102', 'M7');
INSERT INTO course_time(id, `time`) VALUES ('MATH102', 'M8');
INSERT INTO course_time(id, `time`) VALUES ('MATH102', 'M9');
INSERT INTO course_time(id, `time`) VALUES ('EE201',   'T6');
INSERT INTO course_time(id, `time`) VALUES ('EE201',   'T7');
INSERT INTO course_time(id, `time`) VALUES ('EE201',   'T8');
INSERT INTO course_time(id, `time`) VALUES ('GE001',   'W6');
INSERT INTO course_time(id, `time`) VALUES ('GE001',   'W7');
INSERT INTO course_time(id, `time`) VALUES ('PE001',   'F6');
INSERT INTO course_time(id, `time`) VALUES ('PE001',   'F7');
INSERT INTO course_time(id, `time`) VALUES ('SE001',   'S1');

-- Course classrooms
INSERT INTO course_classroom(id, classroom) VALUES ('CS101',   'A101');
INSERT INTO course_classroom(id, classroom) VALUES ('CS201',   'A102');
INSERT INTO course_classroom(id, classroom) VALUES ('CS301',   'A201');
INSERT INTO course_classroom(id, classroom) VALUES ('CS302',   'A202');
INSERT INTO course_classroom(id, classroom) VALUES ('MATH101', 'B101');
INSERT INTO course_classroom(id, classroom) VALUES ('MATH102', 'B102');
INSERT INTO course_classroom(id, classroom) VALUES ('EE201',   'A301');
INSERT INTO course_classroom(id, classroom) VALUES ('GE001',   'C101');
INSERT INTO course_classroom(id, classroom) VALUES ('PE001',   'GYM');
INSERT INTO course_classroom(id, classroom) VALUES ('SE001',   'C201');

-- Course instructors
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('CS101',   'T002');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('CS201',   'T002');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('CS301',   'T001');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('CS302',   'T002');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('MATH101', 'T001');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('MATH102', 'T001');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('EE201',   'T003');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('GE001',   'T004');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('PE001',   'T004');
INSERT INTO course_instructor_id(id, instructor_id) VALUES ('SE001',   'T004');

-- Course categories
INSERT INTO course_category(id, category) VALUES ('CS101',   'compulsory_course');
INSERT INTO course_category(id, category) VALUES ('CS201',   'compulsory_course');
INSERT INTO course_category(id, category) VALUES ('CS301',   'elective_program_course');
INSERT INTO course_category(id, category) VALUES ('CS302',   'elective_program_course');
INSERT INTO course_category(id, category) VALUES ('MATH101', 'basic_science');
INSERT INTO course_category(id, category) VALUES ('MATH102', 'basic_science');
INSERT INTO course_category(id, category) VALUES ('EE201',   'elective_professional_course');
INSERT INTO course_category(id, category) VALUES ('GE001',   'school_language_course');
INSERT INTO course_category(id, category) VALUES ('PE001',   'school_pe_course');
INSERT INTO course_category(id, category) VALUES ('SE001',   'school_service_learning_course');

-- Pre-enrolled courses for demo user
INSERT INTO take(user_id, course_id, `time`, score) VALUES ('demo', 'CS101', '2024-02', 'A');
INSERT INTO take(user_id, course_id, `time`, score) VALUES ('demo', 'MATH102', '2024-02', 'B+');

-- Minimum credits per department (CS)
INSERT INTO minimum_credit VALUES ('CS',
    6,   -- basic_science
    9,   -- compulsory_course
    9,   -- elective_program_course
    6,   -- elective_professional_course
    6,   -- free_elective_course
    3,   -- cross_disciplinary_program
    2,   -- school_basic_core_curriculum_course
    2,   -- school_domain_core_curriculum_course
    4,   -- school_language_course
    2,   -- school_pe_course
    0,   -- school_service_learning_course
    1,   -- school_student_academic_research_ethics_education_course
    1    -- school_online_gender_equality_education_course
);

-- Minimum credits per department (EE)
INSERT INTO minimum_credit VALUES ('EE',
    6,   -- basic_science
    12,  -- compulsory_course
    6,   -- elective_program_course
    6,   -- elective_professional_course
    6,   -- free_elective_course
    3,   -- cross_disciplinary_program
    2,   -- school_basic_core_curriculum_course
    2,   -- school_domain_core_curriculum_course
    4,   -- school_language_course
    2,   -- school_pe_course
    0,   -- school_service_learning_course
    1,   -- school_student_academic_research_ethics_education_course
    1    -- school_online_gender_equality_education_course
);

-- Minimum credits per department (ME)
INSERT INTO minimum_credit VALUES ('ME',
    9,   -- basic_science
    9,   -- compulsory_course
    6,   -- elective_program_course
    6,   -- elective_professional_course
    6,   -- free_elective_course
    3,   -- cross_disciplinary_program
    2,   -- school_basic_core_curriculum_course
    2,   -- school_domain_core_curriculum_course
    4,   -- school_language_course
    2,   -- school_pe_course
    0,   -- school_service_learning_course
    1,   -- school_student_academic_research_ethics_education_course
    1    -- school_online_gender_equality_education_course
);
