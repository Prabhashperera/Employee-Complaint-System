<%--
  Created by IntelliJ IDEA.
  User: Prabash Perera
  Date: 6/12/2025
  Time: 7:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    // Check if user is logged in
    if (session.getAttribute("loggedIn") == null || !(Boolean) session.getAttribute("loggedIn")) {
        response.sendRedirect(request.getContextPath() + "/view/pages/signinPage.jsp");
        return;
    }
    // Get user data from session
    org.system.model.UserModel user = (org.system.model.UserModel) session.getAttribute("user");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    String userRole = (String) session.getAttribute("userRole");
%>
<h1>Welcome, <%= userName %>!</h1>
<p><strong>Email:</strong> <%= userEmail %></p>
<p><strong>Role:</strong> <%= userRole %></p>
    <h1>Dashboard</h1>
</body>
</html>
