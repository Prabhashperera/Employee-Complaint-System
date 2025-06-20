# 🧾 Employee Complaint Management System

Welcome to the **Employee Complaint Management System** – a web-based platform that allows employees to securely lodge complaints, and lets administrators manage and resolve them efficiently. Built using **Java**, **Servlets**, **JSP**, **HTML**, **CSS**, **Bootstrap**, and **MySQL**.

> 🔐 This system ensures a streamlined, anonymous, and secure way of handling workplace grievances.

## 🚀 Features

- 📝 Employees can submit complaints with ease  
- 📋 Admin dashboard to view, manage & delete complaints  
- 🧩 Modular MVC architecture  
- 🔐 Session management for authentication  
- 💾 MySQL database integration  
- 📱 Responsive UI with Bootstrap

## 🏗️ Project Structure

Employee-Complaint-System/
├── src/
│ ├── main/
│ │ ├── java/
│ │ │ └── org/system/
│ │ │ ├── controller/
│ │ │ ├── crud/
│ │ │ ├── dao/
│ │ │ └── model/
│ │ └── webapp/
│ │ ├── view/
│ │ │ └── pages/
│ │ └── WEB-INF/
│ │ └── web.xml
├── database/
│ └── employee_complaint_system.sql
├── .gitignore
├── README.md
└── pom.xml (if using Maven)

![ChatGPT Image Jun 20, 2025, 11_04_09 PM](https://github.com/user-attachments/assets/0a17bada-b3a0-4691-ab0e-171413a2b0fd)


## ⚙️ Setup & Configuration Guide

### 🔧 Prerequisites

- Java 8+ installed  
- Apache Tomcat (v9 or higher)  
- MySQL Server  
- A Java IDE like IntelliJ IDEA or Eclipse  
- JDBC driver (MySQL Connector)  
- Optional: Maven (for dependency management)

### 🛠️ Installation Steps

1. **Clone the Repository**
git clone https://github.com/Prabhashperera/Employee-Complaint-System.git
cd Employee-Complaint-System


2. **Import the Project**
- Open in your IDE (Eclipse/IntelliJ)  
- If you're using Maven, run `mvn install` to resolve dependencies

3. **Configure MySQL Database**
- Import the SQL file: schema.sql

employee_complaint_system.sql # Located in /database folder

mathematica
Copy
Edit

4. **Update Database Credentials**
In your DAO/config files, replace:
```java
String url = "jdbc:mysql://localhost:3306/employee_complaint_system";
String user = "root";
String password = "your_password";

Deploy to Tomcat

Build the project

Deploy .war file to Tomcat's webapps/ or configure deployment in IDE

Start the Tomcat server

Run the Application
Open in browser:

bash
Copy
Edit
http://localhost:8080/Employee-Complaint-System/view/pages/signinPage.jsp
🙋‍♂️ Admin Login
You can manually insert admin credentials into the database or implement a user creation interface as needed.

📌 Technologies Used
Java & Servlet API

JSP

HTML/CSS/Bootstrap

MySQL

JDBC

Apache Tomcat

📬 Want to Contribute?
Pull requests are welcome! For major changes, open an issue to discuss your ideas.

©️ Author
Made with ❤️ by Prabash Perera

yaml
Copy
Edit

---

Boom. 💣 That’s your full README in a single, clean chunk. Copy, paste, commit, done. Let me know if you wan
