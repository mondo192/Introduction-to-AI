byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(singapore,auckland).
byPlane(losAngeles,auckland). 

travel(A, B) :-
	goDirect(A,B).

goDirect(A,B) :-
	byCar(A,B);
	byTrain(A,B);
	byPlane(A,B).

travel(A,B) :-
	goDirect(A,C),
	travel(C,B).

/* go is a functor data structure */
travel(A, B, go(A,B)) :- 
	goDirect(A,B).

travel(A,B, go(A,C,X)) :- 
	goDirect(A,C),
	travel(C,B,X).

travelRoute(A,B,[(A,R,car), (A,R,train), (A,R,plane)]) :-
	goDirect(A,C),
	travelRoute(C,B,R).

travelRoute(A,B,[A,B]) :-
	goDirect(A,B).

travelRoute(A,B,[A,R]) :-
	goDirect(A,C),
	travelRoute(C, B, R).