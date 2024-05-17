<%@page import="java.util.Date"%>

<%@ page import = "es.ubu.lsi.ChatServer" %>
<jsp:useBean id="server" class="es.ubu.lsi.ChatServer" scope="application"/>

<% HttpSession sesion = request.getSession();
	String usuario =  (String)sesion.getAttribute("usuario");
	String msg = request.getParameter("mensaje");
	
   
	server.receiveMessage(usuario, msg);
	response.sendRedirect("index.jsp");
%>