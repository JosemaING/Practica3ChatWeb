<%@ page import = "es.ubu.lsi.ChatServer" %>
	<jsp:useBean id="server" class="es.ubu.lsi.ChatServer" scope="application"/>
	<jsp:setProperty name="server" property="*"/> 



<% 
HttpSession sesion = request.getSession(true);
sesion.setAttribute("usuario", request.getParameter("usuario")); 
server.logIn(request.getParameter("usuario"));
response.sendRedirect("index.jsp");
%>
