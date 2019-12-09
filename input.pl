getMove(OldX, OldY, NewX, NewY):-
	write("Your move: "),
	read(X),
	(
	  	X = 'exit',
	  	halt
	;
	name(X,[FromX,FromY,ToX,ToY]),
	convertLetter(FromX, OldX),
	convertLetter(ToX, NewX),
	convertNumber(FromY, OldY),
	convertNumber(ToY, NewY),!
	;
	  	write('Wrong format ( enter like <a1b2.> '),nl,
	  	fail
	).


convertLetter(FromL, To):-
	To is FromL-96.

convertNumber(FromN, To):-
	To is FromN-48.
