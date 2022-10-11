for ( var i = 0; i < array_length(players); i++)
{
	var _player = players[i];
	_player.updatePosition();
}

var input_down = keyboard_check(vk_down);
var input_up = keyboard_check(vk_up);
var input = input_up - input_down;
switch(connection) {
	case connectionType.client:	

		var data = json_stringify(new gameData(msgSource.client, playerId, input));
		buffer_seek(gameBuffer, buffer_seek_start, 0);
		buffer_write(gameBuffer, buffer_text, data);
		//network_send_raw(client, playerBuffer, buffer_tell(playerBuffer));	
		
	break;
	
	case connectionType.host:
		
		players[0].updatePosition(0, input * -moveSpeed);
		currentGame.Update();
		
		var data = json_stringify(currentGame);
		buffer_seek(gameBuffer, buffer_seek_start, 0);
		buffer_write(gameBuffer, buffer_text, data);
		
	break;
	
}




