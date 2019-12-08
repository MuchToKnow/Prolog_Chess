getMove(OldX, OldY, NewX, NewY):-
	write("Your move: "),
	read(X),
	name(X,[FromX,FromY,ToX,ToY]),
	convertLetter(FromX, OldX),
	convertLetter(ToX, NewX),
	convertNumber(FromY, OldY),
	convertNumber(ToY, NewY).


convertLetter(FromL, To):-
	To is FromL-96.

convertNumber(FromN, To):-
	To is FromN-48.
