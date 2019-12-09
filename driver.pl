% Drives the chess game turn by turn once we implement the helper functions
:- [input].
:- [makeMove].
:- [output].
:- [validateMove].
other(b, w).
other(w, b).
chess(Board, Turn) :-
	printBoard(Turn, Board),
	getMove(OldX, OldY, NewX, NewY),
  validateMove(Turn, OldX, OldY, NewX, NewY, Board),
	makeMove(OldX, OldY, NewX, NewY, Board, Board1),
  write(Board1),
	other(Turn, NextTurn),
	chess(Board1, NextTurn).

% A board is just a list of pieces.
% ex. board = [piece(1,1,k,w), piece(1,2,e,na), piece(2,2,p,b)]
/*
 chess([piece(1,1,r,w),piece(2,1,kn,w),piece(3,1,b,w),piece(4,1,q,w),piece(5,1,k,w),piece(6,1,b,w),piece(7,1,kn,w),piece(8,1,r,w),
         piece(1,2,p,w),piece(2,2,p,w),piece(3,2,p,w),piece(4,2,p,w),piece(5,2,p,w),piece(6,2,p,w),piece(7,2,p,w),piece(8,2,p,w),
         piece(1,3,e,na),piece(2,3,e,na),piece(3,3,e,na),piece(4,3,e,na),piece(5,3,e,na),piece(6,3,e,na),piece(7,3,e,na),piece(8,3,e,na),
         piece(1,4,e,na),piece(2,4,e,na),piece(3,4,e,na),piece(4,4,e,na),piece(5,4,e,na),piece(6,4,e,na),piece(7,4,e,na),piece(8,4,e,na),
         piece(1,5,e,na),piece(2,5,e,na),piece(3,5,e,na),piece(4,5,e,na),piece(5,5,e,na),piece(6,5,e,na),piece(7,5,e,na),piece(8,5,e,na),
         piece(1,6,e,na),piece(2,6,e,na),piece(3,6,e,na),piece(4,6,e,na),piece(5,6,e,na),piece(6,6,e,na),piece(7,6,e,na),piece(8,6,e,na),
         piece(1,7,p,b),piece(2,7,p,b),piece(3,7,p,b),piece(4,7,p,b),piece(5,7,p,b),piece(6,7,p,b),piece(7,7,p,b),piece(8,7,p,b),
         piece(1,8,r,b),piece(2,8,kn,b),piece(3,8,b,b),piece(4,8,q,b),piece(5,8,k,b),piece(6,8,b,b),piece(7,8,kn,b),piece(8,8,r,b)], w).
        */
% piece(X, Y, Type, Color)
% Empty square:
% piece(X, Y, e, na)
