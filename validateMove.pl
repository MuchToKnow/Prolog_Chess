% PAWN

% First -- pawn logic is diff from the rest, it can only move diagonally if attacking, can only move vertically if not attacking
% Further - it can move two spaces for its first move (originating at row 2 for white, row 7 for black)
%         - it can only move towards the opposing side, so black and white pawn movements must be handled separately
%         - Note: en passante is not implemented
% None of the pawn validateMove logic uses "attacks"

% Pawn vertical movements:
% White pawn moves from 2 <= Y <= 7 by 1 space
validateMove(w, X, Y, X, NewY, Board) :-
    % There is a white pawn at XY
    getPiece(X, Y, Board, p, w),
    % Movement is row number + 1
    NewY == Y + 1,
    % Nothing is at X, Y+1, of either color, which would block this movement
    \+ getPiece(X, NewY, Board, _, _),
    % Simulate the move and ensure it doesn't expose the king (which would be illegal)
    makeMove(X, Y, X, NewY, Board, NewBoard),
    kingIsSafe(w, NewBoard).

% White pawn moves from row 2 by 2 spaces
validateMove(w, X, 2, X, 4, Board) :-
    % There is a white pawn at X2
    getPiece(X, 2, Board, p, w),
    % Ensure nothing is at X3 or X4 of either color, which would block this movement
    \+ getPiece(X, 3, Board, _, _),
    \+ getPiece(X, 4, Board, _, _),
    makeMove(X, 2, X, 4, Board, NewBoard),
    kingIsSafe(w, NewBoard).

% Black pawn moves from row 2 <= Y <= 7 by 1 space
validateMove(b, X, Y, X, NewY, Board) :-
    getPiece(X, Y, Board, p, b),
    NewY == Y - 1,
    \+ getPiece(X, NewY, Board, _, _),
    % Simulate the move and ensure it doesn't expose the king (which would be illegal)
    makeMove(X, Y, X, NewY, Board, NewBoard),
    kingIsSafe(b, NewBoard).

% Black pawn moves from row 7 by 2 spaces
validateMove(b, X, 7, X, 5, Board) :-
    % There is a black pawn at X7
    getPiece(X, 7, Board, p, b),
    % Ensure nothing is at X3 or X4 of either color, which would block this movement
    \+ getPiece(X, 6, Board, _, _),
    \+ getPiece(X, 5, Board, _, _),
    makeMove(X, 7, X, 5, Board, NewBoard),
    kingIsSafe(b, NewBoard).

% Pawn attacks:
% White pawn attacks into the left column
validateMove(w, X, Y, NewX, NewY, Board) :-
    % There is a white pawn at XY
    getPiece(X, Y, Board, p, w),
    NewX == X - 1, NewY == Y + 1,
    % There is a black piece at X+1, Y+1
    getPiece(NewX, NewY, Board, _, b),
    % Simulate the move and ensure it doesn't expose the king (which would be illegal)
    makeMove(X, Y, NewX, NewY, Board, NewBoard),
    kingIsSafe(w, NewBoard).

% White pawn attacks into the right column
validateMove(w, X, Y, NewX, NewY, Board) :-
    % There is a white pawn at XY
    getPiece(X, Y, Board, p, w),
    NewX == X + 1, NewY == Y + 1,
    % There is a black piece at X+1, Y+1
    getPiece(NewX, NewY, Board, _, b),
    % Simulate the move and ensure it doesn't expose the king (which would be illegal)
    makeMove(X, Y, NewX, NewY, Board, NewBoard),
    kingIsSafe(w, NewBoard).

% Black pawn attacks into the left column
validateMove(b, X, Y, NewX, NewY, Board) :-
    % There is a black pawn at XY
    getPiece(X, Y, Board, p, w),
    NewX == X - 1, NewY == Y - 1,
    % There is a white piece at X+1, Y+1
    getPiece(NewX, NewY, Board, _, b),
    % Simulate the move and ensure it doesn't expose the king (which would be illegal)
    makeMove(X, Y, NewX, NewY, Board, NewBoard),
    kingIsSafe(b, NewBoard).

% Black pawn attacks into the right column
validateMove(b, X, Y, NewX, NewY, Board) :-
    % There is a black pawn at XY
    getPiece(X, Y, Board, p, w),
    NewX == X + 1, NewY == Y - 1,
    % There is a white piece at X+1, Y+1
    getPiece(NewX, NewY, Board, _, b),
    % Simulate the move and ensure it doesn't expose the king (which would be illegal)
    makeMove(X, Y, NewX, NewY, Board, NewBoard),
    kingIsSafe(b, NewBoard).

% For all other units, validateMove uses attacks to check if the unit can move there
validateMove(Color, X, Y, NewX, NewY, Board) :-
    % Bounds checks
    X > 0, X < 9, Y > 0, Y < 9, NewX > 0, NewX < 9, NewY > 0, NewY < 9,
    % At least one of NewX and NewY should be different (i.e. not both same)
    \+ (X is NewX, Y is NewY),
    % There is a piece of the right color at XY
    getPiece(X, Y, Board, _, Color),
    % There is not a piece of the same color at NewX NewY (which would block it)
    \+ getPiece(NewX, NewY, Board, _, Color),
    % XY can attack NewX NewY
    attacks(X, Y, NewX, NewY, Board, Color),
    % Simulate the move and ensure it doesn't expose the king (which would be illegal)
    makeMove(X, Y, NewX, NewY, Board, NewBoard),
    kingIsSafe(Color, NewBoard).

% King safety:
% The Color (b or w) king (k) is safe on Board if nothing of the other color is attacking it
kingIsSafe(Color, Board) :-
    % The Color king is at KingX, KingY
    getPiece(KingX, KingY, Board, k, Color),
    % Nothing of other(Color) attacks his position
    \+ attacks(_, _, KingX, KingY, Board, other(Color)).

% Z is a number between X and Y
% Used for Rook
% X > Z > Y
between(Z, X, Y) :-
    X > Z,
    Z > Y.
% X < Z < Y
between(Z, X, Y) :-
    X < Z,
    Z < Y.

% KING
% 8 King attacks
% Horizontal
attacks(X, Y, NewX, Y, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewX == X + 1.

attacks(X, Y, NewX, Y, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewX == X - 1.

% Vertical
attacks(X, Y, X, NewY, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewY == Y + 1.

attacks(X, Y, X, NewY, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewY == Y - 1.

% Diagonal
attacks(X, Y, NewX, NewY, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewX == X + 1,
    NewY == Y + 1.
attacks(X, Y, NewX, NewY, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewX == X + 1,
    NewY == Y - 1.
attacks(X, Y, NewX, NewY, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewX == X - 1,
    NewY == Y + 1.
attacks(X, Y, NewX, NewY, Board, Color) :-
    % The king is at X,Y
    getPiece(X, Y, Board, k, Color),
    NewX == X - 1,
    NewY == Y - 1.

% KNIGHT
% 8 Knight attacks (X +- 2, Y +- 1) ; (X +- 1, Y +- 2)
% Attack 1: X+2, Y+1
attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    % There is a knight at AttackerX, AttackerY
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX + 2,
    DefenderY == AttackerY + 1.

attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX + 2,
    DefenderY == AttackerY - 1.

attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX - 2,
    DefenderY == AttackerY + 1.

attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX - 2,
    DefenderY == AttackerY - 1.

attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX + 1,
    DefenderY == AttackerY + 2.

attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX + 1,
    DefenderY == AttackerY - 2.

attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX - 1,
    DefenderY == AttackerY + 2.

attacks(AttackerX, AttackerY, DefenderX, DefenderY, Board, AttackerColor) :-
    getPiece(AttackerX, AttackerY, Board, n, AttackerColor),
    DefenderX == AttackerX - 1,
    DefenderY == AttackerY - 2.
% End of Knight

% Start of Rook

% Vertical attack
attacks(X, Y, X, NewY, Board, Color) :-
    % Board has a Color rook at XY
    getPiece(X, Y, Board, r, Color),
    % There are no pieces between them
    between(SomeY, Y, NewY),
    \+ getPiece(X, SomeY, Board, _, _).
    

% Horizontal attack
attacks(X, Y, NewX, Y, Board, Color) :-
    % Board has a Color rook at XY
    getPiece(X, Y, Board, r, Color),
    % There are no pieces between them
    between(SomeX, X, NewX),
    \+ getPiece(SomeX, Y, Board, _, _).