package es.ubu.lsi;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Clase Chat Server para gestionar los usuarios conectados a un Chat Web.
 * Gestiona un mapa de usuarios baneados y un mapa de los mensajes enviados al
 * servidor.
 * 
 * (El código contiene souts para poder depurar y encontrar fallos en el log del
 * servidor.)
 * 
 * @author Jose Maria Santos
 *
 */

public class ChatServer {

	/**
	 * Lista de usuarios conectados
	 */
	private List<String> usuariosList = new ArrayList<String>();

	/**
	 * Mapa de mensajes de un usuario
	 */
	private Map<String, ArrayList<String>> mensajesMap = new HashMap<String, ArrayList<String>>();

	/**
	 * Mapa de usuarios baneados, true si está baneado, false si no
	 */
	private Map<String, Boolean> baneadosMap = new HashMap<>();

	/**
	 * Formato del reloj, hora:minutos:segundos
	 */
	private SimpleDateFormat sdf = new SimpleDateFormat("hh:mm:ss");

	/**
	 * Devuelve una lista de todos los usuarios excepto el usuario pasado por
	 * parametro
	 * 
	 * @param usuario a excluir de la lista
	 * @return users lista de usuarios
	 */
	public List<String> getUsuarios(String usuario) {
		ArrayList<String> users = new ArrayList<>();
		for (String user : usuariosList) {
			if (!user.equals(usuario)) users.add(user);
		}
		return users;
	}

	/**
	 * Agrega un nuevo usuario a la lista de usuarios, a los mensajes y al mapa de
	 * usuarios baneados
	 * 
	 * @param usuario String usuario que se registra
	 */
	public void logIn(String usuario) {
		usuariosList.add(usuario);
		mensajesMap.put(usuario, new ArrayList<String>());
		baneadosMap.put(usuario, false);
		broadcast("SERVER", ("< " + usuario + " ha accedido al chat >"));
	}

	/**
	 * Agrega el mensaje al mapa de mensajes del usaurio, y establece el formato del
	 * mensaje con el que se mostrará en el servidor
	 * 
	 * @param usuario nombre del user que envia el mensaje
	 * @param mensaje cadena de texto de mensaje
	 */
	public void broadcast(String usuario, String mensaje) {
		String hora = sdf.format(new Date());
		System.out.println("Broadcasting: " + mensaje);

		for (String user : mensajesMap.keySet()) {
			if (user.equals(usuario)) {
				// Mensajes del usuario actual a la derecha
				mensajesMap.get(user).add("<span class='user-msg'>" + "[" + hora + "] Tú: " + mensaje + "</span><br>");
			} else if (usuario.equals("SERVER")) {
				// Mensajes del servidor
				mensajesMap.get(user).add(
						"<span class='server-msg'>" + "[" + hora + "] " + usuario + ": " + mensaje + "</span><br>");
			} else {
				// Mensajes de otros usuarios a la izquierda
				mensajesMap.get(user)
						.add("<span class='other-msg'>" + "[" + hora + "] " + usuario + ": " + mensaje + "</span><br>");
			}
			System.out.println("Mensaje añadido para " + user);
		}
	}

	/**
	 * Genera el texto de la lista de mensajes de un usuario, si el usuario está
	 * baneado no se obtendrán sus mensajes.
	 * 
	 * @param usuario nombre del user del que se obtendran mensajes
	 * @return texto cadena de texto con el mensaje
	 */
	public String getUserMessages(String usuario) {
		if (bannedUser(usuario)) {
			return "Estás baneado y no puedes ver los mensajes.\nTampoco puedes banear o desbanear a usuarios.";
		}

		String texto = "";
		ArrayList<String> mensajesUsuario = mensajesMap.get(usuario);

		for (String mensajeUsuario : mensajesUsuario) {
			texto += mensajeUsuario + "<br>";
		}

		return texto;
	}

	/**
	 * Recibe el mensaje de un usuario
	 * 
	 * @param usuario nombre del user que envia el mensaje
	 * @param msg     cadena de texto con el mensaje a enviar
	 * 
	 */
	public void receiveMessage(String usuario, String msg) {
		if (!msg.isEmpty() && !bannedUser(usuario)) { // Verificar que no esté baneado
			System.out.println("Recibiendo mensaje de " + usuario + ": " + msg);
			broadcast(usuario, msg);
		}

	}

	/**
	 * Elimina a un usuario del servidor y sus mensajes, no se elimina de la lista
	 * de baneados aunque salga del servidor
	 * 
	 * @param usuario nombre del user que se registra
	 */
	public void logOut(String usuario) {
		broadcast("SERVER", ("< " + usuario + " sale del chat >"));
		usuariosList.remove(usuario);
		mensajesMap.remove(usuario);
		// Al salirte sigues baneado
	}

	/**
	 * Establece al usuario que se pasa como parametro como baneado, cambiando su
	 * valor en el mapa de baneados a true.
	 *
	 * @param userToBan usuario a banear
	 * @param requestor usuario que realzia el baneo
	 */
	public void banUser(String userToBan, String requestor) {
		if (!baneadosMap.get(requestor)) { // Si el requestor no esta baneado puede banear
			if (!userToBan.equals(requestor)) { // No se puede banear a si mismo
				baneadosMap.put(userToBan, true);
				broadcast("SERVER", ("< " + userToBan + " ha sido baneado por " + requestor + " >"));
			} else {
				System.out.println("Intento de banearse a sí mismo: " + requestor);
			}
			return;
		}

	}

	/**
	 * Establece al usuario que se pasa como parametro como desbaneado, cambiando su
	 * valor en el mapa de baneados a false.
	 *
	 * @param userToUnban usuario a desbanear
	 * @param requestor   usuario que realzia el desbaneo
	 */
	public void unbanUser(String userToUnban, String requestor) {
		if (!baneadosMap.get(requestor)) { // Si el requestor no esta baneado puede desbanear
			if (!userToUnban.equals(requestor)) { // No se puede desbanear a si mismo
				if (baneadosMap.containsKey(userToUnban) && baneadosMap.get(userToUnban)) {
					// solo desbanea si está previamente baneado
					baneadosMap.put(userToUnban, false);
					broadcast("SERVER", ("< " + userToUnban + " ha sido desbaneado por " + requestor + " >"));
				}
			} else {
				System.out.println("Intento de desbanearse a sí mismo: " + requestor);
			}
		}
	}

	/**
	 * Verifica si el usuario pasado como parametro ha sido baneado.
	 *
	 * @param usuario a comprobar si esta baneado
	 * @return true si el usuario ha sido marcado como baneado, false en caso
	 *         contrario
	 */
	public boolean bannedUser(String usuario) {
		if (!baneadosMap.containsKey(usuario)) return false;

		return baneadosMap.get(usuario);
	}

	/**
	 * Comprueba si un usuario está actualmente conectado al servidor.
	 *
	 * @param usuario nombre del usuario a comprobar.
	 * @return true si el usuario está conectado, false si no
	 */
	public boolean isUserConnected(String usuario) {
		return usuariosList.contains(usuario);
	}

}
