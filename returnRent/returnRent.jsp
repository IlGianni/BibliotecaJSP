<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%
    try {
        // Carico il driver JDBC
        Class.forName("com.mysql.jdbc.Driver");
        
        // Connessione al database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/biblioteca", "root", "");
        String idLibro = request.getParameter("idLibro");
        String dataPrestito = request.getParameter("dataPrestito");

        String sql = "UPDATE prestiti SET DataRitornoReale = CURDATE() WHERE IDLibro = ? AND DataPrestito = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, idLibro);
        pstmt.setString(2, dataPrestito);
        pstmt.executeUpdate();
        pstmt.close();

        sql = "UPDATE libri SET Stato = 1 WHERE IDLibro = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, idLibro);
        pstmt.executeUpdate();
        pstmt.close();

        response.sendRedirect("../rentHistory/rentHistory.jsp");
        out.println("Libro inserito correttamente!");

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
