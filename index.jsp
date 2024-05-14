<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Utente</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 40px;
            background-color: #f9f9f9;
            color: #333;
            position: relative; /* Aggiunto per posizionare il pulsante in alto a destra */
        }

        header {
            background-color: #333366;
            color: #fff;
            padding: 15px;
            text-align: center;
        }

        h1 {
            margin-top: 0;
            font-size: 2em;
        }

        .welcome-message {
            font-size: 1.5em;
            margin-bottom: 20px;
            text-align: center;
        }

        nav {
            margin-bottom: 30px;
        }

        nav a {
            display: block;
            margin: 10px 0;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        nav a:hover {
            background-color: #0056b3;
        }

        footer {
            position: absolute; /* Aggiunto per posizionare il footer */
            top: 10px; /* Distanza dalla cima */
            right: 10px; /* Distanza dalla destra */
        }

        footer a {
            display: block;
            margin: 10px 0;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            color: #000;
            background-color: #ed665c;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
    </style>
</head>
<body>
    <% 
        session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login/login.html");
        }
    %>

    <header>
        <h1>Area Utente</h1>
    </header>

    <div class="welcome-message">
        Benvenuto, <%= session.getAttribute("email") %>!
    </div>

    <nav>
        <a href="addBook/addBook.html">Aggiungi un nuovo libro</a>
        <a href="showBooks/showBooks.jsp">Visualizza i libri disponibili</a>
        <a href="rentHistory/rentHistory.jsp">Storico prestiti</a>
    </nav>

    <footer>
        <a href="login/login.html">Esci</a>
    </footer>
</body>
</html>
