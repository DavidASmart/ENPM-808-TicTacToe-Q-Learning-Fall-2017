%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [reward,whoWon,isTerminal] = getReward( stateIndex )
% Here we determine if the stateIndex is a terminal state or not
% reward 
%   win -> +1
%   lose -> -1
%   tie -> 0
%   non terminal -> 0
% whoWon
%   0 -> Robot Won
%   1 -> User Won
%   2 -> Draw
%   3 -> Game in Progress

%initialize
isTerminal = 0;

% get state
table = State2Table(stateIndex);

% if Q-learner wins
if((table(1) == 1 && table(5) ==1 && table(9) == 1) || ...
   (table(3) == 1 && table(5) == 1 && table(7) == 1) || ...
   (table(1) == 1 && table(2) == 1 && table(3) == 1) || ...
   (table(4) == 1 && table(5) == 1 && table(6) == 1) || ...
   (table(7) == 1 && table(8) == 1 && table(9) == 1) || ...
   (table(1) == 1 && table(4) == 1 && table(7) == 1) || ...
   (table(2) == 1 && table(5) == 1 && table(8) == 1) || ...
   (table(3) == 1 && table(6) == 1 && table(9) == 1))
	reward = 1;
	whoWon = 0;
	isTerminal = 1;
    
% if Q-learner loses    
elseif((table(1) == 2 && table(5) ==2 && table(9) == 2) || ...
       (table(3) == 2 && table(5) == 2 && table(7) == 2) || ...
       (table(1) == 2 && table(2) == 2 && table(3) == 2) || ...
       (table(4) == 2 && table(5) == 2 && table(6) == 2) || ...
       (table(7) == 2 && table(8) == 2 && table(9) == 2) || ...
       (table(1) == 2 && table(4) == 2 && table(7) == 2) || ...
       (table(2) == 2 && table(5) == 2 && table(8) == 2) || ...
       (table(3) == 2 && table(6) == 2 && table(9) == 2))
    reward = -1;
    whoWon = 1;
    isTerminal = 1;
    
% if the match is tie i.e no empty places left
elseif(size(find(table == 0),2) == 0)
    reward = 0;
    whoWon = 2;
    isTerminal = 1;
    
% non terminal state
else
    reward = 0;
    whoWon = 3;
end

end

