:- consult(read_line).

%%% Command Grammar %%%

command(C) -->
    swap_(C) | locate_(C) | print_(C).

swap_(swap(X, Y)) -->
    [switch], [X], [with], [Y], [.].

locate_(locate(X)) -->
    [where], [is], [X], [in], [line], [?].

print_(print) -->
    [what], [is], [the], [current], [order], [of], [the], [line], [?].

%%% Commands %%%

swap(X, Y, [A, B|T], [B, A|T]) :-
    (X = A, Y = B;
     X = B, Y = A),
    write('Done!'), nl, !.
swap(X, Y, [H|T1], [H|T2]) :-
    swap(X, Y, T1, T2).

locate(X, State, Line) :-
    State = Line,
    nth1(I, Line, X), % one-indexed
    write(I), nl, !.

print(State, Line) :-
    State = Line,
    write(Line), nl, !.

%%% Main %%%

repl(State) :-
    repeat,
    read_line(In),
    command(C, In, []),
    call(C, State, Line),
    repl(Line). % This *should* be tail recursive
repl :-
    repl([a, b, c, d, e, f]).
