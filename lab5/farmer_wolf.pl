% Farmer Wolf and Goat Problem using Prolog
% Execute as go(state(w,w,w,w), state(e,e,e,e)).

go(Start, Goal) :-
	empty_stack(Empty),
	stack(Start, Empty, Stack),
	path(Start, Goal, Stack).

path(Goal, Goal, Stack) :-
	write('Solution path is: '), nl,
	reverse_print_stack(Stack).

path(State, Goal, Stack) :-
	move(State, Next),
	not(member_stack(Next, Stack)),
	stack(Next, Stack, New_Stack),
	path(Next, Goal, New_Stack),
	!.

move(state(X,X,G,C), state(Y,Y,G,C)) :-
	opp(X,Y),
	not(unsafe(state(Y,Y,G,C))),
	writelist(['try farmer takes wolf', Y,Y,G,C]).

move(state(X,W,X,C), state(Y,W,Y,C)) :-
	opp(X,Y),
	not(unsafe(state(Y,W,Y,C))),
	writelist(['try farmer takes goat', Y,W,Y,C]).

move(state(X,W,G,X), state(Y,W,G,Y)) :-
	opp(X,Y),
	not(unsafe(Y,W,G,Y))),
	writelist(['try farmer takes cabbage', Y,W,G,Y]).

move(state(X,W,G,C), state(Y,W,G,C)) :-
	opp(X,Y),
	not(unsafe(state(Y,W,G,C))),
	writelist(['try farmer takes self', Y,W,G,C]).

move(state(F,W,G,C), state(F,W,G,C)) :-
	writelist(['BACKTRACK from: ', F,W,G,C]),
	fail.

unsafe(state(X,Y,Y,C)) :- 
	opp(X,Y).

unsafe(state(X,W,Y,Y)) :-
	opp(X,Y).

writelist([]) :-
	nl.

writelist([H|T]) :-
	print(H), 
	tab(1),
	writelist(T).

opp(e,w).
opp(w,e).

reverse_print_stack(S) :-
	empty_stack(S).

reverse_print_stack(S) :-
	stack(E, Rest, S),
	reverse_print_stack(Rest),
	write(E), nl.
