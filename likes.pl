% Author: Eamonn Keogh C16757629
% Date: 28/09/2018

man(jim).
man(mary).

% ':-' means implies
mortal(X) :- man(X).
% ',' means AND
likes(X, A) :- man(X), dog(A).

dog(rex).
dog(lassie).
cat(sooty).

hates(X, Y) :- dog(X), cat(Y).
chases(X, Y) :- dog(X), cat(Y).

a.
b.

c :- a;b.
person(jim, m, 23).

