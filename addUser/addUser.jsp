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

        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        int roleId = role.equals("teacher") ? 2 : 1;

        String sql = "INSERT INTO utenti (Nome, Cognome, Email, Ruolo) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, surname);
        pstmt.setString(3, email);
        pstmt.setInt(4, roleId);

        if (pstmt.executeUpdate() > 0) {
            out.println("Utente aggiunto con successo!");
            sql = "SELECT IDUtente FROM utenti WHERE Email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int idUtente = rs.getInt("IDUtente");
                session.setAttribute("id", idUtente);
                session.setAttribute("email", email);
                response.sendRedirect("../showBooks/showBooks.jsp");
            } else {
                out.println("Errore: Impossibile ottenere l'ID dell'utente appena creato.");
            }

            rs.close();
        } else {
            out.println("Errore durante l'aggiunta dell'utente.");
        }

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Errore: " + e.getMessage());
    }
%>
