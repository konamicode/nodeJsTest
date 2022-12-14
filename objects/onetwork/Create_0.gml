#macro localhost "127.0.0.1"
enum msgType {
	PING,
	GET_LOBBIES,
	CREATE_HOST,
	JOIN_HOST,
	PLAYER_JOINED,
	READY,
	START_GAME,
	END_HOST,
	CLEAR_LOBBIES,
	RELAY,
	QUIT
}


//lobbyHost = network_resolve("https://nodejs-lobby.azurewebsites.net");
if useLocalhost
	lobbyHost = localhost;
else
	lobbyHost = remoteHost;
//show_debug_message("resolved ip: " + string(lobbyHost));
port = 3002;


amIHosting = false;
myLobby = noone;
canStartGame = false;

socket_list = ds_list_create();

//lobbyServer = network_create_socket(network_socket_ws);
//network_connect_raw(lobbyServer, lobbyHost, port);


gameServer = noone;

player_buffer = buffer_create(100, buffer_fixed, 100);
server_buffer = buffer_create(100, buffer_grow, 100);
response = "";
msg = "";
networkInput = "";

function nwData(_type = msgType.PING, _data = {}, _destIP = -1, _destPort = -1) constructor {
	type = _type;
	destIP = _destIP;
	destPort = _destPort;
	data = _data;
}



Lobby = function (_name, _passwd) constructor{
	lobbyName = _name;
	hostIP = "";
	maxPlayers = 2;
	clients = [];
	ports = [];
	players = [];
	password = _passwd;
	
	function AddPlayer(_player, ip)
	{
		array_push(players, _player);
	}
}

function CreateLobby() {
	var _name = get_string("Enter Lobby Name", "Test");
	var _passwd = get_string("Give lobby a password?", "");
	var lobby = new Lobby(_name, _passwd);
	lobby.AddPlayer("me!");	
	var _data = new nwData(msgType.CREATE_HOST, lobby);
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_text, json_stringify(_data));
	lobbyServer = network_create_socket(network_socket_udp);
	network_connect_raw(lobbyServer, lobbyHost, port);
	network_send_raw(lobbyServer, server_buffer, buffer_tell(server_buffer));
	amIHosting = true;
	gameServer = network_create_server(network_socket_udp, port, 2);
	myLobby = lobby;
	return lobby;
}

function CancelLobby() {
		
}

function GetLobbyList() {
	show_debug_message("starting connection");
	lobbyServer = network_create_socket(network_socket_udp);
	network_connect_raw(lobbyServer, lobbyHost, port);
	var data = new nwData(msgType.GET_LOBBIES);
	show_debug_message(data);
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_text, json_stringify(data));
	network_send_raw(lobbyServer, server_buffer, buffer_tell(server_buffer));
	alarm[0] = 90;
}

function JoinLobby(lobbyIndex) {
	//join the connection
	var data = new nwData(msgType.JOIN_HOST, lobbyIndex);
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_text, json_stringify(data));
	network_send_raw(lobbyServer, server_buffer, buffer_tell(server_buffer));	
	//serverSocket = network_create_socket(network_socket_udp);

}

function QuitLobby() {
	
}


StartGame = function(data) {
	var clients = variable_struct_get(data, "clients");
	var ports = variable_struct_get(data, "ports");
	show_debug_message("Starting game!");
	global.isClient = !amIHosting;
	global.gameHostIP = clients[0];
	global.gameHostPort = ports[0];
	global.gameClientIP = clients[1];
	global.gameClientPort = ports[1];
	//instance_create_layer(0, 0, "Instances", oGame, {connection : connectionType.client});
	room_goto(rmGame);
}


function AttemptConnect(_lobby) {
	if (passwd) {
		var _input = get_string("Lobby Password Required", "");
		if (_input == _lobby.password)
		{}
		else
			show_message("Incorrect Password");
	} else {
		JoinLobby(_lobby)		
	}
}

lobbies = [];
selectedLobby = 0;
GetLobbyList();
