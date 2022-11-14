//if keyboard_check_pressed(vk_space) 
//{
	
//	show_debug_message("sending message!");
//	buffer_seek(player_buffer, buffer_seek_start, 0);
//	buffer_write(player_buffer, buffer_text, "hello!");
//	network_send_udp_raw(client, localhost, port, player_buffer, buffer_tell(player_buffer));
//}

//if (response == "getName"){
//	msg = get_string_async("What is your name?", "");

//	response = "";
//}

if keyboard_check_pressed(vk_tab)
	useLocalhost = !useLocalhost;

if useLocalhost
	lobbyHost = localhost;
else
	lobbyHost = remoteHost;


if (keyboard_check_pressed(vk_delete) ) {
	var _data = new nwData(msgType.CLEAR_LOBBIES, 0);
	var data = json_stringify(_data);
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_text, data);
	network_send_udp_raw(lobbyServer, lobbyHost, port, server_buffer, buffer_tell(server_buffer));	
	myLobby = noone;
}

if (keyboard_check_pressed(vk_backspace) ) {
	var _data = new nwData(msgType.END_HOST, 0);
	var data = json_stringify(_data);
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_text, data);
	network_send_udp_raw(lobbyServer, lobbyHost, port, server_buffer, buffer_tell(server_buffer));	
	myLobby = noone;
}

if (amIHosting && myLobby) {
	if keyboard_check_pressed(vk_enter)
	{
		canStartGame = false;
		var _data = new nwData(msgType.READY, 0);
		var data = json_stringify(_data);
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_text, data);
		network_send_udp_raw(lobbyServer, lobbyHost, port, server_buffer, buffer_tell(server_buffer));
		//instance_create_layer(0, 0, "Instances", oGame, {connection : connectionType.host});
		//room_goto(rmGame);
	}
} else {
	if (!amIHosting) {
		if keyboard_check_pressed(vk_up)
		{
			selectedLobby += 1;
			if selectedLobby > array_length(lobbies)
				selectedLobby = 0;
		}
		if keyboard_check_pressed(vk_down) 
		{
			if selectedLobby == 0
				selectedLobby = array_length(lobbies) - 1;
			else
			selectedLobby -= 1;
		}
		
		if keyboard_check_pressed(vk_space)
		{
			JoinLobby(selectedLobby);
		}
	}
}

if (canStartGame)  && amIHosting{
	if keyboard_check_pressed(vk_enter) {
		var _data = new nwData(msgType.READY, 0);
		var data = json_stringify(_data);
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_text, data);
		network_send_udp_raw(lobbyServer, lobbyHost, port, server_buffer, buffer_tell(server_buffer));
	}
}
else {
	if ( myLobby == noone) {
		if keyboard_check_pressed(vk_enter) {
			var _lobby = CreateLobby();
		}
	}

}

