is_sick(ashley).

converse(ashley, john).
converse(ashley, nate).
converse(nate, sam).
converse(nate, matt).
converse(nate, adam).
converse(adam, nate).
converse(adam, wayne).
converse(wayne, charles).
converse(wayne, george).
converse(charles, sam).
converse(george, adam).
converse(george, sam).
converse(george, matt).
converse(eric, charles).

% Treat the problem as a graph with students as nodes and conversations as
% edges. Find a simple path from X to Y.

edge(X, Y) :-
    converse(X, Y);
    converse(Y, X).

walk(State, X, Y, Path) :-
    edge(X, Y),
    \+ member(Y, State),
    reverse([Y|State], Path).
walk(State, X, Y, Path) :-
    edge(X, Z),
    \+ member(Z, State),
    walk([Z|State], Z, Y, Path).

% X infects Y if there exists a simple path from some sick student to Y
% that includes X and exactly one sick student. (Additional sick students
% would logically truncate the path.)

not_sick(X) :-
    \+ is_sick(X).

infect(X, Y, Path) :-
    is_sick(Z),
    walk([Z], Z, Y, Path),
    member(X, Path),
    [_|T] = Path,
    maplist(not_sick, T).
