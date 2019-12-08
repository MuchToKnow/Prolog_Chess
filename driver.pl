Chess (Board, Turn) :- 
	PrintBoard(Turn, Board),
	GetMove(Turn, OldX, OldY, NewX, NewY),
	ValidateMove(Turn, OldX, OldY, NewX, NewY, Board),
	MakeMove(OldX, OldY, NewX, NewY, Board, Board1),
	CheckGameEnd(Board1),
	Chess(Board1, other(Turn)).
