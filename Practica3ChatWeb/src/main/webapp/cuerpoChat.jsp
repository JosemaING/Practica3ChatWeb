<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="es.ubu.lsi.ChatServer"%>
<jsp:useBean id="server" class="es.ubu.lsi.ChatServer" scope="application"/>

<%

String user = (String) session.getAttribute("usuario");
String textoChat = server.getUserMessages(user);
List<String> Usuarios = server.getUsuarios(user);

// Asegurarse de que el usuario no sea null y que haya cearrado sesión.
if (user != null && !server.isUserConnected(user)) {
    session.setAttribute("usuario", null); // Establecer a null para limpiar el atributo
    response.sendRedirect("index.jsp"); // Redirige al usuario a la página de inicio de sesión o índice
}
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <!-- Estilos para la página de la sala del chat -->
   <style>
    body, html {
        height: 100%;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Arial', sans-serif;
        background: url("img/background.jpg") no-repeat center center fixed;
        background-size: cover;
    }
    .chat-container {
        width: 80%; /* Asegura que el contenedor use el 80% del ancho */
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0px 8px 16px rgba(0,0,0,0.1);
        text-align: center;
        margin: auto;
        align-items: stretch; /* Alinea los elementos hijos a lo ancho del contenedor */
        display: flex;
        flex-direction: column; /* Organiza los contenedores de formularios en columna */
    }
    }
    .form-field {
        display: flex; /* Esto crea un layout flexible para los elementos del formulario */
        justify-content: space-between; /* Distribuye espacio uniformemente */
        margin: 10px 0;
        width: 100%;
        align-items: center; /* Alinea verticalmente los elementos del formulario */
    }
    .button-container {
        display: flex; /* Alinea los botones en la misma fila */
        gap: 10px; /* Espacio entre botones */
    }
    textarea, select, input[type="text"], input[type="submit"], input[type="reset"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }
    input[type="submit"], input[type="reset"] {
        background-color: #007bff;
        color: white;
        cursor: pointer;
    }
    input[type="submit"]:hover, input[type="reset"]:hover {
        background-color: #0056b3;
    }
    button {
        background-color: #007bff;
        color: white;
        cursor: pointer;
        padding: 10px;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        width: 100%;
    }
    button:hover {
        background-color: #0056b3;
    }
    .user-msg {
        background-color: #9BCBFF;
        color: black;
        text-align: right;
        display: block;
        clear: both;
        border-radius: 15px;
        padding: 5px 10px;
        margin: 5px;
        max-width: 80%;
        float: right;
    }
    .other-msg {
        background-color: #0400FF;
        color: white;
        text-align: left;
        display: block;
        clear: both;
        border-radius: 15px;
        padding: 5px 10px;
        margin: 5px;
        max-width: 80%;
        float: left;
    }
    .server-msg {
    	color: black;           /* Cambia el color del texto a negro */
    	text-align: center;     /* Alinea el texto al centro del bocadillo */
    	display: block;
    	clear: both;
    	border-radius: 15px;
    	padding: 5px 10px;
   		margin: 5px auto;       /* Centra el bocadillo horizontalmente */
    	max-width: 80%;
    	background-color: #f0f0f0; /* Un fondo claro para destacar los mensajes del servidor */
    	float: none;            /* Elimina el float para que se centre automáticamente */
    	box-shadow: 0 2px 5px rgba(0,0,0,0.2); /* Añade una sombra para mejor visualización */
}

    .messages {
    	width: 100%;
        height: 300px;
        overflow-y: auto;
        background: #f9f9f9;
        box-shadow: inset 0 0 10px #ccc;
        padding: 10px;
        border-radius: 5px; 
        margin-top: 15px;
    }
</style>
<!-- Fin de estilos para la página de la sala del chat -->
    <script>
        setTimeout(function() {
            location.reload();
        }, 10000); // Recarga la página cada 10 segundos
    </script>  
</head>
<!-- Contenido de la página de la sala del chat -->
<body>
    <div class="chat-container" style="position: absolute;">
        <h2>¡Hola <%= user %>!</h2>
        <a href="logout.jsp" style="position: absolute; top: 20px; right: 20px;">LogOut</a>
        <form name="form_chat" id="form_chat" method="POST" action="enviaSolicitudChat.jsp">
            <div class="form-field">
                Mensaje:<br>
                <textarea name="mensaje" rows="3"></textarea>
            </div>
            <div class="form-field button-container"> <!-- Contenedor específico para botones -->
        <input type="submit" value="Enviar">
        <input type="reset" value="Borrar">
    </div>
        </form>
        <form action="banUser.jsp" method="post">
            <div class="form-field">
                <label for="username">Usuario:</label>
                <input type="text" id="username" name="username" required>
                <input type="radio" id="ban" name="action" value="ban" checked>
                <label for="ban">Banear</label>
                <input type="radio" id="unban" name="action" value="unban">
                <label for="unban">Desbanear</label>
                <button type="submit">Enviar</button>
            </div>
        </form>
        <div class="messages">
            <p><%= textoChat %></p>
        </div>
    </div>
</body>
<!-- Fin del contenido de la página de la sala del chat -->
</html>
