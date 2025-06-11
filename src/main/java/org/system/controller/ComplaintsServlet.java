package org.system.controller;


import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/home")
public class ComplaintsServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PreparedStatement stm = ds.getConnection().prepareStatement("select * from complaints");
            ResultSet rs = stm.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
