<!DOCTYPE html>
<html>
    <head>
        <title>Chat </title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="javaScript.js"></script>   
    </head>
    <body>
    
 <% HttpSession sesion = request.getSession(true);
    	String usuario = (String)sesion.getAttribute("usuario");
    	if(usuario == null || usuario.isEmpty()) { 
    		response.sendRedirect("login.html");

    	} else { %><%@ include file="cuerpoChat.jsp" %>
	<% } %>  

    </body>
</html>
