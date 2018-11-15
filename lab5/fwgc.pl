% Problem Solving & State Space Search
% Farmer Wolf & Goat Problem

opp(e,w).
opp(w,e).

unsafe(F,X,X,C) :- opp(F,X). 
unsafe(F,W,X,X) :- opp(F,X).

% Move the wolf
move(state(X,X,G,C), state(Y,Y,G,C)) :-
	opp(X,Y),
	not(unsafe(Y,Y,G,C)),
	writeList(['Farmer takes wolf', Y,Y,G,C]), nl.

% Move the goat
move(state(X,W,X,C), state(Y,W,Y,C)) :-
	opp(X,Y),
	not(unsafe(Y,W,Y,C)),
	writeList(['Farmer takes goat', Y,W,Y,C]), nl.

% Move the cabbage
move(state(X,W,G,X), state(Y,W,G,Y)) :-
	opp(X,Y),
	not(unsafe(Y,W,G,Y)),
	writeList(['Farmer takes cabbage', Y,W,G,Y]), nl.

% Move the Farmer
move(state(X,W,G,C), state(Y,W,G,C)) :-
	opp(X,Y),
	not(unsafe(Y,W,G,C)),
	writeList(['Farmer takes self', Y,W,G,C]), nl.

path(Goal, Goal, List) :-
	write('Solution path is: '),
	write(List).

path(State, Goal, List) :-
	move(State, NextState),
	not(member(NextState, List)),
	path(NextState, Goal, [NextState|List]), !.


writeList([]).
writeList([H|T]) :-
	write(H),
	write(' '),
	writeList(T).

append([], L, L).
append([X|T], L, [X|NL]) :-	
	append(T, L, NL).

go :-
	path(state(e,e,e,e), state(w,w,w,w), [state(e,e,e,e)]).