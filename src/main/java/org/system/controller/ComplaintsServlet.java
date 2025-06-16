package org.system.controller;


import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.system.crud.IdGeneratorWithPrefix;
import org.system.model.ComplaintModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/saveComplaint")
public class ComplaintsServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PreparedStatement stm = ds.getConnection().prepareStatement("INSERT INTO complaints values(?,?,?,?,?,?,?)");
            String nextID = IdGeneratorWithPrefix.generateNextId(ds, "Complaints", "id", "C", 3);
            System.out.println(nextID);
            stm.setString(1, nextID);
            stm.setString(2, req.getParameter("title"));
            stm.setString(3, req.getParameter("description"));
            stm.setString(4, req.getParameter("priority"));
            stm.setString(5, "Open");
            stm.setString(6, req.getParameter("submittedBy"));
            stm.setString(7, req.getParameter("submittedAt"));
            int i = stm.executeUpdate();
            if (i > 0) {
                req.getSession().setAttribute("complaintSaved", "Complaint Saved");
            }else {
                req.getSession().setAttribute("complaintNotSaved", "Complaint NOT Saved");
            }
            System.out.println(i);
            resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp");

        }catch (Exception e) {
            req.getSession().setAttribute("complaintNotSaved", "Complaint NOT Saved");
            resp.sendRedirect(req.getContextPath() + "/view/pages/dashboard.jsp");
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
