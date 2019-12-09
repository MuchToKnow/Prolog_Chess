% A board is just a list of pieces.
% ex. board = [piece(1,1,k,w), piece(1,2,e,na), piece(2,2,p,b)]
% Empty square:
% piece(X, Y, e, na)

printBoard('white', Board1):-
  empty_reverse_board(Board),
  replaceBoardDiagonal(Board, Board1, Board2),
  write('Enter moves like <a2d4.>. Enter <exit.> to quit'),nl,
	write('It is WHITE turn: '),nl,
  print(Board2).

printBoard('black', Board1):-
  empty_board(Board),
  replaceBoard(Board, Board1, Board2),
  write('Enter moves like <a2d4.>. Enter <exit.> to quit'),nl,
	write('It is BLACK turn: '),nl,
  print(Board2).

% actually print the board by each rows
print([R1,R2,R3,R4,R5,R6,R7,R8]):-
  write("8"),write(R8),nl,
	write("7"),write(R7),nl,
	write("6"),write(R6),nl,
	write("5"),write(R5),nl,
	write("4"),write(R4),nl,
	write("3"),write(R3),nl,
	write("2"),write(R2),nl,
	write("1"),write(R1),nl,
	write("  a b c d e f g h"),nl,nl.

% replaceBoard(Board, Board1, Board2)
% from Board to Board2 from information in Board1
% Board is [R1, R2, R3 .. R8], while R1=R2=R3.. R8 = [emptyCell, emptyCell, .., emptyCell]
% Board1 is List of Pieces, with [Piece1, Piece2], while piece(X,Y,A,B), X=x position, Y=y position, A=type, B=black
% x-position => (8-x)th row, y-position => (y-1)th element in the list, replace the emptycell to A type
% Board2 is [R1', R2', R'.. R8'], while R1 = ['\..', '\..', '\..', ..., '\...']

replaceBoard(B1, [H], B2):- replacePiece(B1, H, B2).
replaceBoard(B1, [H|Pieces], B3):-
  replacePiece(B2,H,B3),replaceBoard(B1,Pieces,B2).


replaceBoardDiagonal(B1, [H], B2):- replacePieceDiagonal(B1, H, B2).
replaceBoardDiagonal(B1, [H|Pieces], B3):-
  replacePieceDiagonal(B2,H,B3),replaceBoardDiagonal(B1,Pieces,B2).
% replacePiece(Board, Piece, Board2)
% x-position => (8-x)th row, y-position => (y-1)th element in the list, replace the emptycell to A type
% x-position starts from 1th row
replacePiece(B,piece(_, _, 'e', 'na'),B).
replacePiece(B1,piece(Y, X, T, C),B2):-
  X1 is X-1, Y1 is Y-1,
  X1 >= 0, Y1 >= 0, X1 < 9, Y1 < 9,
  chessType(T,C,Z),
  replace(B1,X1, Y1, Z, B2).

replacePieceDiagonal(B,piece(_, _, 'e', 'na'),B).
replacePieceDiagonal(B1,piece(Y, X, T, C),B2):-
  X1 is 8-X, Y1 is 8-Y,
  X1 >= 0, Y1 >= 0, X1 < 9, Y1 < 9,
  chessType(T,C,Z),
  replace(B1,X1, Y1, Z, B2).

% find the row
replace( [L|Ls] , 0 , Y , Z , [R|Ls] ) :-
  replace_column(L,Y,Z,R).

% haven't found the row yet
replace( [L|Ls] , X , Y , Z , [L|Rs] ) :-
  X > 0 ,
  X1 is X-1 ,
  replace( Ls , X1 , Y , Z , Rs ).

% find the specified offset
replace_column( [_|Cs] , 0 , Z , [Z|Cs] ) .
replace_column( [C|Cs] , Y , Z , [C|Rs] ) :-
  Y > 0 ,
  Y1 is Y-1 ,
  replace_column( Cs , Y1 , Z , Rs ).

chessType('p','w','\u265F').
chessType('r','w','\u265C').
chessType('k','w','\u265E').
chessType('b','w','\u265D').
chessType('q','w','\u265B').
chessType('k','w','\u265A').
chessType('p','b','\u2659').
chessType('r','b','\u2656').
chessType('k','b','\u2658').
chessType('b','b','\u2657').
chessType('q','b','\u2655').
chessType('k','b','\u2654').

empty_board([['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665'],
								['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665'],
								['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665'],
								['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665'],
								['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661'],
								['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661'],
								['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661'],
								['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661']
                ]).

empty_reverse_board([
                  ['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661'],
                	['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661'],
                	['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661'],
                	['\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661','\u2661'],
                  ['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665'],
                  ['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665'],
                  ['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665'],
                  ['\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665','\u2665']
              ]).
