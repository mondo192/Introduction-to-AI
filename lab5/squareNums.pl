makeSqrs([1,2,4,3,7], L).

makeSqrs([], []).
makeSqrs([N|R], [N1|R1]]) :-
	N1 is N * N,
	makeSqrs(R, R1). 


makeSqPairs([(1,1), (2,4), (4,16), (3,9), (7,49)]).

makeSqPairs([], []).
makeSqPairs([N|R], [(N,N1)|R1]) :-
	N1 is N * N,
	makeSqPairs(R, R1).


/* Uses a stack to calc */
sumList([], 0).
sumList([X|T], S) :-
	sumList(T, S1),
	S is X + S1.


/* Alternative approach using accumulator */
sumList2(L, N) :-
	sumList(L, 0, N). /* '0' is the accumulator 
	(auxilarry predicate) N stores the answer*/


sumList2([], N, N).
sumList2([X|T], A, N) :- /* 'A' for accumulator 'N' for answer */
	A2 is A + X,
	sumList2(T, A2, N).


/* Worked example of accumulator
sumList([1,6,5], N)
	sumList2([1,6,5], 0, N)
	sumList2([6,5], 1, N)
	sumList2([5], 7, N)
	sumList2([], 12, N)
	sumList2([], 12, 12) unify 12 with 12 as end condition
*/


/* List processing */
duplicate([], []).
duplicate([H|T], [H,H]|T2) :-
	duplicate(T, T2).