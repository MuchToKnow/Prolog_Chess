% Drives the chess game turn by turn once we implement the helper functions
chess(Board, Turn) :- 
	printBoard(Turn, Board),
	getMove(Turn, OldX, OldY, NewX, NewY),
	validateMove(Turn, OldX, OldY, NewX, NewY, Board),
	makeMove(OldX, OldY, NewX, NewY, Board, Board1),
	checkGameEnd(Board1),
	other(Turn, NextTurn),
	chess(Board1, NextTurn)).

other(b, w).
other(w, b).

% A board is just a list of pieces.
% ex. board = [piece(1,1,k,w), piece(1,2,e,na), piece(2,2,p,b)]
% piece(X, Y, Type, Color)
% Empty square:
% piece(X, Y, e, na)
