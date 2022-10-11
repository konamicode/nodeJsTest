var _id = ds_map_find_value(async_load, "id");
if (_id == msg) {
	if ds_map_find_value(async_load, "status")
	{
		if ds_map_find_value(async_load, "result") != ""
		{
		    networkInput = ds_map_find_value(async_load, "result");
		}
	}
	show_debug_message(networkInput);
	if (networkInput != "") {
		buffer_seek(player_buffer, buffer_seek_start, 0);
		buffer_write(player_buffer, buffer_text, networkInput);
		network_send_udp_raw(client, localhost, 8080, player_buffer, buffer_tell(player_buffer));
	}	
	
}