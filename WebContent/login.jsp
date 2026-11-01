<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.portal.HtmlUtil" %>
<%
    if (session.getAttribute("student") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login | CampusSecure</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; min-height: 100vh; font-family: Arial, sans-serif; color: #172033;
               background: linear-gradient(135deg, #edf4ff, #f7f8fc); display: grid; place-items: center; padding: 24px; }
        .layout { width: min(940px, 100%); display: grid; grid-template-columns: 1fr 1fr; background: #fff;
                  border-radius: 20px; overflow: hidden; box-shadow: 0 20px 55px rgba(20, 45, 90, .12); }
        .intro { padding: 52px 42px; color: #fff; background: linear-gradient(145deg, #123b75, #1764aa); display: flex; flex-direction: column; justify-content: center; }
        .mark { width: 48px; height: 48px; border: 1px solid rgba(255,255,255,.5); border-radius: 14px; display: grid; place-items: center; font-size: 23px; font-weight: bold; }
        .intro h1 { font-size: 30px; line-height: 1.2; margin: 28px 0 12px; }
        .intro p { color: #d8e8ff; line-height: 1.7; margin: 0; }
        .features { margin-top: 32px; padding: 0; list-style: none; color: #e7f1ff; line-height: 2.2; font-size: 14px; }
        .form-panel { padding: 48px 42px; }
        h2 { margin: 0 0 8px; font-size: 25px; }
        .muted { margin: 0 0 27px; color: #6b7280; font-size: 14px; }
        label { display: block; margin: 17px 0 7px; font-size: 13px; font-weight: 700; color: #374151; }
        input { width: 100%; padding: 13px 14px; border: 1px solid #d8deea; border-radius: 9px; font-size: 14px; outline: none; }
        input:focus { border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37,99,235,.1); }
        button { width: 100%; border: 0; border-radius: 9px; padding: 14px; margin-top: 24px; background: #1764aa; color: #fff; font-size: 15px; font-weight: 700; cursor: pointer; }
        button:hover { background: #124f8b; }
        .message { padding: 11px 13px; border-radius: 8px; font-size: 13px; line-height: 1.5; margin: 14px 0; }
        .error { background: #fff0f0; color: #b42318; }
        .success { background: #ecfdf3; color: #067647; }
        .demo { background: #f1f6ff; color: #31527d; border: 1px solid #dce9fb; padding: 12px; border-radius: 9px; font-size: 12px; line-height: 1.7; margin-top: 20px; }
        .foot { text-align: center; color: #6b7280; font-size: 13px; margin-top: 22px; }
        a { color: #1764aa; text-decoration: none; font-weight: 700; }
        @media (max-width: 700px) { .layout { grid-template-columns: 1fr; } .intro { padding: 30px; } .intro h1 { margin-top: 16px; font-size: 25px; } .features { display: none; } .form-panel { padding: 32px 26px; } }
    </style>
</head>
<body>
<div class="layout">
    <section class="intro">
        <div class="mark">C</div>
        <h1>CampusSecure</h1>
        <p>A simple and secure student access portal demonstrating authentication and HTTP session management.</p>
        <ul class="features">
            <li>✓ Student account registration</li>
            <li>✓ Credential verification</li>
            <li>✓ Protected student dashboard</li>
            <li>✓ Automatic session expiry</li>
        </ul>
    </section>
    <main class="form-panel">
        <h2>Welcome back</h2>
        <p class="muted">Sign in with your student account to continue.</p>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="message error">Invalid username or password. Please try again.</div>
        <% } %>
        <% if ("1".equals(request.getParameter("registered"))) { %>
            <div class="message success">Registration completed. You can now sign in.</div>
        <% } %>
        <% if ("1".equals(request.getParameter("logout"))) { %>
            <div class="message success">You have been logged out and your session has been ended.</div>
        <% } %>
        <% if ("1".equals(request.getParameter("expired"))) { %>
            <div class="message error">Your session has expired or you are not signed in. Please log in again.</div>
        <% } %>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <label for="username">Username</label>
            <input id="username" name="username" type="text" autocomplete="username" required maxlength="20">
            <label for="password">Password</label>
            <input id="password" name="password" type="password" autocomplete="current-password" required>
            <button type="submit">Sign in securely</button>
        </form>
        <div class="demo"><strong>Demo account</strong><br>Username: student<br>Password: Student@123</div>
        <div class="foot">New student? <a href="${pageContext.request.contextPath}/register.jsp">Create an account</a></div>
    </main>
</div>
</body>
</html>
