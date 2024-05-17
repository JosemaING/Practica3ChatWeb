<%@ page import = "es.ubu.lsi.ChatServer" %>
<jsp:useBean id="server" class="es.ubu.lsi.ChatServer" scope="application"/>

<% 
HttpSession sesion = request.getSession();
String usuario = (String)sesion.getAttribute("usuario");

server.logOut(usuario);
sesion.setAttribute("usuario", ""); 

response.sendRedirect("login.html");
%>
