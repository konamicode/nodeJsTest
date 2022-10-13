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

		var data = json_stringify(new gameData(msgSource.client, players[1].playerId, input));
		buffer_seek(gameBuffer, buffer_seek_start, 0);
		buffer_write(gameBuffer, buffer_text, data);
		network_send_raw(serverSocket, gameBuffer, buffer_tell(gameBuffer));	
		
	break;
	
	case connectionType.host:
	
		if (oBall.x < 0) {
			
		}	
		else if (oBall.x > room_width ){
	
		}
		
		players[0].updatePosition(0, input * -moveSpeed);
		//currentGame.Update();
		currentGame.Update();
		
		var data = json_stringify(new gameData(msgSource.host, -1, currentGame));
		buffer_seek(gameBuffer, buffer_seek_start, 0);
		buffer_write(gameBuffer, buffer_text, data);
		if (clientSocket)
			network_send_raw(clientSocket, gameBuffer, buffer_tell(gameBuffer));
	break;
	
}




