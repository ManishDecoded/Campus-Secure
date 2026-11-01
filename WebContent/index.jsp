<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("student") != null) {
        response.sendRedirect("dashboard.jsp");
    } else {
        response.sendRedirect("login.jsp");
    }
%>
