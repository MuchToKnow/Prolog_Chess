% Sets the cell (NewX, NewY) to the piece at (OldX, OldY).
setNewPos(OldX, OldY, NewX, NewY, [Piece(OldX, OldY, T, C)|R], [Piece(NewX, NewY, T, C)|R]). 
setNewPos(OldX, OldY, NewX, NewY, [Piece(X, Y, T, C)|R], [Piece(X, Y, T, C)|R]) :-
  dif([OldX, OldY], [X, Y])
  setNewPos(OldX, OldY, NewX, NewY, R, R).

% Sets the cell (OldX, OldY) to empty.
setOldPos(OldX, OldY, NewX, NewY, [Piece(NewX, NewY, T, C)|R], [Piece(OldX, OldY, blank, na)|R]).
setOldPos(OldX, OldY, NewX, NewY, [Piece(X, Y, T, C)|R], [Piece(X, Y, T, C)|R]) :-
  dif([OldX, OldY], [X, Y])
  setOldPos(OldX, OldY, NewX, NewY, R, R).

% Makes a move on Board from (OldX, OldY) to (NewX, NewY) and returns Board1
makeMove (OldX, OldY, NewX, NewY, Board, Board1) :-
  setNewPos(OldX, OldY, NewX, NewY, Board, NBoard),
  setOldPos(OldX, OldY, NewX, NewY, NBoard, Board1).
