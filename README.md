--------------------------------------------------------------------------------
AUTOR:
--------------------------------------------------------------------------------

Nombre del Autor: José María Santos

Email: jsr1002@alu.ubu.es

Fecha: 17/05/2024

--------------------------------------------------------------------------------
DESCRIPCIÓN:
--------------------------------------------------------------------------------

Este proyecto incluye un la gestión de un chat web implementado en Java.
Se proporcionan los comandos y pasos para facilitar la puesta a punto
y la ejecución con Glassfish 5.

Es importante no modificar el fichero pom.xml para
asegurar el correcto funcionamiento del proyecto.

Para iniciar el servidor, se deben seguir las instrucciones
detalladas en la sección de ejecución. Cualquier usuario puede salirse del servidor
o banear y desbanear a cualquier otro cliente.

Un usuario baneado no puede leer los mensajes de otros clientes
ni podrá enviar mensajes hasta que este sea desbaneado,
un cliente no puede banearse ni desbanearse a si mismo, tampoco
lo hará si está previamente baneado.

--------------------------------------------------------------------------------
REQUISITOS:
--------------------------------------------------------------------------------

1. Maven instalado y configurado correctamente.
2. Servidor con Glassfish 5 configurado correctamente.
2. Java JDK versión 8 o superior.
3. No modificar el fichero pom.xml para evitar problemas en la ejecución.

--------------------------------------------------------------------------------
EJECUCIÓN:
--------------------------------------------------------------------------------
Para la puesta a punto del servidor:

1. Ejecutar el comando `mvn clean package` en Practica3ChatWeb.
2. Desde Eclipse, antes de iniciar el servidor realizar 'Alt + F5' de ambos proyectos.
3. Asegurar que `Practica3ChatWeb-0.0.1-SNAPSHOT.jar` está añadido como resource al servidor Glassfish.
4. Iniciar el servidor desde Eclipse.
5. En el directorio `glassfish5\glassfish\domains\domain1\logs` ejecutar `tail -f server.log` para visualizar la depuración del servidor.

--------------------------------------------------------------------------------
USOS DEL CHAT:
--------------------------------------------------------------------------------

- `logout`: Cierra la sesión del cliente.
- `ban`: Banea a un usuario especifico "username".
- `unban`: Desbanea a un usuario especifico "username".

--------------------------------------------------------------------------------
SUGERENCIAS:
--------------------------------------------------------------------------------
- Se incluyen en la carperta `Screenshots`, capturas del correcto funcionamiento de la aplicación.
Una del login, otra del envío y recepción de mensajes y otra del desbaneo y baneo a ususarios.

- Se ha realizado una limpieza del proyecto con Maven `mvn clean`.
Se sugiere no realizar modificaciones en el archivo `pom.xml` para mantener la estabilidad del proyecto.

- Se ha realizado la ejecución con ANT `ant`, que compila, empaqueta y documenta.
Se sugiere no realizar modificaciones en el archivo `build.xml` para mantener la estabilidad del proyecto.

- El proyecto incluye ficheros .css, .jsp y .html para el correcto funcionamiento de la web.
Tiene página de login y página de sala del chat.

--------------------------------------------------------------------------------
