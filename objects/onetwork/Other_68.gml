
//show_debug_message(json_encode(async_load));
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
					lobbies = data;
				break;
				case msgType.START_GAME:
					show_debug_message("Starting game!");
					//instance_create_layer(0, 0, "Instances", oGame, {connection : connectionType.client});
					//room_goto(rmGame);
				break;
				//case msgType.JOIN_HOST:
			
				//break;
			}
	
			show_debug_message(responseMsg);	
		}		
        break;
} 



	


