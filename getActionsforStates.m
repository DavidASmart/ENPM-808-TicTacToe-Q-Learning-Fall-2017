%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function actionMatrix = getActionsforStates(whoFirst)
% for each state we store the row of actions (next states)

% initialize
actionMatrix = zeros(3^9,9);% there are at most 9 actions possible.

% update
for stateIndex = 1:3^9
    
    % get state from state index
    Table = State2Table(stateIndex);
    whos = whosTurn(Table,whoFirst);
    
    % find all open spots
    emptyStates = find(Table == 0);
    
    % for all open spot
    for i = 1:size(emptyStates,2)
        
        %initialize table
        temp_table = Table;
        
        if(whos == 0)       % oponent's turn
            % possible moves
            temp_table(emptyStates(i)) = 1;
            actionMatrix(stateIndex,emptyStates(i)) = Table2State(temp_table);
        
        elseif(whos == 1)   % Q-learner's turn
            % possible moves
            temp_table(emptyStates(i)) = 2;
            actionMatrix(stateIndex,emptyStates(i)) = Table2State(temp_table);
        end
        
    end
    
end

end

