
<%--
  Created by IntelliJ IDEA.
  User: Prabash Perera
  Date: 6/12/2025
  Time: 7:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Complaint System Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome CDN -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
            integrity="sha512-ZwMtx5/2P2bAo7VYURDX3P9aRQ2UeRufXGHJ3N3LS1I/t0JY91SMkgf4N7CNxX2r+H2tFZC5Awz7blW5DE/NMg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    />

<%--    <link rel="stylesheet" href="../styles/dashboard.css">--%>
    <link rel="stylesheet" href="<c:url value='/view/styles/dashboard.css'/>">
    <link rel="stylesheet" href="<c:url value='/view/styles/complaints.css'/>">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-clipboard-check"></i> Complaint System
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle"></i> <%= userName %>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#"><i class="bi bi-person"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-gear"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-lg-3 col-md-4 mb-4">
            <div class="sidebar">
                <!-- Profile Section -->
                <div class="sidebar-header">
                    <img src="https://via.placeholder.com/80x80/ffffff/3498db?text=<%= userName.substring(0,1).toUpperCase() %>"
                         alt="Profile" class="profile-img">
                    <h5 class="mb-1"><%= userName %></h5>
                    <small><%= userEmail %></small>
                    <div class="mt-2">
                        <span class="badge bg-light text-dark"><%= userRole %></span>
                    </div>
                </div>

                <!-- Navigation Links -->
                <div class="list-group list-group-flush">
                    <a href="#" class="nav-link-custom active show_Dashboard">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                    <a href="/cs/saveComplaint" class="nav-link-custom show_Complaints">
                        <i class="bi bi-list-ul"></i> Show Complaints
                    </a>
                    <% if ("admin".equals(userRole)){ %>
                    <a href="#" class="nav-link-custom">
                        <i class="bi bi-people"></i> Employee Manage
                    </a>
                    <% } %>
                    <a href="#" class="nav-link-custom">
                        <i class="bi bi-bar-chart"></i> Reports
                    </a>
                    <a href="#" class="nav-link-custom">
                        <i class="bi bi-gear"></i> Settings
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9 col-md-8">
            <%-- TODO:ReplaceMenter--%>
            <div class="main-content">

                <%
                    String showSection = request.getParameter("view");
                    boolean showComplaints = "complaints".equals(showSection);
                %>

                <section class="dashboard-section" style="<%= showComplaints ? "display:none;" : "display:block;" %>">
                    <!-- Dashboard stuff -->
                    <section class="dashboard-section">
                        <!-- Dashboard Header -->
                        <div class="dashboard-header">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h2 class="mb-1">
                                        <i class="bi bi-house"></i> Welcome back, <%= userName %>!
                                    </h2>
                                    <p class="mb-0">Manage your complaints efficiently</p>
                                </div>
                                <div class="col-md-4 text-md-end">
                                    <div class="time-display">
                                        <i class="bi bi-clock"></i>
                                        <span id="currentTime"></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Stats -->
                        <div class="row mb-4">
                            <div class="col-md-4 mb-3">
                                <div class="card card-custom text-center">
                                    <div class="card-body">
                                        <i class="bi bi-clipboard-plus text-primary" style="font-size: 2rem;"></i>
                                        <h5 class="card-title mt-2">New Complaints</h5>
                                        <h3 class="text-primary">12</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card card-custom text-center">
                                    <div class="card-body">
                                        <i class="bi bi-clock-history text-warning" style="font-size: 2rem;"></i>
                                        <h5 class="card-title mt-2">Pending</h5>
                                        <h3 class="text-warning">8</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card card-custom text-center">
                                    <div class="card-body">
                                        <i class="bi bi-check-circle text-success" style="font-size: 2rem;"></i>
                                        <h5 class="card-title mt-2">Resolved</h5>
                                        <h3 class="text-success">45</h3>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- New Complaint Form -->
                        <div class="card card-custom">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">
                                    <i class="bi bi-plus-circle"></i> Submit New Complaint
                                </h5>
                            </div>
                            <div class="card-body">

                                <c:if test="${not empty sessionScope.complaintSaved}">
                                    <script>
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'Success!',
                                            text: '${complaintSaved}'
                                        });
                                    </script>
                                    <c:remove var="complaintSaved" scope="session"/>
                                </c:if>

                                <c:if test="${not empty sessionScope.complaintNotSaved}">
                                    <script>
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Oops!',
                                            text: '${complaintNotSaved}'
                                        });
                                    </script>
                                    <c:remove var="complaintNotSaved" scope="session"/>
                                </c:if>

                                <form id="complaintForm" action="/cs/saveComplaint" method="post">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="complaintTitle" class="form-label">
                                                <i class="bi bi-card-heading"></i> Complaint Title *
                                            </label>
                                            <input type="text" class="form-control" id="complaintTitle"
                                                   name="title" required placeholder="Enter complaint title">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="priority" class="form-label">
                                                <i class="bi bi-exclamation-triangle"></i> Priority *
                                            </label>
                                            <select class="form-select" id="priority" name="priority" required>
                                                <option name="none" value="">Select Priority</option>
                                                <option name="Low" value="Low" class="priority-low">Low</option>
                                                <option name="Medium" value="Medium" class="priority-medium">Medium</option>
                                                <option name="High" value="High" class="priority-high">High</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">
                                            <i class="bi bi-text-paragraph"></i> Description *
                                        </label>
                                        <textarea class="form-control" id="description" name="description"
                                                  rows="4" required placeholder="Describe your complaint in detail..."></textarea>
                                    </div>
                                    <input type="hidden" name="submittedBy" id="submittedBy" value="<%= userName %>">
                                    <input type="hidden" name="submittedAt" id="submittedAt">
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="reset" class="btn btn-outline-secondary me-md-2">
                                            <i class="bi bi-arrow-clockwise"></i> Reset
                                        </button>
                                        <button type="submit" class="btn btn-primary-custom">
                                            <i class="bi bi-send"></i> Submit Complaint
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </section>
                </section>

                <section class="complaint-section" style="<%= showComplaints ? "display:block;" : "display:none;" %>">
                    <!-- Complaints list -->
                    <section class="complaint-section">
                        <!-- Dashboard Header -->
                        <div class="dashboard-header">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h2 class="mb-1">
                                        <i class="bi bi-house"></i> Do you Have Any Complaints ? , <%= userName %>!
                                    </h2>
                                    <p class="mb-0">Manage your complaints efficiently</p>
                                </div>
                            </div>
                        </div>
                        <%-- Complaint List --%>
                        <div class="complaints-list">
                            <!-- This is your JSP forEach loop with styling -->
                            <!-- <c:forEach var="complaint" items="${complaintList}"> -->
                            <div class="complaint-item card">
                                <h4>${complaint.title}</h4>
                                <p><strong>ID:</strong> ${complaint.id}</p>
                                <p><strong>Description:</strong> ${complaint.description}</p>
                                <p><strong>Priority:</strong>
                                    <span class="priority- ${complaint.priority.toLowerCase()}">
                                            ${complaint.priority}
                                    </span>
                                </p>
                                <p><strong>Submitted By:</strong> ${complaint.submittedBy}</p>
                                <p><strong>Submitted At:</strong> ${complaint.submittedTime}</p>

                                <!-- Admin Only Controls -->
                                <div class="admin-controls">
                                    <c:choose>
                                        <c:when test="${sessionScope.userRole == 'admin'}">
                                            <div class="admin-badge">
                                                <i class="fas fa-user-shield"></i>
                                                Admin Only
                                                <button style="border-radius: 60px" class="btn btn-danger" type="button">
                                                    <i class="fas fa-user-shield"></i>
                                                    Delete Complaint
                                                </button>
                                            </div>
                                        </c:when>

                                        <c:when test="${sessionScope.userRole == 'employee'}">
                                            <div class="admin-badge">
                                                <i class="fas fa-user-shield"></i>
                                                Admin Only
                                                <button style="border-radius: 60px" class="btn btn-danger" type="button" disabled="disabled">
                                                    <i class="fas fa-user-shield"></i>
                                                    Delete Complaint
                                                </button>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="status-controls">
                                        <c:choose>
                                            <c:when test="${sessionScope.userRole == 'admin'}">
                                                <form class="d-flex gap-3" action="/cs/saveComplaint" method="POST">
                                                    <input type="hidden" name="_method" value="PUT">
                                                    <input type="hidden" name="complaintId" value="${complaint.id}">

                                                    <select class="status-select form-select" name="status" onchange="enableUpdateBtn(this)">
                                                        <option value="Open" ${complaint.status == "Open" ? "selected" : ""}>Open</option>
                                                        <option value="In Progress" ${complaint.status == "In Progress" ? "selected" : ""}>In Progress</option>
                                                        <option value="Resolved" ${complaint.status == "Resolved" ? "selected" : ""}>Resolved</option>
                                                    </select>

                                                    <button type="submit" class="update-btn">
                                                        <i class="fas fa-save"></i> Update
                                                    </button>
                                                </form>
                                            </c:when>

                                            <c:when test="${sessionScope.userRole == 'employee'}">
                                                <div class="d-flex gap-3">
                                                    <select class="status-select form-select" disabled>
                                                        <option value="Open" ${complaint.status == "Open" ? "selected" : ""}>Open</option>
                                                        <option value="In Progress" ${complaint.status == "In Progress" ? "selected" : ""}>In Progress</option>
                                                        <option value="Resolved" ${complaint.status == "Resolved" ? "selected" : ""}>Resolved</option>
                                                    </select>

                                                    <button class="update-btn" disabled>
                                                        <i class="fas fa-save"></i> Disabled
                                                    </button>
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <!-- </c:forEach> -->
                        </div>

                    </section>
                </section>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    //Routing's
        const params = new URLSearchParams(window.location.search);
        const view = params.get("view");

        if (view === "complaints") {
            $(".complaint-section").css("display", "block");
            $(".dashboard-section").css("display", "none");
        } else {
            $(".dashboard-section").css("display", "block");
            $(".complaint-section").css("display", "none");
        }

    // Update current time
    function updateTime() {
        const now = new Date();
        const timeString = now.toLocaleString('en-US', {
            weekday: 'short',
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        document.getElementById('currentTime').textContent = timeString;
    }

    // Update time every second
    setInterval(updateTime, 1000);
    updateTime(); // Initial call

    // Form validation and submission
    document.getElementById('complaintForm').addEventListener('submit', function (e) {
        const now = new Date();
        const yyyy = now.getFullYear();
        const mm = String(now.getMonth() + 1).padStart(2, '0');
        const dd = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');

        // Final format: 2025-06-15 22:26:05
        const fullDatetime = yyyy + "-" + mm + "-" + dd + " " + hours + ":" + minutes + ":" + seconds;
        document.getElementById("submittedAt").value = fullDatetime;


        const title = document.getElementById('complaintTitle').value.trim();
        const description = document.getElementById('description').value.trim();
        const priority = document.getElementById('priority').value;

        if (!title || !description || !priority) {
            alert('Please fill in all required fields.');
            return;
        }

    });


    // Priority color change on select
    document.getElementById('priority').addEventListener('change', function() {
        const select = this;
        select.className = 'form-select';

        if (this.value === 'High') {
            select.classList.add('priority-high');
        } else if (this.value === 'Medium') {
            select.classList.add('priority-medium');
        } else if (this.value === 'Low') {
            select.classList.add('priority-low');
        }
    });
</script>
</body>
</html>