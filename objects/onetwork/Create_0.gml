#macro localhost "127.0.0.1"
enum msgType {
	PING,
	GET_LOBBIES,
	CREATE_HOST,
	JOIN_HOST,
	START_GAME,
	QUIT
}

remoteHost = "127.0.0.1";
lobbyHost = network_resolve("https://nodejs-lobby.azurewebsites.net");
lobbyHost = localhost;
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

function nwData(_type = msgType.PING, _data = {}) constructor {
	type = _type;
	data = _data;
}



Lobby = function (_name, _passwd) constructor{
	lobbyName = _name;
	hostIP = "";
	maxPlayers = 2;
	clients = [];
	players = [];
	password = _passwd;
	
	function AddPlayer(_player)
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
	gameServer = network_create_server(network_socket_udp, 8081, 2);
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
}

function JoinLobby(lobbyIndex) {
	//join the connection
	var data = new nwData(msgType.JOIN_HOST, lobbyIndex);
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_text, json_stringify(data));
	network_send_raw(lobbyServer, lobbyHost, port, server_buffer, buffer_tell(server_buffer));	
	serverSocket = network_create_socket(network_socket_udp);
	var ip = lobbies[lobbyIndex].hostIP;
	var connection = network_connect_async(serverSocket, lobbyHost, 8081);
	if (connection)
	{
		show_message("Connected!")
	}
}

function QuitLobby() {
	
}


function StartGame() {
	
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
