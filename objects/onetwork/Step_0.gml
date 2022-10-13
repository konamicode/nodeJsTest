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



if (amIHosting && myLobby) {
	canStartGame = false;
	if keyboard_check_pressed(vk_enter)
	{
		canStartGame = false;
		var _data = new nwData(msgType.START_GAME, 0);
		var data = json_stringify(_data);
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_text, json_stringify(_data));
		network_send_udp_raw(lobbyServer, lobbyHost, port, server_buffer, buffer_tell(server_buffer));
		//instance_create_layer(0, 0, "Instances", oGame, {connection : connectionType.host});
		//room_goto(rmGame);
	}
} else {
	if (!amIHosting) {
		if keyboard_check_pressed(vk_space)
		{
			var ip = 0;
			JoinLobby(ip);
		}
	}
}

if (canStartGame) {
	
}
else {
	if ( myLobby == noone) {
		if keyboard_check_pressed(vk_enter) {
			var _lobby = CreateLobby();
		}
	}

}

