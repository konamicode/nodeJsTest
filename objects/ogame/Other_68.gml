//show_debug_message(json_encode(async_load));

switch(async_load[? "type"]) {
	case network_type_connect:
		//show_message("connected!");
		clientSocket = async_load[? "socket"];
		//start game!
		currentGame.Reset();
	break;
	case network_type_data:
		if (async_load[? "size"] > 0)
		{
			var buffer = async_load[? "buffer"];	
			buffer_seek(buffer, buffer_seek_start, 0);
	
			var incoming = json_parse(buffer_read(buffer, buffer_string));
			var source = variable_struct_get(incoming, "source");
			var data = variable_struct_get(incoming, "data");
			show_debug_message(data)
			switch(source) {
				case msgSource.client:
					if (connection == connectionType.host) {
						var remoteInput = data;
						var _instance = players[1].playerInstance;
						players[1].updatePosition(_instance.x, remoteInput * -moveSpeed);
						//currentGame.Update();
					}
				break;
				case msgSource.host:
					//send ball and player locations
					if (connection == connectionType.client){
						//
						var status = variable_struct_get(data, "status");
						var ball = variable_struct_get(data, "ball");
						var player1 = variable_struct_get(data, "player1");
						var player2 = variable_struct_get(data, "player2");
						var _players = variable_struct_get(data, "players");
						oBall.x = ball.x;
						oBall.y = ball.y;
						players[0].playerScore = _players[0].playerScore;
						players[1].playerScore = _players[1].playerScore;
						players[0].playerInstance.x = player1.x;
						players[0].playerInstance.y = player1.y;
						players[1].playerInstance.x = player2.x;
						players[1].playerInstance.y = player2.y;
						currentGame.UpdateStatus(status);
						currentGame.Update();
						if (currentGame.status == gameStatus.complete)						
						{
							currentGame.winner = variable_struct_get(data, "winner");
						}
						//currentGame.Update(ball.x, ball.y, player1.x, player1.y, player2.x, player2.y);
					}
				break;
			}
	
		}
	break;
}