for ( var i = 0; i < connectedPlayers; i++)	
{
	var inst = instance_create_layer((room_width * i) - (i * sprite_width), room_height/2, "Instances", oPlayerBat );
	//if (connection == connectionType.host)
	//{
	//	inst.connection = connectionType.host;
	//}
	//else
	//	inst.connection = connectionType.client;
	players[i] = new Player(inst);
}
if !is_undefined(global.isClient)
{
	connection = global.isClient;
}

if (connection == connectionType.host )
{
	currentGame = new gameState(players);
	server = network_create_server(network_socket_tcp, port, 2);
}
else {
	currentGame = new gameState(players);
	serverSocket = network_create_socket(network_socket_tcp);		
	if !is_undefined(global.gameHostIP)
	{
		gameConnection = network_connect(serverSocket, global.gameHostIP, port);	
	}
	else
		gameConnection = network_connect(serverSocket, "127.0.0.1", port);	
}