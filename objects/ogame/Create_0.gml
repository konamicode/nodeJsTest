enum connectionType {
	host,
	client
}

enum msgSource {
	host,
	client
}

enum gameStatus {
	waitingOnConnection,
	inPlay,
	start,
	goal,
	complete
	
}


randomize();

gameBuffer = buffer_create(100, buffer_grow, 100);
clientSocket = 0;
connectedPlayers = 2;
port = 3003;

moveSpeed = 8;

players = array_create(connectedPlayers);

Player = function(instance) constructor {
	playerId = instance_number(oPlayerBat);
	playerScore = 0;
	playerInstance = instance;
	
	function updatePosition(xDelta = 0, yDelta = 0) {

		playerInstance.x = playerInstance.x;
		playerInstance.y = clamp(playerInstance.y + yDelta, 0 + sprite_get_yoffset(sprPlayerBat), room_height - sprite_get_yoffset(sprPlayerBat));
	}
	
	static AddPoint = function()
	{
		playerScore += 1;
	}	
}

//networkUpdate = function() {
//	var data = json_stringify(new gameData(msgSource.host, -1, currentGame));
//	buffer_seek(gameBuffer, buffer_seek_start, 0);
//	buffer_write(gameBuffer, buffer_text, data);
//	if (clientSocket)
//		network_send_raw(clientSocket, gameBuffer, buffer_tell(gameBuffer));		
//}

networkUpdate = function(_gmData = -1, _destIP, _destPort) {
	with (oNetwork) {
		var data = json_stringify(new nwData(msgType.RELAY, _gmData, _destIP, _destPort));
		buffer_seek(other.gameBuffer, buffer_seek_start, 0);
		buffer_write(other.gameBuffer, buffer_text, data);
		network_send_udp_raw(lobbyServer, lobbyHost, port, other.gameBuffer, buffer_tell(other.gameBuffer));	
	}
}

gameState = function(_players) constructor {
	players = _players;
	actor = function(_x, _y) constructor {
		x = _y;
		y = _y;
		
		Update = function(_instance) {
			x =_instance.x;
			y =_instance.y;
		}
	}
	
	var _ball = instance_create_layer(room_width/2, room_height/2, "Instances", oBall);
	ball = new actor(_ball.x, _ball.y);
	player1 = new actor(players[0].playerInstance.x, players[0].playerInstance.y);
	player2 = new actor(players[1].playerInstance.x, players[1].playerInstance.y);
	
	status = gameStatus.waitingOnConnection;
	winner = 0;
	matchPoint = 3;
	
	StartGame = function() {
		oBall.x = room_width/2;
		oBall.y = room_height/2;	
		oBall.speed = 2.5;
		oBall.direction = choose(0, 180);		
		status = gameStatus.inPlay;
	}

	Update = function() {
		//UpdateStatus(_status);
		ball.Update(oBall);
		player1.Update(players[0].playerInstance);
		player2.Update(players[1].playerInstance);
		
	
	}
	
	Score = function(_player) {
		_player.AddPoint();
	}
	
	UpdateStatus = function(_newStatus) {
		if _newStatus == gameStatus.start	
			show_debug_message("Start?");
		status = _newStatus;	
	}
	
	Reset = function() {
		self.UpdateStatus(gameStatus.start)

		call_later(3, time_source_units_seconds, self.StartGame);
	}
	
	End = function(_playerNumber) {
		winner = _playerNumber;
		if (!global.isClient) {
			self.UpdateStatus(gameStatus.complete);
			self.Update();
		}
		if (oGame.alarm[0] < 0)
			oGame.alarm[0] = 90;
	}

}

