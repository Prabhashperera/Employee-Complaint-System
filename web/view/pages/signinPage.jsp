<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Municipal CMS - Sign In</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../styles/signinpage.css" />

  </head>
  <body>
    <div class="main-container">
      <div class="signin-card">
        <!-- Brand Section -->
        <div class="brand-section">
          <div class="brand-icon">
            <i class="fas fa-building"></i>
          </div>
          <h1 class="brand-title">Municipal CMS</h1>
          <p class="brand-subtitle">Complaint Management System</p>
        </div>

          <c:if test="${not empty error}">
              <p class="btn btn-primary">${error}</p>
          </c:if>

        <%
          // Check if user is already logged in
          if (session.getAttribute("loggedIn") != null && (Boolean) session.getAttribute("loggedIn")) {
            response.sendRedirect(request.getContextPath() + "/view/pages/dashboard.jsp");
            return;
          }

          // Display error message if any
          String error = (String) session.getAttribute("error");
          if (error != null && !error.isEmpty()) {
        %>

        <script>
          Swal.fire({
            icon: 'error',
            title: 'Login Failed!',
            text: '<%= error %>'
          });
        </script>
        <%
            session.removeAttribute("error");
          }
        %>

        <!-- Sign In Form -->
        <form id="signinForm" action="/cs/loginServlet" method="post">
          <!-- Name Field -->
          <div class="form-floating">
            <input
              name="name"
              type="text"
              class="form-control"
              id="fullName"
              placeholder="Full Name"
              required
            />
            <label for="fullName">Full Name</label>
            <i class="fas fa-user input-group-icon"></i>
          </div>

          <!-- Email Field -->
          <div class="form-floating">
            <input
              name="email"
              type="email"
              class="form-control"
              id="email"
              placeholder="Email Address"
              required
            />
            <label for="email">Email Address</label>
            <i class="fas fa-envelope input-group-icon"></i>
          </div>

          <!-- Password Field -->
          <div class="form-floating">
            <input
              name="password"
              type="password"
              class="form-control"
              id="password"
              placeholder="Password"
              required
            />
            <label for="password">Password</label>
            <i class="fas fa-lock input-group-icon"></i>
          </div>

          <!-- Remember Me Checkbox -->
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="rememberMe" />
            <label class="form-check-label" for="rememberMe">
              Remember me on this device
            </label>
          </div>

          <!-- Sign In Button -->
          <button type="submit" class="btn btn-signin">
            <i class="fas fa-sign-in-alt me-2"></i>
            Sign In to CMS
          </button>
        </form>

        <!-- Footer -->
        <div class="footer-text">
          <p>
            If you don't have an account -
            <a href="signupPage.jsp" id="signupLink">Sign Up</a>
          </p>
        </div>
      </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
      // Add subtle animations and interactions (UI only, no logic)
      document.addEventListener("DOMContentLoaded", function () {
        // Add focus/blur animations for form inputs
        const formInputs = document.querySelectorAll(".form-control");

        formInputs.forEach((input) => {
          input.addEventListener("focus", function () {
            this.parentElement.classList.add("focused");
          });

          input.addEventListener("blur", function () {
            this.parentElement.classList.remove("focused");
          });
        });

        // Add loading animation to button on form submit (visual only)
        const form = document.getElementById("signinForm");
        const submitBtn = form.querySelector(".btn-signin");

        form.addEventListener("submit", function (e) {
          // Add loading state
          submitBtn.classList.add("loading");
          submitBtn.disabled = true;

          // Remove loading state after 2 seconds (for demo purposes)
          setTimeout(() => {
            submitBtn.classList.remove("loading");
            submitBtn.disabled = false;
          }, 2000);
        });

        // Add floating effect to brand icon
        const brandIcon = document.querySelector(".brand-icon");
        let floatDirection = 1;

        setInterval(() => {
          const currentTransform =
            brandIcon.style.transform || "translateY(0px)";
          const currentY = parseFloat(
            currentTransform.match(/translateY\(([^)]+)\)/) || [0, 0]
          )[1];

          if (currentY >= 5) floatDirection = -1;
          if (currentY <= -5) floatDirection = 1;

          brandIcon.style.transform = `translateY(${
            currentY + floatDirection * 0.5
          }px)`;
        }, 100);
      });
    </script>
  </body>
</html>
