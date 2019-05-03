%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function stateIndex = randomMove( possibleActions )
% stateIndex -> state index after the random move

% remove impossible actions (because some states are not acheivable)
trueActions = find(possibleActions ~= 0);
% choose random action from those available
chooseAction = randperm(size(trueActions,2));
% take action
stateIndex = possibleActions(trueActions(chooseAction(1)));
end

