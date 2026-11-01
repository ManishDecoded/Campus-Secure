# 🎓 Student Authentication & Session Management System

A Java Servlet/JSP web application built for **Advanced Internet Programming**. It demonstrates student registration, secure login, protected pages, and HTTP session management.

![Java](https://img.shields.io/badge/Java-17-orange?logo=openjdk)
![Servlet](https://img.shields.io/badge/Jakarta_Servlet-6.0-blue)
![Tomcat](https://img.shields.io/badge/Apache_Tomcat-10.1-yellow?logo=apachetomcat)

## ✨ Features

- Student registration with profile details and credential validation.
- Password protection using salted **PBKDF2 hashes**.
- Login with HTTP session creation and session-ID renewal.
- Protected dashboard using `SessionFilter`.
- Session details and a **15-minute inactivity timeout**.
- Logout that invalidates the active session.
- Responsive JSP pages for login, registration, and dashboard.

## 🧰 Tech Stack

**Java 17** · **JSP** · **Jakarta Servlet 6.0** · **Apache Tomcat 10.1** · **Eclipse IDE**

> **Compatibility:** Use Tomcat 10.1.x or another Jakarta-compatible release. Tomcat 9 and older use `javax.servlet` and are not compatible with this project's `jakarta.servlet` imports.

## 🔗 Servlet Mappings

Servlets and the filter are configured explicitly in `WebContent/WEB-INF/web.xml`; annotation scanning is not required.

| Class | URL pattern | Purpose |
|---|---|---|
| `RegisterServlet` | `/RegisterServlet` | Student registration |
| `LoginServlet` | `/LoginServlet` | Student authentication |
| `LogoutServlet` | `/LogoutServlet` | Session invalidation |
| `SessionFilter` | `/dashboard.jsp` | Protects the dashboard |

The deployment descriptor and Eclipse Dynamic Web Module facet are both configured for **version 6.0**. JSP forms use the application context path, so they also work if the context root changes.

## 🚀 Run in Eclipse

1. Extract the project ZIP and import the folder containing `.project` using **File → Import → Existing Projects into Workspace**.
2. Configure **JDK 17** in Eclipse.
3. Add **Apache Tomcat 10.1** in the Servers view and select it under **Project → Properties → Targeted Runtimes**.
4. Select **Project → Clean**, then right-click the project and choose **Run As → Run on Server**.
5. Open **[http://localhost:8080/StudentAuthenticationSystem/](http://localhost:8080/StudentAuthenticationSystem/)**. Adjust the port or context path if yours is different.

## 🔐 Demo Login

| Field | Value |
|---|---|
| Username | `student` |
| Password | `Student@123` |

You can also create an account through the registration page.

## ⚙️ Session Behaviour

After a successful login, the application creates an `HttpSession`, stores the authenticated student and login time, renews the session ID, and applies a 15-minute inactivity timeout. `SessionFilter` blocks unauthenticated dashboard access. Logging out invalidates the session.

## 📁 Project Structure

```text
StudentAuthenticationSystem_Eclipse/
├── src/com/portal/
│   ├── Student.java
│   ├── UserStore.java
│   ├── PasswordUtil.java
│   ├── HtmlUtil.java
│   ├── RegisterServlet.java
│   ├── LoginServlet.java
│   ├── LogoutServlet.java
│   └── SessionFilter.java
├── WebContent/
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── dashboard.jsp
│   └── WEB-INF/web.xml
└── .settings/
    └── org.eclipse.wst.common.project.facet.core.xml
```

## ℹ️ Project Note

Student accounts are stored in a thread-safe **in-memory map**, so newly registered accounts are cleared when the application or Tomcat restarts. A production version should use a database and add protections such as HTTPS and CSRF protection.

**404 tip:** Use the login and registration forms to submit POST requests; opening servlet URLs directly in the browser sends GET requests. If a mapping still returns 404, verify the deployed context path and `web.xml` mappings, then clean and republish the project in Eclipse.
