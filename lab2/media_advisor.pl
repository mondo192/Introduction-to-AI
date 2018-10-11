% MEDIA ADVISOR: a demonstration of a rule-based expert sys
% swipl media_advisor.pl to run application in linux terminal

% ; -> OR
% , -> AND

% Rule: 1
stimulus_situation(verbal) :-
    envirnoment(papers); 
    envirnoment(manuals);
    envirnoment(documents);
    envirnoment(textbooks).

% Rule: 2
stimulus_situation(visual) :-
    envirnoment(pictures);
    envirnoment(illustrations);
    envirnoment(photographs);
    envirnoment(diagrams).

% Rule: 3
stimulus_situation('physical object') :-
    envirnoment(machines);
    envirnoment(buildings);
    envirnoment(tools).

% Rule: 4
stimulus_situation(symbolic) :-
    envirnoment(numbers);
    envirnoment(formulas);
    envirnoment('computer programs').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom: 1
stimulus_situation(musician) :-
	envirnoment(live);
	envirnoment(studio).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rule: 5
stimulus_response(oral) :-
    job(lecturing);
    job(advising);
    job(counselling).

% Rule: 6
stimulus_response('hands on') :-
    job(building);
    job(repairing);
    job(troubleshooting).

% Rule: 7
stimulus_response(documented) :-
    job(writting);
    job(typing);
    job(drawing).

% Rule: 8
stimulus_response(analytical) :-
    job(evaluating);
    job(reasoning);
    job(investigating).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom: 2
stimulus_response(entertainment) :-
	job(bassist);
	job(drummer);
	job(guitarist);
	job(singer).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rule: 9
medium(workshop) :-
    stimulus_situation('physical object'),
    stimulus_response('hands on'),
    feedback(yes).

% Rule: 10
medium('lecture tutorial') :-
    stimulus_situation(symbolic),
    stimulus_response(analytical),
    feedback(yes).

% Rule: 11
medium(videocassette) :-
    stimulus_situation(visual),
    stimulus_response(documented),
    feedback(no).

% Rule: 12
medium('lecture tutorial') :-
    stimulus_situation(visual),
    stimulus_response(oral),
    feedback(yes).

% Rule: 13
medium('lecture tutorial') :-
    stimulus_situation(verbal),
    stimulus_response(analytical),
    feedback(yes).

% Rule: 14
medium('role play exercises') :-
    stimulus_situation(verbal),
    stimulus_response(oral),
    feedback(yes).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom: 3
medium('concert') :-
	stimulus_situation(musician),
	stimulus_response(entertainment),
	feedback(yes).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom: 4
medium('computer science') :-
	stimulus_situation(symbolic),
	stimulus_response('hands-on'),
	feedback(yes).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
