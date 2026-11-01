package com.portal;

/** Holds the student profile associated with an authenticated account. */
public final class Student {
    private final String fullName;
    private final String studentId;
    private final String email;
    private final String course;
    private final String username;
    private final String passwordHash;

    Student(String fullName, String studentId, String email, String course,
            String username, String passwordHash) {
        this.fullName = fullName;
        this.studentId = studentId;
        this.email = email;
        this.course = course;
        this.username = username;
        this.passwordHash = passwordHash;
    }

    public String getFullName() { return fullName; }
    public String getStudentId() { return studentId; }
    public String getEmail() { return email; }
    public String getCourse() { return course; }
    public String getUsername() { return username; }

    String getPasswordHash() { return passwordHash; }
}
