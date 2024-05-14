<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%
    try {
        // Carico il driver JDBC
        Class.forName("com.mysql.jdbc.Driver");
        
        // Connessione al database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/biblioteca", "root", "");

        session.invalidate();
        session = request.getSession(true);

        String email = request.getParameter("email");
        String sql = "SELECT * FROM utenti WHERE Email = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            int idUtente = rs.getInt("IDUtente");
            String userEmail = rs.getString("Email");
            session.setAttribute("id", idUtente);
            session.setAttribute("email", userEmail);
            response.sendRedirect("../index.jsp");
        } else {
            out.println("<script>alert('Utente non trovato')</script>");
            response.sendRedirect("../addUser/addUser.html");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Errore: " + e.getMessage());
    }
%>
