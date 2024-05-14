<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%
    try {
       // Carico il driver JDBC
        Class.forName("com.mysql.jdbc.Driver");
        
        // Connessione al database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/biblioteca", "root", "");

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String year = request.getParameter("year");
        String category = request.getParameter("category");

        String sql = "INSERT INTO libri (Titolo, Autore, AnnoPubblicazione, Categoria) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, author);
        pstmt.setString(3, year);
        pstmt.setString(4, category);

        if (pstmt.executeUpdate() > 0) {
            response.sendRedirect("../showBooks/showBooks.jsp");
            out.println("Libro inserito correttamente!");
        } else {
            out.println("Errore durante l'inserimento del libro.");
        }

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Errore: " + e.getMessage());
    }
%>
