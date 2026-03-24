package org.shiuintw.coursemanagementsystem.mapper;

import org.shiuintw.coursemanagementsystem.model.Course;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class CourseResultSetExtractor implements ResultSetExtractor<List<Course>> {

    private static void addIfNotNull(List<String> list, String value) {
        if (value != null && !value.isEmpty()) list.add(value);
    }

    @Override
    public List<Course> extractData(ResultSet rs) throws SQLException, DataAccessException {
        Map<String, Course> courseMap = new LinkedHashMap<>();

        while (rs.next()) {
            String id = rs.getString("id");
            if (courseMap.containsKey(id)) {
                Course course = courseMap.get(id);
                addIfNotNull(course.getTime(),         rs.getString("time"));
                addIfNotNull(course.getClassroom(),    rs.getString("classroom"));
                addIfNotNull(course.getInstructorId(), rs.getString("instructor_id"));
                addIfNotNull(course.getCategory(),     rs.getString("category"));
            } else {
                Course course = new Course();
                course.setId(id);
                course.setName(rs.getString("name"));
                course.setCredit(rs.getInt("credit"));
                course.setHours(rs.getInt("hours"));
                course.setMaxStudentNumber(rs.getInt("max_student_number"));
                course.setBuildingId(rs.getString("building_id"));
                course.setTime(new ArrayList<>());
                course.setClassroom(new ArrayList<>());
                course.setInstructorId(new ArrayList<>());
                course.setCategory(new ArrayList<>());
                addIfNotNull(course.getTime(),         rs.getString("time"));
                addIfNotNull(course.getClassroom(),    rs.getString("classroom"));
                addIfNotNull(course.getInstructorId(), rs.getString("instructor_id"));
                addIfNotNull(course.getCategory(),     rs.getString("category"));
                courseMap.put(id, course);
            }
        }

        for (Course c : courseMap.values()) {
            c.setTime(new ArrayList<>(new LinkedHashSet<>(c.getTime())));
            c.setClassroom(new ArrayList<>(new LinkedHashSet<>(c.getClassroom())));
            c.setInstructorId(new ArrayList<>(new LinkedHashSet<>(c.getInstructorId())));
            c.setCategory(new ArrayList<>(new LinkedHashSet<>(c.getCategory())));
        }
        return new ArrayList<>(courseMap.values());
    }
}
