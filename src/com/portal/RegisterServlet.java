package com.portal;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = clean(request.getParameter("fullName"));
        String studentId = clean(request.getParameter("studentId"));
        String email = clean(request.getParameter("email")).toLowerCase();
        String course = clean(request.getParameter("course"));
        String username = clean(request.getParameter("username"));
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String error = validate(fullName, studentId, email, course, username,
                password, confirmPassword);
        if (error == null) {
            error = UserStore.register(fullName, studentId, email, course,
                    username, password);
        }

        if (error != null) {
            request.setAttribute("errorMessage", error);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
    }

    private String validate(String fullName, String studentId, String email,
            String course, String username, String password, String confirmPassword) {
        if (fullName.isEmpty() || studentId.isEmpty() || email.isEmpty()
                || course.isEmpty() || username.isEmpty()
                || password == null || password.isEmpty()) {
            return "Please complete all registration fields.";
        }
        if (fullName.length() > 80 || studentId.length() > 30
                || email.length() > 100 || course.length() > 80) {
            return "One or more fields exceed the allowed length.";
        }
        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            return "Please enter a valid email address.";
        }
        if (!username.matches("[A-Za-z0-9._-]{4,20}")) {
            return "Username must be 4–20 characters (letters, numbers, dot, underscore or hyphen).";
        }
        if (password.length() < 8 || password.length() > 128) {
            return "Password must contain between 8 and 128 characters.";
        }
        if (!password.equals(confirmPassword)) {
            return "Password and confirm password do not match.";
        }
        return null;
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }
}
