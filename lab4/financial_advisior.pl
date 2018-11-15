% Financial Advisor 

% Student Name:   Eamonn Keogh
% Student Number: C16757629
% Course: 		  DT228/3

% declare predicates and their arity 
% not necessary, but avoids warnings

:- dynamic invest_in/1.
:- dynamic savings_account/1.
:- dynamic amount_saved/1.
:- dynamic dependants/1.
:- dynamic minsavings/2.
:- dynamic earnings/2.

invest_in(savings) :- 
    savings_account(inadequate).

invest_in(stock) :-
    savings_account(adequate), 
    income(adequate).

invest_in('savings and stock') :- 
    savings_account(adequate),
    income(inadequate).

income(adequate) :-
    earnings(E, steady),
    dependants(Y),
    minincome(Y, Z),
    E > Z.

income(inadequate) :-
    earnings(E, steady),
    dependants(Y),
    minincome(Y, Z),
    E =< Z.

income(adequate) :-
    dependants(Y),
    Y == 0.

income(inadequate) :-
    earnings(E, unsteady).

%% income(A) :-
%%     earnings(X, steady),
%%     dependants(Y),
%%     minincome(Y, MI),
%%     (
%%         X > MI,
%%         A = adequate;
%%         X =< MI,
%%         A = inadequate
%%     ).

savings_account(adequate) :-
    amount_saved(X),
    dependants(Y),
    minsavings(Y, Z),
    X > Z.

savings_account(adequate) :-
    dependants(Y),
    Y == 0.

savings_account(inadequate) :-
    amount_saved(X),
    dependants(Y),
    minsavings(Y, MS),
    X < MS.
    
minincome(D, I) :-
    I is 15000 + (D * 4000).

minsavings(Y, MS) :-
    MS is Y * 5000.


go :-
    getAmountSaved,
    getDependants,
    getEarnings,
    getJob,
    (
        invest_in(I),
        nl, write('Invest in '), write(I),
        savings_account(SA),
        nl, write('Savings account is '), write(SA),
        income(A),
        nl, write('Current income is '), write(A)
        ;
        nl, writeln('Error! Failed to get a recommendation')
    ),
    cleanInputs.

getAmountSaved :-
    write('Input the amount saved.'), nl,
    read(A), 
    assert(amount_saved(A)).

getDependants :-
    write('How many dependants '), nl,
    read(D),
    assert(dependants(D)).

getEarnings :-
    write('Your earnings are '), nl,
    read(E),
    assert(earn(E)).

getJob :-
    write('Whats your job type (steady/unsteady) '), nl,
    read(J),
    earn(E),
    assert(earnings(E, J)).

cleanInputs :- 
    retractall(amount_saved(_)),
    retractall(dependents(_)),
    retractall(earn(_)),
    retractall(earnings(_)).
