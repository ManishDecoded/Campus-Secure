<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.portal.Student,com.portal.HtmlUtil,java.text.SimpleDateFormat,java.util.Date" %>
<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("login.jsp?expired=1");
        return;
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
    long loginMillis = ((Long) session.getAttribute("loginTime")).longValue();
    String loginDate = dateFormat.format(new Date(loginMillis));
    String createdDate = dateFormat.format(new Date(session.getCreationTime()));
    String lastAccessDate = dateFormat.format(new Date(session.getLastAccessedTime()));
    int timeoutMinutes = session.getMaxInactiveInterval() / 60;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | CampusSecure</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; background: #f3f6fb; font-family: Arial, sans-serif; color: #172033; }
        header { background: #123b75; color: white; padding: 17px max(24px, calc((100% - 1080px)/2)); display: flex; align-items: center; justify-content: space-between; gap: 16px; }
        .brand { font-size: 18px; font-weight: 700; letter-spacing: .2px; }
        .brand span { color: #a9d3ff; font-weight: 400; }
        .logout { border: 1px solid rgba(255,255,255,.45); border-radius: 8px; background: transparent; color: white; padding: 9px 16px; font-weight: 700; cursor: pointer; }
        .logout:hover { background: rgba(255,255,255,.12); }
        main { width: min(1080px, calc(100% - 36px)); margin: 38px auto; }
        .welcome { margin-bottom: 25px; }
        .welcome .tag { color: #1764aa; text-transform: uppercase; letter-spacing: 1.2px; font-size: 11px; font-weight: 700; }
        h1 { margin: 8px 0; font-size: 29px; }
        .welcome p { margin: 0; color: #687386; font-size: 14px; }
        .grid { display: grid; grid-template-columns: 1.1fr .9fr; gap: 20px; }
        .card { background: white; border: 1px solid #e6ebf2; border-radius: 14px; padding: 25px; box-shadow: 0 7px 24px rgba(20,45,90,.04); }
        h2 { margin: 0 0 20px; font-size: 17px; }
        .profile-top { display: flex; gap: 15px; align-items: center; padding-bottom: 20px; border-bottom: 1px solid #edf0f5; }
        .avatar { width: 52px; height: 52px; border-radius: 14px; background: #e8f1ff; color: #1764aa; display: grid; place-items: center; font-size: 22px; font-weight: 700; }
        .profile-top h3 { margin: 0 0 5px; font-size: 17px; }
        .profile-top p { margin: 0; color: #758093; font-size: 13px; }
        .details { display: grid; grid-template-columns: 1fr 1fr; gap: 20px 14px; padding-top: 21px; }
        .detail label { display: block; color: #8791a2; font-size: 11px; text-transform: uppercase; letter-spacing: .7px; margin-bottom: 6px; }
        .detail strong { font-size: 13px; font-weight: 600; overflow-wrap: anywhere; }
        .status { display: inline-flex; align-items: center; gap: 7px; background: #ecfdf3; color: #067647; padding: 6px 10px; border-radius: 20px; font-size: 12px; font-weight: 700; }
        .dot { width: 7px; height: 7px; background: #12b76a; border-radius: 50%; }
        .session-list { display: grid; gap: 17px; }
        .session-row { display: flex; justify-content: space-between; gap: 16px; font-size: 13px; border-bottom: 1px solid #f0f2f6; padding-bottom: 13px; }
        .session-row:last-child { border: 0; padding-bottom: 0; }
        .session-row span { color: #7a8495; }
        .session-row strong { text-align: right; font-weight: 600; }
        .note { margin-top: 20px; padding: 13px 14px; background: #f0f6ff; border-radius: 9px; color: #365a86; font-size: 12px; line-height: 1.6; }
        .footer { color: #98a1af; font-size: 12px; text-align: center; margin: 26px 0; }
        @media(max-width: 750px) { .grid { grid-template-columns: 1fr; } header { padding: 16px 20px; } main { margin-top: 28px; } }
        @media(max-width: 430px) { .details { grid-template-columns: 1fr; } h1 { font-size: 24px; } .card { padding: 20px; } }
    </style>
</head>
<body>
<header>
    <div class="brand">CampusSecure <span>/ Student Portal</span></div>
    <form action="${pageContext.request.contextPath}/LogoutServlet" method="post" style="margin:0">
        <button class="logout" type="submit">Logout</button>
    </form>
</header>
<main>
    <section class="welcome">
        <div class="tag">Authenticated area</div>
        <h1>Welcome, <%= HtmlUtil.escape(student.getFullName()) %>!</h1>
        <p>You are signed in. Your dashboard is available while your HTTP session remains active.</p>
    </section>
    <div class="grid">
        <section class="card">
            <h2>Student profile</h2>
            <div class="profile-top">
                <div class="avatar"><%= HtmlUtil.escape(student.getFullName().substring(0, 1).toUpperCase()) %></div>
                <div>
                    <h3><%= HtmlUtil.escape(student.getFullName()) %></h3>
                    <p><%= HtmlUtil.escape(student.getCourse()) %></p>
                </div>
            </div>
            <div class="details">
                <div class="detail"><label>Student ID</label><strong><%= HtmlUtil.escape(student.getStudentId()) %></strong></div>
                <div class="detail"><label>Username</label><strong><%= HtmlUtil.escape(student.getUsername()) %></strong></div>
                <div class="detail"><label>Email address</label><strong><%= HtmlUtil.escape(student.getEmail()) %></strong></div>
                <div class="detail"><label>Account status</label><strong><span class="status"><span class="dot"></span>Authenticated</span></strong></div>
            </div>
        </section>
        <section class="card">
            <h2>HTTP session information</h2>
            <div class="session-list">
                <div class="session-row"><span>Session status</span><strong>Active</strong></div>
                <div class="session-row"><span>Login time</span><strong><%= loginDate %></strong></div>
                <div class="session-row"><span>Session created</span><strong><%= createdDate %></strong></div>
                <div class="session-row"><span>Last accessed</span><strong><%= lastAccessDate %></strong></div>
                <div class="session-row"><span>Inactive timeout</span><strong><%= timeoutMinutes %> minutes</strong></div>
            </div>
            <div class="note">The server automatically expires this session after <strong><%= timeoutMinutes %> minutes without an HTTP request</strong>. Logging out immediately invalidates the session and removes its stored attributes.</div>
        </section>
    </div>
    <div class="footer">Student Authentication and Session Management System · Advanced Internet Programming</div>
</main>
</body>
</html>
