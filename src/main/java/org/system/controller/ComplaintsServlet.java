package org.system.controller;


import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.system.model.ComplaintModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class ComplaintsServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/complaint_db")
    private DataSource ds;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PreparedStatement stm = ds.getConnection().prepareStatement("select * from complaints");
            ResultSet rs = stm.executeQuery();
            List<ComplaintModel> complaints = new ArrayList<>();
            while (rs.next()) {
                ComplaintModel complaint = new ComplaintModel();
                complaint.setId(rs.getString("id"));
                complaint.setTitle(rs.getString("title"));
                complaint.setDescription(rs.getString("description"));
                complaint.setPriority(rs.getString("priority"));
                complaint.setStatus(rs.getString("status"));
                complaint.setSubmittedBy(req.getParameter("submitted_by"));
                complaint.setSubmittedTime(rs.getString("submitted_at"));
                complaints.add(complaint);
            }

            resp.getWriter().print(complaints);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
