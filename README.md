# Student Authentication and Session Management System

A Java Servlet/JSP web application for the Advanced Internet Programming subject. It demonstrates student registration, login authentication, protected dashboard access, HTTP session tracking, inactivity timeout, and logout.

## Compatibility

- Java 17
- Jakarta Servlet 6.0
- Apache Tomcat 10.1.x (recommended) or a newer Jakarta-compatible Tomcat release
- Eclipse IDE for Enterprise Java and Web Developers

**Do not use Tomcat 9 or older.** This project uses `jakarta.servlet.*`, while Tomcat 9 and older use the incompatible `javax.servlet.*` API.

## Main features

- Student registration with name, student ID, email, course/department, username, and password.
- Login validation through `LoginServlet`.
- Salted PBKDF2 password hashes (not plain-text password storage).
- Session creation after successful authentication, including session-ID renewal.
- Protected dashboard enforced by `SessionFilter`.
- Session information shown on the dashboard.
- Server-side session expiry after 15 minutes of inactivity.
- Logout invalidates the HTTP session.
- Responsive login, registration, and dashboard JSP pages.

## Important servlet mapping configuration

The servlets and filter are mapped explicitly in `WebContent/WEB-INF/web.xml`. The Java files intentionally do not use `@WebServlet` or `@WebFilter`, so these mappings do not depend on annotation scanning.

The descriptor uses both `version="6.0"` and the matching `web-app_6_0.xsd` schema. The Eclipse Dynamic Web Module facet is also set to `6.0`.

| Class | URL pattern | Purpose |
|---|---|---|
| `com.portal.RegisterServlet` | `/RegisterServlet` | Handles registration POST |
| `com.portal.LoginServlet` | `/LoginServlet` | Handles login POST |
| `com.portal.LogoutServlet` | `/LogoutServlet` | Ends the session |
| `com.portal.SessionFilter` | `/dashboard.jsp` | Blocks unauthenticated dashboard access |

All JSP forms use `${pageContext.request.contextPath}` so they work when the application is deployed under `/StudentAuthenticationSystem` or another context root.

## Import and run in Eclipse

1. Extract this ZIP file.
2. In Eclipse, choose **File → Import → Existing Projects into Workspace**.
3. Select the extracted `StudentAuthenticationSystem_Eclipse` folder (the folder containing `.project`).
4. Ensure Eclipse is configured with a Java 17 JDK.
5. In the **Servers** view, add **Apache Tomcat 10.1** and point it to your local Tomcat installation.
6. Right-click the project → **Properties → Targeted Runtimes** and tick the Tomcat 10.1 runtime.
7. Open **Project → Clean**, select this project, and clean it.
8. In the **Servers** view, right-click Tomcat → **Clean** (or **Clean Tomcat Work Directory**), then remove and re-add the project if an old deployment is still cached.
9. Right-click the project → **Run As → Run on Server**.
10. Open `http://localhost:8080/StudentAuthenticationSystem/` (adjust port/context root if your server uses different values).

If Eclipse does not recognize the project as a Dynamic Web Project, verify **Project Facets → Dynamic Web Module = 6.0** and **Java = 17**, then apply the Tomcat 10.1 targeted runtime.

## Demo login

- **Username:** `student`
- **Password:** `Student@123`

New student accounts can also be created from the registration page.

## Troubleshooting: servlet URL returns 404

- Confirm the deployed context path is `/StudentAuthenticationSystem` (check the Servers view or Tomcat manager).
- Confirm `WEB-INF/web.xml` contains the exact case-sensitive servlet mappings `/RegisterServlet` and `/LoginServlet`.
- Confirm the compiled classes are deployed at `WEB-INF/classes/com/portal/RegisterServlet.class` and `WEB-INF/classes/com/portal/LoginServlet.class`.
- Confirm the app is running on Tomcat 10.1 or newer and that Tomcat startup logs contain no deployment errors.
- After changing the project, clean the Eclipse project and republish the application to Tomcat; an old exploded deployment can retain stale files.

The forms submit to:

- `http://localhost:8080/StudentAuthenticationSystem/RegisterServlet`
- `http://localhost:8080/StudentAuthenticationSystem/LoginServlet`

Use the form buttons to send POST requests; entering these servlet URLs directly in the browser sends GET requests and is not the normal login/registration flow.

## Session behaviour

After successful login, the application creates an `HttpSession`, stores the authenticated student profile and login timestamp, renews the session ID, and applies a 15-minute inactive timeout. The dashboard is guarded by `SessionFilter`. The logout form sends a POST request to `LogoutServlet`, which invalidates the session.

## Project limitation

This is a classroom demonstration. Accounts are stored in a thread-safe in-memory map, so newly registered accounts are cleared when the web application or Tomcat restarts. A production application should use a database and add HTTPS, CSRF protection, account recovery, and operational logging.

## Project structure

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
