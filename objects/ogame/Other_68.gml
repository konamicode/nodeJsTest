show_debug_message(json_encode(async_load));


if (async_load[? "size"] > 0)
{
	var buffer = async_load[? "buffer"];	
	buffer_seek(buffer, buffer_seek_start, 0);
	
	var incoming = json_parse(buffer_read(buffer, buffer_string));
	var type = variable_struct_get(incoming, "type");
	var data = variable_struct_get(incoming, "data");
	
	switch(type) {
		case msgSource.client:
			if (connection == connectionType.host) {
				var remoteInput = variable_struct_get(data, "input");
				var _instance = players[2].playerInstance;
				players[2].updatePosition(_instance.x, input * -moveSpeed);
			}
		break;
		case msgSource.host:
			//send ball and player locations
			if (connection == connectionType.client){
				var newGameStatus = variable_struct_get(data, "gameStatus");
			}
		break;
	}
	
}