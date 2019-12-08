% Sets the cell (NewX, NewY) to the piece at (OldX, OldY).
setNewPos(OldX, OldY, NewX, NewY, [piece(OldX, OldY, T, C)|R], [piece(NewX, NewY, T, C)|R]).
setNewPos(OldX, OldY, NewX, NewY, [piece(X, Y, T, C)|R], [piece(X1, Y1, T, C)|R]) :-
  dif((OldX, OldY), (X, Y)),
  setNewPos(OldX, OldY, NewX, NewY, R, R).

% Sets the cell (OldX, OldY) to empty.
setOldPos(OldX, OldY, NewX, NewY, [piece(NewX, NewY, _, _)|R], [piece(OldX, OldY, e, n)|R]).
setOldPos(OldX, OldY, NewX, NewY, [piece(X, Y, T, C)|R], [piece(X, Y, T, C)|R]) :-
  dif((OldX, OldY), (X, Y)),
  setOldPos(OldX, OldY, NewX, NewY, R, R).

% Makes a move on Board from (OldX, OldY) to (NewX, NewY) and returns Board1
makeMove(OldX, OldY, NewX, NewY, Board, Board1) :-
  setNewPos(OldX, OldY, NewX, NewY, Board, NBoard),
  setOldPos(OldX, OldY, NewX, NewY, NBoard, Board1).

% makeMove(1,2,2,2,[piece(1,2,p,w), piece(2,2,e,n), piece(1,1,k,b)], NB).
