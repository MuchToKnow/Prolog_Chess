% Sets the cell (NewX, NewY) to the piece given by Type, Color.
setNewPos(NewX, NewY, [piece(NewX, NewY, _, _)|R], Type, Color, [piece(NewX, NewY, Type, Color)|R]).
setNewPos(NewX, NewY, [piece(X, Y, T, C)|I], Type, Color, [piece(X, Y, T, C)|J]) :- 
  dif((NewX, NewY), (X, Y)),
  setNewPos(NewX, NewY, I, Type, Color, J).

% Sets the cell (OldX, OldY) to empty.
setOldPos(OldX, OldY, [piece(OldX, OldY, _, _)|R], [piece(OldX, OldY, e, n)|R]).
setOldPos(OldX, OldY, [piece(X, Y, T, C)|I], [piece(X, Y, T, C)|J]) :-
  dif((OldX, OldY), (X, Y)),
  setOldPos(OldX, OldY, I, J).

% Gets the piece being moved.
getPiece(X, Y, [piece(X, Y, Type, Color)|R], Type, Color).
getPiece(X, Y, [piece(X1, Y1, _, _)|R], Type, Color) :-
  dif((X, Y), (X1, Y1)),
  getPiece(X, Y, R, Type, Color).

% Makes a move on Board from (OldX, OldY) to (NewX, NewY) and returns Board1
makeMove(OldX, OldY, NewX, NewY, Board, Board1) :-
  getPiece(OldX, OldY, Board, Type, Color),
  setNewPos(NewX, NewY, Board, Type, Color, NBoard),
  setOldPos(OldX, OldY, NBoard, Board1).

% makeMove(1,2,2,2,[piece(1,2,p,w), piece(2,2,e,n), piece(1,1,k,b)], NB).
