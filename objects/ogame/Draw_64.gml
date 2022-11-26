draw_text(5, 5, "Player 1: " + string(players[0].playerScore));
draw_text(room_width - 100, 5, "Player 2: " + string(players[1].playerScore));

switch(currentGame.status) {
	case gameStatus.waitingOnConnection:
		draw_set_halign(fa_center);
		draw_text(window_get_width() / 2, window_get_height()/ 2, "Waiting for Connection!");
		draw_set_halign(fa_left);
	break;
	case gameStatus.goal:
		draw_set_halign(fa_center);
		draw_text(window_get_width() / 2, window_get_height()/ 2, "Score!");
		draw_set_halign(fa_left);	
	break;
	case gameStatus.start:
		draw_set_halign(fa_center);
		draw_text(window_get_width() / 2, window_get_height()/ 2, "Get Ready!");
		draw_set_halign(fa_left);
	break;
	case gameStatus.complete:
		draw_set_halign(fa_center);
		draw_text(window_get_width() / 2, window_get_height()/ 2, "Game Over! Player " + string(currentGame.winner) + " Wins!");
		draw_text(window_get_width() / 2, window_get_height()/ 2 + 30, "Returning to lobby in " + string( alarm[0] div 30 ) );
		draw_set_halign(fa_left);
	break;
		
}