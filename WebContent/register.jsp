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
    <title>Student Registration | CampusSecure</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; min-height: 100vh; padding: 28px 16px; font-family: Arial, sans-serif; background: #f1f5fb; color: #172033; display: grid; place-items: center; }
        .card { width: min(650px, 100%); background: #fff; border-radius: 17px; padding: 34px 38px; box-shadow: 0 16px 45px rgba(25,45,80,.1); }
        .eyebrow { color: #1764aa; font-size: 12px; font-weight: 700; letter-spacing: 1.3px; text-transform: uppercase; }
        h1 { margin: 9px 0 8px; font-size: 27px; }
        .sub { color: #6b7280; font-size: 14px; margin: 0 0 24px; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0 17px; }
        label { display: block; margin: 13px 0 7px; color: #374151; font-weight: 700; font-size: 13px; }
        input { width: 100%; border: 1px solid #d8deea; border-radius: 8px; padding: 12px 13px; outline: none; font-size: 14px; }
        input:focus { border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37,99,235,.1); }
        .hint { color: #7b8494; font-size: 12px; margin-top: 6px; }
        button { width: 100%; margin-top: 25px; padding: 14px; background: #1764aa; color: white; border: 0; border-radius: 9px; font-size: 15px; font-weight: 700; cursor: pointer; }
        button:hover { background: #124f8b; }
        .error { background: #fff0f0; color: #b42318; padding: 11px 13px; border-radius: 8px; font-size: 13px; line-height: 1.5; }
        .foot { text-align: center; color: #6b7280; font-size: 13px; margin-top: 20px; }
        a { color: #1764aa; text-decoration: none; font-weight: 700; }
        @media(max-width: 560px) { .card { padding: 27px 21px; } .grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
<div class="card">
    <div class="eyebrow">CampusSecure · Student Portal</div>
    <h1>Create your student account</h1>
    <p class="sub">Enter your details to register for secure portal access.</p>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error"><%= HtmlUtil.escape((String) request.getAttribute("errorMessage")) %></div>
    <% } %>
    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
        <div class="grid">
            <div>
                <label for="fullName">Full name</label>
                <input id="fullName" name="fullName" type="text" required maxlength="80" autocomplete="name">
            </div>
            <div>
                <label for="studentId">Student ID / Roll number</label>
                <input id="studentId" name="studentId" type="text" required maxlength="30">
            </div>
            <div>
                <label for="email">Email address</label>
                <input id="email" name="email" type="email" required maxlength="100" autocomplete="email">
            </div>
            <div>
                <label for="course">Course / Department</label>
                <input id="course" name="course" type="text" required maxlength="80" placeholder="e.g. MCA (AI & ML)">
            </div>
            <div>
                <label for="username">Create username</label>
                <input id="username" name="username" type="text" required minlength="4" maxlength="20" autocomplete="username">
                <div class="hint">4–20 letters, numbers, dots, underscores or hyphens.</div>
            </div>
            <div>
                <label for="password">Create password</label>
                <input id="password" name="password" type="password" required minlength="8" autocomplete="new-password">
                <div class="hint">Use at least 8 characters.</div>
            </div>
            <div>
                <label for="confirmPassword">Confirm password</label>
                <input id="confirmPassword" name="confirmPassword" type="password" required minlength="8" autocomplete="new-password">
            </div>
        </div>
        <button type="submit">Create student account</button>
    </form>
    <div class="foot">Already registered? <a href="${pageContext.request.contextPath}/login.jsp">Back to login</a></div>
</div>
</body>
</html>
