<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prestiti</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 40px;
            background-color: #f9f9f9;
            color: #333;
        }

        div {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        input[type="text"], button {
            padding: 10px;
            margin-right: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #333366;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        h2 {
            color: #333366;
        }

        .center-buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }
    </style>
</head>
<body>
    <h2>Storico dei tuoi Prestiti</h2>
    <table>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.naming.*, javax.sql.*" %>
        <%
        
            try {
                // Carico il driver JDBC
                Class.forName("com.mysql.jdbc.Driver");
                // Connessione al database
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/biblioteca", "root", "");

                // Ottieni l'idUtente dalla sessione
                session = request.getSession(false);
                
                String idUtente = session.getAttribute("id").toString();

                String sql = "SELECT * FROM libri INNER JOIN prestiti ON libri.IDLibro = prestiti.IDLibro WHERE prestiti.IDUtente = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, idUtente);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
        %>
                    <thead>
                        <tr>
                            <th>Titolo</th>
                            <th>Data Prestito</th>
                            <th>Da Ritorno Prevista</th>
                            <th>Data Ritorno Reale</th>
                            <th style='text-align: center;'>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
        <%
                    do {
        %>
                        <tr>
                            <td><%= rs.getString("Titolo") %></td>
                            <td><%= rs.getString("DataPrestito") %></td>
                            <td><%= rs.getString("DataRitornoPrevista") %></td>
        <%
                            if (rs.getString("DataRitornoReale") != null) {
        %>
                                <td><%= rs.getString("DataRitornoReale") %></td>
                                <td class='center-buttons'>Restituito</td>
                                <td></td>
        <%
                            } else {
        %>
                                <td>Non ancora restituito</td>
                                <td class='center-buttons'>
                                    <div>
                                        <form action='../returnRent/returnRent.jsp' method='POST'>
                                            <input type='hidden' name='idLibro' value='<%= rs.getString("IDLibro") %>'>
                                            <input type='hidden' name='dataPrestito' value='<%= rs.getString("DataPrestito") %>'>
                                            <button>Restituisci</button>
                                        </form>
                                    </div>
                                </td>
        <%
                            }
        %>
                        </tr>
        <%
                    } while (rs.next());
        %>
                    </tbody>
        <%
                } else {
        %>
                    <tr><td colspan='5'>Nessun libro trovato</td></tr>
        <%
                }

                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

    <form action="../deleteRent/deleteRent.jsp" method="post">
        <button style='margin-top: 20px;' type="submit">Cancella Prestiti Restituiti</button>
    </form>

    <a href="../index.jsp" style="position: fixed; top: 20px; right: 20px; background-color: #333366; color: white; padding: 10px 15px; border-radius: 5px; text-decoration: none;">Torna all'Index</a>
</body>
</html>
