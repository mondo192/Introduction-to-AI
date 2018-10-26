minList([X], X).
minList([X, Y|T], M) :-
	X =< Y,
	minList([X|T], M).

minList([X], X).
minList([X, Y|T], M) :-
	X > Y,
	minList([X|T], M).


% minList([2,4,1,6], M).