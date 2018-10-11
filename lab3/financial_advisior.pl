% FINANCIAL ADVISOR: help user decide to invest in savings account or stock market 
% swipl financial_advisior.pl to run 
% go. 
% [query].

% ; -> OR
% , -> AND
% Each Dependant > 5000
% Adequate > 15000 per year + 4000 per dependant

% Rule: 1
% Individuals with an inadequate savings account,
% should always make increasing the amount saved first their priority,
% regardless of their income.

investment(savings) :- savings_account(inadequate).

% Rule: 2
% Individuals with an adequate savings account and an adequate income,
% should consider investing in the stock market.

investment(stock) :- savings_account(adequate), income(adequate). 

% Rule: 3
% Individuals with a lower income who already have adequate savings
% should consider splitting their surplus income between savings and stocks
% to increase the cushion in savings whilest attempting to increase income through stocks.

investment(both) :- savings_account(adequate), income(inadequate).

% Rule 4:
% Determine when savings are adequate or inadequate using minsavings function.

savings_account(adequate) :- 
	amount_saved(X), dependants(Y), minsavings(Y, M), X >= M.

savings_account(inadequate) :-
	amount_saved(X), dependants(Y), minsavings(Y, M), X < M.

minsavings(Deps, Min) :- Min is 5000 * Deps


% Rule: 4
% 

income(adequate) :- 
	earnings(X, steady), dependants(Y), minincome(Y), X > Y).

income(inadequate) :-
	earnings(X, steady), dependants(Y), minincome(Y), X < Y).

income(inadequate) :-
	earnings(X, unsteady).

minincome(Y, Min) :- Min is 15000 + (4000 * Y).
greater(X, Y) :- X > Y.

% 3 inputs required: 1 environment 2 job, 3 feedback yes/no
go :-
    getEnvirnoment,
    getJob,
    feedback,
    (
        stimulus_situation(SS),
        nl, write('Stimulus situation is '), write(SS), nl,
        stimulus_response(SR),
        write('Stimulus response is '), write(SR), nl,
        medium(M),
        write('Medium is '), write(M)
        ;
        writeln('Could not advise on an appropriate medium')
    ),
    cleanInputs.

getEnvirnoment :-
    write('Input the envirnoment manuals.'), nl,
    read(E), 
    assert(envirnoment(E)).

getJob :-
    write('Input the job '), nl,
    read(J),
    assert(job(J)).

feedback :-
    write('Is feedback required yes/no '), nl,
    read(F),
    assert(feedback(F)).

cleanInputs :-
    retractall(envirnoment(_)),
    retractall(job(_)),
    retractall(feedback(_)).
