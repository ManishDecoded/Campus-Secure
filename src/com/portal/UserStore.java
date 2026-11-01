package com.portal;

import java.security.GeneralSecurityException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * In-memory account store for this academic demonstration.
 * Accounts are cleared when the web application is restarted.
 */
public final class UserStore {
    private static final Map<String, Student> STUDENTS = new ConcurrentHashMap<>();

    static {
        try {
            Student demo = new Student(
                    "Demo Student", "CU-DEMO-001", "student@example.com",
                    "MCA (AI & ML)", "student", PasswordUtil.hash("Student@123"));
            STUDENTS.put(demo.getUsername().toLowerCase(), demo);
        } catch (GeneralSecurityException ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    private UserStore() { }

    /** Returns null when registration succeeds, otherwise an error message. */
    public static synchronized String register(String fullName, String studentId,
            String email, String course, String username, String password) {
        String key = username.toLowerCase();
        if (STUDENTS.containsKey(key)) {
            return "That username is already registered. Please choose another.";
        }

        for (Student existing : STUDENTS.values()) {
            if (existing.getStudentId().equalsIgnoreCase(studentId)) {
                return "That student ID is already registered.";
            }
            if (existing.getEmail().equalsIgnoreCase(email)) {
                return "That email address is already registered.";
            }
        }

        try {
            Student student = new Student(fullName, studentId, email, course,
                    username, PasswordUtil.hash(password));
            STUDENTS.put(key, student);
            return null;
        } catch (GeneralSecurityException ex) {
            return "The account could not be created. Please try again.";
        }
    }

    /** Returns the matching profile only when the credentials are valid. */
    public static Student authenticate(String username, String password) {
        if (username == null || password == null) return null;
        Student student = STUDENTS.get(username.trim().toLowerCase());
        if (student != null && PasswordUtil.verify(password, student.getPasswordHash())) {
            return student;
        }
        return null;
    }
}
