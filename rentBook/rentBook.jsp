<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prenota Libro</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 40px;
            background-color: #f9f9f9;
            color: #333;
        }

        h2 {
            color: #333366;
        }

        form {
            max-width: 400px;
            margin: 20px auto;
            padding: 20px;
            border-radius: 5px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        select, input[type="email"], input[type="date"], input[type="submit"] {
            display: block;
            margin-bottom: 15px;
            width: 94%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        select {
            width: 100%;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            width: 100%;
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%@ page import="java.util.*" %>
    <%@ page import="java.text.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="javax.naming.*, javax.sql.*" %>
    <%
        try {
            // Carico il driver JDBC
        Class.forName("com.mysql.jdbc.Driver");
        
        // Connessione al database
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/biblioteca", "root", "");

            String idLibro = request.getParameter("idLibro");
    %>
            <h2>Prenota un libro</h2>   
            <form action="addRent.jsp" method="post">
                <fieldset>
                    <legend>Informazioni prenotazione</legend>
                    <select name="user" id="user" onchange="hideInput()">
                        <option value="me">Per Me</option>
                        <option value="other">Per Qualcun'altro</option>
                    </select>
                    <input type="email" name="email" id="email2" placeholder="E-Mail" style="display: none;">
                    <label for="dataRitornoPrevista">Data Ritorno Prevista</label>
                    <input type="date" name="dataRitornoPrevista" required>
                    <br>
                    <input type="hidden" name="idLibro" value="<%= idLibro %>">
                    <input type="submit" value="Prenota">
                </fieldset>
            </form>

            <a href="../index.jsp" style="position: fixed; top: 20px; right: 20px; background-color: #333366; color: white; padding: 10px 15px; border-radius: 5px; text-decoration: none;">Torna all'Index</a>

            <script>
                function hideInput() {
                    var select = document.getElementById("user");
                    var input = document.getElementById("email1");
                    var text = document.getElementById("email2");

                    if (select.value !== "me") {
                        text.style.display = "block";
                        input.style.display = "block";
                        text.required = true;
                    } else {
                        text.style.display = "none";
                        input.style.display = "none";
                        text.required = false;
                    }
                }

                window.onload = hideInput;
            </script>
    <%
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Errore: " + e.getMessage());
        }
    %>
</body>
</html>
