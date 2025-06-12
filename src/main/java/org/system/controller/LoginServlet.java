package org.system.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.system.model.UserModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PreparedStatement stm = ds.getConnection().prepareStatement("select * from users");
            ResultSet rs = stm.executeQuery();
            List<UserModel> userList = new ArrayList<>();
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                userList.add(user);
            }
            boolean isFound = false;
            for (UserModel user : userList) {
                if (user.getPassword().equals(req.getParameter("password")) && user.getEmail().equals(req.getParameter("email"))) {
                    isFound = true;
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/view/pages/dashboard.jsp").forward(req, resp);
                }
            }
            if (!isFound) {
                req.setAttribute("error", "Invalid username or password");
                resp.sendRedirect(req.getContextPath() + "/view/pages/signinPage.jsp");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
