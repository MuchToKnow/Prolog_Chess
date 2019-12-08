% Drives the chess game turn by turn once we implement the helper functions
Chess (Board, Turn) :- 
	PrintBoard(Turn, Board),
	GetMove(Turn, OldX, OldY, NewX, NewY),
	ValidateMove(Turn, OldX, OldY, NewX, NewY, Board),
	MakeMove(OldX, OldY, NewX, NewY, Board, Board1),
	CheckGameEnd(Board1),
	Other(Turn, NextTurn),
	Chess(Board1, NextTurn)).

Other(b, w).
Other(w, b).
