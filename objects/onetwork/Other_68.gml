
//show_debug_message(json_encode(async_load));

if room == rmNetworkSetup {
	var type_event = ds_map_find_value(async_load, "type");

	switch (type_event)
	{
	    case network_type_connect:
		case network_type_non_blocking_connect:
			canStartGame = true;
	        socket = ds_map_find_value(async_load, "socket");
	        ds_list_add(socket_list, socket);
	        break;

	    case network_type_disconnect:
	        socket = ds_map_find_value(async_load, "socket");
	        ds_list_delete(socket_list, ds_list_find_index(socket_list, socket));
	        break;

	    case network_type_data:
	        //buffer = ds_map_find_value(async_load, "buffer");
	        //socket = ds_map_find_value(async_load, "id");
	        //buffer_seek(buffer, buffer_seek_start, 0);
	        //received_packet(buffer, socket);
			if (async_load[? "size"] > 0)
			{
				var buffer = async_load[? "buffer"];	
				buffer_seek(buffer, buffer_seek_start, 0);
	
				responseMsg = json_parse(buffer_read(buffer, buffer_string));
	
				var type = variable_struct_get(responseMsg, "type");
				var data = variable_struct_get(responseMsg, "data");
				switch(type) {
					case msgType.GET_LOBBIES:
						with(oJoinLobbyButton)
						{
							instance_destroy();
						}
						for (var i = 0; i < array_length(lobbies); i++) {
							var _playerCount = variable_struct_get(lobbies[i], "players");
							show_debug_message(array_length(_playerCount));
							if (array_length(_playerCount) < 2) {
								instance_create_layer(608, 40 + ( i * 18 ), "Instances", oJoinLobbyButton, {lobbyID : i});
							}
						}						
						lobbies = data;
					break;
					case msgType.PLAYER_JOINED:
						lobbies = data;
						if amIHosting
							canStartGame = true;	
					break;
					case msgType.START_GAME:
						StartGame(data);
					break;
					//case msgType.JOIN_HOST:
			
					//break;
				}						

				show_debug_message(responseMsg);	
			}		
	        break;
	} 


}
	


