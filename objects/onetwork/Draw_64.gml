if useLocalhost
	draw_text(5, 5, "Using localHost");
	
if (room == rmNetworkSetup) {
	draw_set_halign(fa_center);
	draw_text(window_get_width()/2, 5, "Lobbies:" );
	draw_set_halign(fa_left);
	draw_text(5, 24, "Name");
	draw_text(125, 24, "IP");
	draw_text(245, 24, "PW");
	draw_text(345, 24, "Players");


	for (var i = 0; i < array_length(lobbies); i++) {
			var _lobbyStruct = lobbies[i];
			var _lobbyName = variable_struct_get(_lobbyStruct, "lobbyName");
			var _ip = variable_struct_get(_lobbyStruct, "hostIP");
			var _pw = variable_struct_get(_lobbyStruct, "password");
			var _players = variable_struct_get(_lobbyStruct, "players");
			var _max = variable_struct_get(_lobbyStruct, "maxPlayers");
			if (amIHosting == false) && (selectedLobby == i)
				draw_set_color(c_green);
			draw_text(5, 40 + ( i * 18), _lobbyName);
			draw_text(125, 40 + ( i * 18), _ip);
			if (_pw != "" )
				_pw = "Yes";
			else
				_pw = "No";
			draw_text(245, 40 + ( i * 18), _pw);
			draw_text(345, 40 + ( i * 18), string ( array_length(_players) ) + "/" + string(_max));
			draw_set_color(c_white);
	}

	if (canStartGame) {
		draw_text(400, 5, "Press Enter to Start Game");	
	}	
}