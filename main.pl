% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).

% Top-level predicate
alive(Row, Column, BoardFileName) :-
    % Get input as a board in a .txt file
    see(BoardFileName),
    read(Board),
    seen,
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w),

    check_alive(Row, Column, Board, Stone, 1).

check_alive(Row, Column, Board, Color, Direction) :-
    % Check what stone the given position has
    nth1_2d(Row, Column, Board, Stone),

    %If no stone, return true
    (Stone = e; 
    (Stone = Color,
        Up is Row - 1,
        Down is Row + 1,
        Left is Column - 1,
        Right is Column + 1,
        (
        (Direction mod 3 =\= 0 -> (write(Direction), X is Direction*2, write(X), check_alive(Up, Column, Board, Color, X)); fail);
        (Direction mod 2 =\= 0 -> (write(Direction), X is Direction*3, write(X),check_alive(Down, Column, Board, Color,X));fail);
        (Direction mod 7 =\= 0 -> (write(Direction), X is Direction*5, write(X),check_alive(Row, Left, Board, Color, X)); fail);
        (Direction mod 5 =\= 0 -> (write(Direction), X is Direction*7, write(X),check_alive(Row, Right, Board, Color,X)); fail)
        )
    )).