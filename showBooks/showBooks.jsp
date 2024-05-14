<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo Libri</title>
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
    <h2>Elenco libri disponibili</h2>
    <div>
        <input type="text" id="searchTitle" placeholder="Cerca per Titolo">
        <input type="text" id="searchAuthor" placeholder="Cerca per Autore">
        <input type="text" id="searchCategory" placeholder="Cerca per Categoria">
        <button onclick="searchBooks()">Cerca</button>
    </div>

    <table>
        <thead>
            <tr>
                <th>Titolo</th>
                <th>Autore</th>
                <th>Anno di Pubblicazione</th>
                <th>Categoria</th>
                <th style='text-align: center;'>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%@ page import="java.sql.*" %>
            <%@ page import="javax.naming.*, javax.sql.*, java.util.*" %>
            <% 
                String searchTitle = request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "";
                String searchAuthor = request.getParameter("searchAuthor") != null ? request.getParameter("searchAuthor") : "";
                String searchCategory = request.getParameter("searchCategory") != null ? request.getParameter("searchCategory") : "";

                try {
                    // Carico il driver JDBC
        Class.forName("com.mysql.jdbc.Driver");
        
        // Connessione al database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/biblioteca", "root", "");

                    String sql = "SELECT * FROM libri WHERE stato = 'disponibile' AND Titolo LIKE '%" + searchTitle + "%' AND Autore LIKE '%" + searchAuthor + "%' AND Categoria LIKE '%" + searchCategory + "%'";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        do {
            %>
                            <tr>
                                <td><%= rs.getString("Titolo") %></td>
                                <td><%= rs.getString("Autore") %></td>
                                <td><%= rs.getInt("AnnoPubblicazione") %></td>
                                <td><%= rs.getString("Categoria") %></td>
                                <td class='center-buttons'>
                                    <form action='../rentBook/rentBook.jsp' method='POST'>
                                        <input type='hidden' name='idLibro' value='<%= rs.getInt("IDLibro") %>'>
                                        <button>Prenota</button>
                                    </form>
                                </td>
                            </tr>
            <%          
                        } while (rs.next());
                    } else {
            %>
                        <tr>
                            <td colspan='5'>Nessun libro trovato</td>
                        </tr>
            <%      
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>

    <script>
        function searchBooks() {
            var searchTitle = document.getElementById("searchTitle").value.trim();
            var searchAuthor = document.getElementById("searchAuthor").value.trim();
            var searchCategory = document.getElementById("searchCategory").value.trim();

            window.location.href = "showBooks.jsp?searchTitle=" + searchTitle + "&searchAuthor=" + searchAuthor + "&searchCategory=" + searchCategory;
        }
    </script>

    <a href="../index.jsp" style="position: fixed; top: 20px; right: 20px; background-color: #333366; color: white; padding: 10px 15px; border-radius: 5px; text-decoration: none;">Torna all'Index</a>

</body>
</html>
