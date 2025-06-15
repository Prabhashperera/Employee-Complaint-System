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
    <title>Complaint System Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --light-bg: #ecf0f1;
            --dark-text: #2c3e50;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar-custom {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }

        .sidebar {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            padding: 0;
            overflow: hidden;
        }

        .sidebar-header {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .profile-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 4px solid rgba(255,255,255,0.3);
            margin-bottom: 1rem;
        }

        .nav-link-custom {
            color: var(--dark-text);
            padding: 1rem 1.5rem;
            border: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .nav-link-custom:hover {
            background-color: var(--light-bg);
            transform: translateX(5px);
            color: var(--secondary-color);
        }

        .nav-link-custom i {
            margin-right: 0.75rem;
            width: 20px;
        }

        .main-content {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            padding: 2rem;
        }

        .dashboard-header {
            background: linear-gradient(135deg, var(--success-color), var(--secondary-color));
            color: white;
            padding: 1.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
        }

        .time-display {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1rem;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }

        .priority-high {
            color: var(--accent-color);
            font-weight: bold;
        }

        .priority-medium {
            color: var(--warning-color);
            font-weight: bold;
        }

        .priority-low {
            color: var(--success-color);
            font-weight: bold;
        }

        .card-custom {
            border: none;
            border-radius: 15px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

        .card-custom:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        @media (max-width: 768px) {
            .sidebar {
                margin-bottom: 1rem;
            }
        }
    </style>
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
                    <a href="#" class="nav-link-custom active">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                    <a href="#" class="nav-link-custom" onclick="showComplaints()">
                        <i class="bi bi-list-ul"></i> Show Complaints
                    </a>
                    <% if ("Admin".equals(userRole) || "Manager".equals(userRole)) { %>
                    <a href="#" class="nav-link-custom" onclick="employeeManage()">
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
            <div class="main-content">
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
                        <form id="complaintForm" action="<%= request.getContextPath() %>/complaint/submit" method="post">
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
                                        <option value="">Select Priority</option>
                                        <option value="Low" class="priority-low">Low</option>
                                        <option value="Medium" class="priority-medium">Medium</option>
                                        <option value="High" class="priority-high">High</option>
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
                            <div class="mb-3">
                                <label for="category" class="form-label">
                                    <i class="bi bi-tags"></i> Category
                                </label>
                                <select class="form-select" id="category" name="category">
                                    <option value="">Select Category</option>
                                    <option value="Technical">Technical Issue</option>
                                    <option value="Service">Service Quality</option>
                                    <option value="Billing">Billing</option>
                                    <option value="HR">Human Resources</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
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
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
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

    // Navigation functions
    function showComplaints() {
        window.location.href = '<%= request.getContextPath() %>/complaint/list';
    }

    function employeeManage() {
        window.location.href = '<%= request.getContextPath() %>/employee/manage';
    }

    // Form validation and submission
    document.getElementById('complaintForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const title = document.getElementById('complaintTitle').value.trim();
        const description = document.getElementById('description').value.trim();
        const priority = document.getElementById('priority').value;

        if (!title || !description || !priority) {
            alert('Please fill in all required fields.');
            return;
        }

        // Show loading state
        const submitBtn = this.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i> Submitting...';
        submitBtn.disabled = true;

        // Simulate form submission (replace with actual submission)
        setTimeout(() => {
            alert('Complaint submitted successfully!');
            this.reset();
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        }, 2000);
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