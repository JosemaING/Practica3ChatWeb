function validarFormLogin(){

	var cliente = document.forms["form_login"]["cliente"].value
	var resultado = true;

	if (cliente == null || cliente == ""){
		alert("Se debe indicar un nombre");
		resultado = false;
	}
	
	return resultado;
}


function validarFormChat(cliente, server){

	var mensaje = document.forms["form_chat"]["mensaje"].value
	var usuario = document.forms["form_chat"]["usuario"].value
	var resultado = true;
	
	if ((mensaje == null || mensaje == "") && (usuario == null || usuario == "")){
		textoAlerta = "Rellene Mensaje o Usuario a bloquear";
		alert(textoAlerta)
		resultado = false;
	}
	else if ((mensaje != null && mensaje != "") && (usuario != null && usuario != "")){
		textoAlerta = "Rellene SOLO UNA OPCION: Mensaje o Usuario a bloquear";
		alert(textoAlerta)
		resultado = false;
	}
	
	return resultado;
}
