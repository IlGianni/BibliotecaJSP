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

        String idLibro = request.getParameter("idLibro");
        String dataRitornoPrevista = request.getParameter("dataRitornoPrevista");
        String userEmail = request.getParameter("userEmail");

        String email;
        if (request.getParameter("user").equals("me")) {
            email = (String)session.getAttribute("email");
        } else {
            email = userEmail;
        }

        String sql = "SELECT * FROM utenti WHERE Email = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            int idUtente = rs.getInt("IDUtente");

            sql = "INSERT INTO prestiti (IDLibro, IDUtente, DataPrestito, DataRitornoPrevista) VALUES (?, ?, CURDATE(), ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, idLibro);
            pstmt.setInt(2, idUtente);
            pstmt.setString(3, dataRitornoPrevista);
            pstmt.executeUpdate();

            sql = "UPDATE libri SET Stato = 'in prestito' WHERE IDLibro = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, idLibro);
            pstmt.executeUpdate();

            response.sendRedirect("../showBooks/showBooks.jsp");
            out.println("Prenotazione effettuata con successo");
        } else {
            out.println("Utente non trovato");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Errore: " + e.getMessage());
    }
%>
