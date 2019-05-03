%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [actionIndex,positionOfAction] = epsilonGreedyAction( q, possibleActions, epsilon )
% Use the epsilon-greedy policy to choose an action to ensure sufficient exploration

% remove impossible actions (because some states are impossible)
trueActions = find(possibleActions ~= 0);

% initialize index of the "best" action
q_tempMax = -inf;

% find "best" action(s)
for i = 1:size(trueActions,2)
   
    % if there is a better action
    if(q_tempMax < q(trueActions(i)))
        % set new best
        q_tempMax = q(trueActions(i));
        bestActionLocation = trueActions(i);
        % reset ties
        tieCounter = 1; % Note: 1 = no tie
        tieIndex = bestActionLocation*ones(1,1);
    
    % if the best action ties
    elseif(q_tempMax == q(trueActions(i)))
        tieCounter = tieCounter + 1;
        tieIndex(tieCounter) = trueActions(i);
    end
end

% tie braker - random selection from amoung ties
if(tieCounter > 1)
    bestActionLocation = tieIndex(randperm(size(tieIndex,2),1));
end

% all the possible action indecies for exploration
myActions = possibleActions(trueActions);

e = rand(1,1);
if e > epsilon
    % exploitation
    actionIndex = possibleActions(bestActionLocation);
else
    % exploration - random selection from amoung possible moves
    actionIndex = myActions(randperm(size(myActions,2),1));
end

positionOfAction = find(possibleActions == actionIndex);

end

