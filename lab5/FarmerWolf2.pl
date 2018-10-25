/* A Prolog production system solution to the farmer, wolf, goat and
   cabbage problem.

	a state is represented by the functor (structured object):

		state(F,W,G,C) where each argument may have a value
		of either "e" or "w".
	Start state: state(e,e,e,e)
	Goal state:  state(w,w,w,w)

*/

/* writes out a list */

writelst([]).
writelst([H|T]):-write(H), write(' '),writelst(T).

/* appends two lists together */

append([],L,L).
append([X|T],L,[X|NL]):- append(T,L,NL).

/* determines if an element is a member of a list */

member(X,[X|T]).
member(X,[H|T]):- member(X,T).

/* swaps from east to west */

opp(e,w).
opp(w,e).

/* determines if a state is unsafe */

unsafe(state(X, Y, Y, C)) :- opp(X,Y).
unsafe(state(X, W, Y, Y)) :- opp(X,Y).

/* knowledge-base of possible moves (production rules) */

move(state(X, X, G, C), state(Y, Y, G, C)):- 
		opp(X,Y), not (unsafe(state(Y,Y,G,C))),
		writelst(['try farmer takes wolf ',Y,Y,G,C]),nl. 

move(state(X, W, X, C), state(Y, W, Y, C)):- 
		opp(X,Y), not (unsafe(state(Y,W,Y,C))),
		writelst(['try farmer takes goat ',Y,W,Y,C]),nl. 

move(state(X, W, G, X), state(Y, W, G, Y)):- 
		opp(X,Y), not (unsafe(state(Y,W,G,Y))),
		writelst(['try farmer takes cabbage ',Y,W,G,Y]),nl. 

move(state(X, W, G, C), state(Y, W, G, C)):- 
		opp(X,Y), not (unsafe(state(Y,W,G,C))),
		writelst(['try farmer takes self ',Y,W,G,C]),nl. 

/* this clause succeeds if all other fail - used to indicate
when system needs to backtracks */

move(state(F, W, G, C), state(F, W, G, C)):- 
		writelst(['    BACKTRACK from: ',F,W,G,C]),nl,fail. 

/* terminating condition */
 
path(Goal, Goal, List):-
	write('Solution Path is: '),nl,
	write(List).

/* recursive definition of path (to explore state space) */

path(State, Goal, List):-
	move(State, NextState),

	not(member(NextState,List)),

	path(NextState,Goal,[NextState|List]),!.


/* predicate "go" to test program */

go:-  path(state(e,e,e,e), state(w,w,w,w),[state(e,e,e,e)]).
