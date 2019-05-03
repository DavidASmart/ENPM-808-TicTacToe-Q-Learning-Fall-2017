%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [whoWon] = TESTING_COMPUTER(Q1,Q2,whoFirst,actionMatrix1,actionMatrix2)
% Tesing the Q-Learner though Play against "the Computer"
% X is the robot agent, O is the computer that choses action randomly
% (0 - vacant, 1 - X, 2 - O)
% Who won
% 0 -> Q-Learner Won
% 1 -> Random Computer Agent Won
% 2 -> Tie

%% Initialization
% initialize the table
Table = [0,0,0,0,0,0,0,0,0];
% initialize the state
stateIndex = Table2State(Table);
terminalState = 0;
    
%% Test Game
% untill the board is filled
while(terminalState == 0)
    
    if (whoFirst == 0)
    
        % get computers's move (random)
        stateIndex = Table2State(Table);
        stateIndex = randomMove(actionMatrix2(stateIndex,:));
        Table = State2Table(stateIndex);

        % check if the game is over
        [~,whoWon,terminalState] = getReward(stateIndex);

        % if the game is not over
        if (terminalState == 0)

            % get Q-Learner's move   
            [~,positionOfAction] = epsilonGreedyAction(Q2(stateIndex,:),actionMatrix2(stateIndex,:),0);
            % update table
            Table(positionOfAction) = 1;
            % update state in Q-table
            stateIndex = Table2State(Table);

            % check if game is over
            [~,whoWon,terminalState] = getReward(stateIndex);
        end
        
    elseif (whoFirst == 1)
        
        % get Q-Learner's move   
        [~,positionOfAction] = epsilonGreedyAction(Q1(stateIndex,:),actionMatrix1(stateIndex,:),0);
        % update table
        Table(positionOfAction) = 1;
        % update state in Q-table
        stateIndex = Table2State(Table);

        % check if game is over
        [~,whoWon,terminalState] = getReward(stateIndex);

        % if the game is not over
        if (terminalState == 0)
            % get computers's move (random)
            stateIndex = Table2State(Table);
            stateIndex = randomMove(actionMatrix1(stateIndex,:));
            Table = State2Table(stateIndex);

            % check if the game is over
            [~,whoWon,terminalState] = getReward(stateIndex);
        end
        
    end
end
    
end

