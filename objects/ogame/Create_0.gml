enum connectionType {
	host,
	client
}

enum msgSource {
	host,
	client
}

enum gameStatus {
	inPlay,
	start,
	goal
	
}


randomize();

gameBuffer = buffer_create(100, buffer_grow, 100);
clientSocket = 0;
connectedPlayers = 2;

moveSpeed = 4;

players = array_create(connectedPlayers);

Player = function(instance) constructor {
	playerId = instance_number(oPlayerBat);
	playerScore = 0;
	playerInstance = instance;
	
	function updatePosition(xDelta = 0, yDelta = 0) {

		playerInstance.x = playerInstance.x;
		playerInstance.y = clamp(playerInstance.y + yDelta, 0 + sprite_get_yoffset(sprPlayerBat), room_height - sprite_get_yoffset(sprPlayerBat));
	}
	
}


gameState = function(_players) constructor {
	players = _players;
	actor = function(_x, _y) constructor {
		x = _y;
		y = _y;
		
		static Update = function(_instance) {
			x =_instance.x;
			y =_instance.y;
		}
	}
	
	var _ball = instance_create_layer(room_width/2, room_height/2, "Instances", oBall);
	ball = new actor(_ball.x, _ball.y);
	player1 = new actor(players[0].playerInstance.x, players[0].playerInstance.y);
	player2 = new actor(players[1].playerInstance.x, players[1].playerInstance.y);

	static Update = function() {
		ball.Update(oBall);
		player1.Update(players[0].playerInstance);
		player2.Update(players[1].playerInstance);
	}
}

