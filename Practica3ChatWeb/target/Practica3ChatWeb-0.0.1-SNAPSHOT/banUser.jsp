<%@ page import="es.ubu.lsi.ChatServer" %>
<jsp:useBean id="server" class="es.ubu.lsi.ChatServer" scope="application"/>
<%  HttpSession sesion = request.getSession();
    String requestor = (String) sesion.getAttribute("usuario"); // Obtiene el usuario actual de la sesión
    String usernameToBanOrUnban = request.getParameter("username");
    String action = request.getParameter("action");

    if ("ban".equals(action)) {
        server.banUser(usernameToBanOrUnban, requestor);
    } else if ("unban".equals(action)) {
        server.unbanUser(usernameToBanOrUnban, requestor);
    }

    response.sendRedirect("index.jsp");
%>
