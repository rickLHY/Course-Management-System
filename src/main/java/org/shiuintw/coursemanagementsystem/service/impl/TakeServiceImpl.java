package org.shiuintw.coursemanagementsystem.service.impl;

import org.shiuintw.coursemanagementsystem.dao.CourseDao;
import org.shiuintw.coursemanagementsystem.dao.TakeDao;
import org.shiuintw.coursemanagementsystem.model.Course;
import org.shiuintw.coursemanagementsystem.model.MinimumCredit;
import org.shiuintw.coursemanagementsystem.model.Take;
import org.shiuintw.coursemanagementsystem.service.TakeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.function.BiConsumer;
import java.util.function.Function;

@Component
public class TakeServiceImpl implements TakeService {
    private final TakeDao takeDao;
    private final CourseDao courseDao;

    @Autowired
    public TakeServiceImpl(TakeDao takeDao, CourseDao courseDao) {
        this.takeDao = takeDao;
        this.courseDao = courseDao;
    }

    @Override
    public Take getTakeById(String userId, String courseId) {
        return takeDao.getTakeById(userId, courseId);
    }

    @Override
    public boolean createTake(Take take) {
        Take cTake = takeDao.getTakeById(take.getUserId(), take.getCourseId());
        if (cTake != null) return false;
        takeDao.createTake(take);
        return true;
    }

    @Override
    public void updateTake(Take take) {
        takeDao.updateTake(take);
    }

    @Override
    public void deleteTakeById(String userId, String courseId) {
        takeDao.deleteTakeById(userId, courseId);
    }

    @Override
    public List<Take> getTakesByUserId(String userId) {
        return takeDao.getTakesByUserId(userId);
    }

    @Override
    public void deleteTakesByUserId(String userId) {
        takeDao.deleteTakesByUserId(userId);
    }

    // credit
    // --- util
    private static class EmbedCourse {
        Course course;
        boolean valid;
        EmbedCourse(Course course) {
            this.course = course;
            this.valid = true;
        }
    }

    private static final Map<String, Function<MinimumCredit, Integer>> CREDIT_GETTERS;
    private static final Map<String, BiConsumer<MinimumCredit, Integer>> CREDIT_SETTERS;

    static {
        CREDIT_GETTERS = new LinkedHashMap<>();
        CREDIT_GETTERS.put("basic_science",                                          MinimumCredit::getBasicScience);
        CREDIT_GETTERS.put("compulsory_course",                                      MinimumCredit::getCompulsoryCourse);
        CREDIT_GETTERS.put("elective_program_course",                                MinimumCredit::getElectiveProgramCourse);
        CREDIT_GETTERS.put("elective_professional_course",                           MinimumCredit::getElectiveProfessionalCourse);
        CREDIT_GETTERS.put("free_elective_course",                                   MinimumCredit::getFreeElectiveCourse);
        CREDIT_GETTERS.put("cross_disciplinary_program",                             MinimumCredit::getCrossDisciplinaryProgram);
        CREDIT_GETTERS.put("school_basic_core_curriculum_course",                    MinimumCredit::getSchoolBasicCoreCurriculumCourse);
        CREDIT_GETTERS.put("school_domain_core_curriculum_course",                   MinimumCredit::getSchoolDomainCoreCurriculumCourse);
        CREDIT_GETTERS.put("school_language_course",                                 MinimumCredit::getSchoolLanguageCourse);
        CREDIT_GETTERS.put("school_pe_course",                                       MinimumCredit::getSchoolPeCourse);
        CREDIT_GETTERS.put("school_service_learning_course",                         MinimumCredit::getSchoolServiceLearningCourse);
        CREDIT_GETTERS.put("school_student_academic_research_ethics_education_course", MinimumCredit::getSchoolStudentAcademicResearchEthicsEducationCourse);
        CREDIT_GETTERS.put("school_online_gender_equality_education_course",         MinimumCredit::getSchoolOnlineGenderEqualityEducationCourse);

        CREDIT_SETTERS = new LinkedHashMap<>();
        CREDIT_SETTERS.put("basic_science",                                          MinimumCredit::setBasicScience);
        CREDIT_SETTERS.put("compulsory_course",                                      MinimumCredit::setCompulsoryCourse);
        CREDIT_SETTERS.put("elective_program_course",                                MinimumCredit::setElectiveProgramCourse);
        CREDIT_SETTERS.put("elective_professional_course",                           MinimumCredit::setElectiveProfessionalCourse);
        CREDIT_SETTERS.put("free_elective_course",                                   MinimumCredit::setFreeElectiveCourse);
        CREDIT_SETTERS.put("cross_disciplinary_program",                             MinimumCredit::setCrossDisciplinaryProgram);
        CREDIT_SETTERS.put("school_basic_core_curriculum_course",                    MinimumCredit::setSchoolBasicCoreCurriculumCourse);
        CREDIT_SETTERS.put("school_domain_core_curriculum_course",                   MinimumCredit::setSchoolDomainCoreCurriculumCourse);
        CREDIT_SETTERS.put("school_language_course",                                 MinimumCredit::setSchoolLanguageCourse);
        CREDIT_SETTERS.put("school_pe_course",                                       MinimumCredit::setSchoolPeCourse);
        CREDIT_SETTERS.put("school_service_learning_course",                         MinimumCredit::setSchoolServiceLearningCourse);
        CREDIT_SETTERS.put("school_student_academic_research_ethics_education_course", MinimumCredit::setSchoolStudentAcademicResearchEthicsEducationCourse);
        CREDIT_SETTERS.put("school_online_gender_equality_education_course",         MinimumCredit::setSchoolOnlineGenderEqualityEducationCourse);
    }
    // --- end of util

    @Override
    public MinimumCredit getCredit(String userId, MinimumCredit minimumCredit) {
        List<String> programOrder = new ArrayList<>(CREDIT_GETTERS.keySet());

        List<Take> takeList = takeDao.getTakesByUserId(userId);
        Map<String, List<EmbedCourse>> map = new HashMap<>();
        for (String s : programOrder) {
            map.put(s, new ArrayList<>());
        }

        for (Take take : takeList) {
            Course course = courseDao.getCourseById(take.getCourseId());
            if (course == null) continue;
            EmbedCourse embedCourse = new EmbedCourse(course);
            for (String category : embedCourse.course.getCategory()) {
                if (category != null && !category.isEmpty() && map.containsKey(category))
                    map.get(category).add(embedCourse);
            }
        }

        // sort by credit ascending
        for (List<EmbedCourse> embedCourseList : map.values()) {
            embedCourseList.sort((o1, o2) -> o1.course.getCredit() - o2.course.getCredit());
        }

        MinimumCredit userCredit = new MinimumCredit();

        // Pass 1: fill up to minimum requirement for each category
        for (String po : programOrder) {
            Function<MinimumCredit, Integer> getter = CREDIT_GETTERS.get(po);
            BiConsumer<MinimumCredit, Integer> setter = CREDIT_SETTERS.get(po);
            for (EmbedCourse embedCourse : map.get(po)) {
                if (!embedCourse.valid) continue;
                if (getter.apply(userCredit) >= getter.apply(minimumCredit)) break;
                embedCourse.valid = false;
                setter.accept(userCredit, getter.apply(userCredit) + embedCourse.course.getCredit());
            }
        }

        // Pass 2: accumulate remaining valid courses (overflow beyond minimum)
        for (String po : programOrder) {
            Function<MinimumCredit, Integer> getter = CREDIT_GETTERS.get(po);
            BiConsumer<MinimumCredit, Integer> setter = CREDIT_SETTERS.get(po);
            for (EmbedCourse embedCourse : map.get(po)) {
                if (!embedCourse.valid) continue;
                embedCourse.valid = false;
                setter.accept(userCredit, getter.apply(userCredit) + embedCourse.course.getCredit());
            }
        }

        return userCredit;
    }
}
