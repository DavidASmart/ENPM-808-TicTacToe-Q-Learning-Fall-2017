%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "MAIN_Qttt"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% clean up
clear
clc

%% Train Q-Learner through self play
m = 10000000; % no. of games to train on
Q1 = TRAINING1(m); % when robot goes 1st
close all
clc
Q2 = TRAINING2(m); % when robot goes 2nd
clc
% Q1 = load('Q1.mat');
% Q1 = Q1.Q;
% Q2 = load('Q2.mat');
% Q2 = Q2.Q;

%% Test Q-Learner through computer play
n = 10000; % number of test games = 10000
whoFirst = 0;
% initialize game outcomes
losses_C = 0;
wins_C = 0;
ties_C = 0;
% create action matricies
actionMatrix2 = getActionsforStates(0);
actionMatrix1 = getActionsforStates(1);
for t = 1:n
    if (mod(t,n/100) == 0)
        fprintf('t = %i\n',t)
    end
    whoWon = TESTING_COMPUTER(Q1,Q2,whoFirst,actionMatrix1,actionMatrix2);
    whoFirst = ~whoFirst;
    if (whoWon == 0)
        wins_C = wins_C + 1;
    elseif (whoWon == 2)
        ties_C = ties_C + 1;
    elseif (whoWon == 1)
        losses_C = losses_C + 1;
    end
end

%% Test Q-Learner through human play
n = 10; % number of test games
whoFirst = 0;
% initialize game outcomes
losses_H = 0;
wins_H = 0;
ties_H = 0;
% create action matricies
actionMatrix2 = getActionsforStates(0);
actionMatrix1 = getActionsforStates(1);
for t = 1:n
    clc
    fprintf('\nNEW GAME: %i\n',t)
    whoWon = TESTING_HUMAN(Q1,Q2,whoFirst,actionMatrix1,actionMatrix2);
    whoFirst = ~whoFirst;
    if (whoWon == 0)
        wins_H = wins_H + 1;
    elseif (whoWon == 2)
        ties_H = ties_H + 1;
    elseif (whoWon == 1)
        losses_H = losses_H + 1;
    end
end

%% Output Results
clc
fprintf('\n\nQ-learner Results (10,000xComputer):')
fprintf('\nWins = %i',wins_C)
fprintf('\nTies = %i',ties_C)
fprintf('\nLosses = %i',losses_C)
fprintf('\n\nQ-learner Results (10xHuman):')
fprintf('\nWins = %i',wins_H)
fprintf('\nTies = %i',ties_H)
fprintf('\nLosses = %i',losses_H)