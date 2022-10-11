for ( var i = 0; i < connectedPlayers; i++)	
{
	var inst = instance_create_layer((room_width * i) - (i * sprite_width), room_height/2, "Instances", oPlayerBat );
	//if (connection == connectionType.host)
	//{
	//	inst.connection = connectionType.host;
	//}
	//else
	//	inst.connection = connectionType.client;
	players[i] = new Player(inst);
}

if (connection == connectionType.host )
{
	currentGame = new gameState(players);
}