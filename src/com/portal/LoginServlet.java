package com.portal;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int SESSION_TIMEOUT_SECONDS = 15 * 60;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Student student = UserStore.authenticate(username, password);

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
            return;
        }

        // Replace any pre-login session ID to reduce session-fixation risk.
        HttpSession existingSession = request.getSession(false);
        if (existingSession != null) {
            existingSession.invalidate();
        }
        HttpSession session = request.getSession(true);
        request.changeSessionId();
        session.setAttribute("student", student);
        session.setAttribute("loginTime", System.currentTimeMillis());
        session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);

        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
    }
}
