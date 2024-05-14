<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%
    try {
        // Carico il driver JDBC
        Class.forName("com.mysql.jdbc.Driver");
        
        // Connessione al database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/biblioteca", "root", "");

        session = request.getSession(true);

        String sql = "DELETE FROM prestiti WHERE IDUtente = ? AND DataRitornoReale IS NOT NULL";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, (Integer) session.getAttribute("id"));
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("../rentHistory/rentHistory.jsp");
            out.println("Libri eliminati correttamente!");
        } else {
            out.println("Nessun libro eliminato");
        }

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Errore: " + e.getMessage());
    }
%>
