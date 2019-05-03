%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Q2 = TRAINING2(m)
% Q-Learner learns the optimal action value function Q(s,a)
%   X is the Q-Learner, O is the oposing player
%   s - states - Total number of possible states = 3^9 (0 - vacant, 1 - X, 2 - O)
%   a - action - Add a X to one of the empty states to reach another state
%   r - 1 for robot wins
%       -1 for robot loses
%       0 for tie or non-terminal state
%   y - discounting factor
%   a - learning rate = 1/aCounter
%       where aCounter is the no. of times the (a,s) pair has been seen
%  epsilon - greediness coefficient - how often the Q-learner will explore rather than exploit 
%   Q(s,a) - a matrix of size 3^9 x 9
%   actionMatrix - matrix of possible next state index for a given state

%% Initialization
y = 1; % full 'discounting' needed, final state is what matters
e_i = 1; % initial epsilon
e_f = 0.01; % final epsilon

Table = [0,0,0,0,0,0,0,0,0]; % tic tac toe as array
aCounter = ones(3^9,9); % no (s,a) pair has been seen yet
Q2 = zeros(3^9,9); % start with equal-random policy
actionMatrix = getActionsforStates(0);

% initialize game outcomes
Wins = zeros(1,m);
Losses = zeros(1,m);
Ties = zeros(1,m);
Wins_rate = zeros(1,m);
Losses_rate = zeros(1,m);
Ties_rate = zeros(1,m);


N = zeros(1,m);
Q2_sum = zeros(1,m);
Q2_sum_rate = zeros(1,m);


%% Training Loop
for n = 1:m % play 100,000 games
    
    N(n) = n;
    if (mod(n,m/100) == 0)
        fprintf('Games Played: %d\n',n);
    end
    
    % Initialize State
    stateIndex = Table2State(Table);
    terminalState = 0;
    
    % Q_sum before game
    Q2_sum(n) = sum(sum(Q2));
    
    % first opponent Q-learner move is random
    stateIndex = randomMove(actionMatrix(stateIndex,:));
    
    % epsilon for this game
    epsilon = e_i + (e_f - e_i)*(n/m);
       
    % untill the game ends
    while (terminalState == 0)
               
        % if that move did not win the game, then the Q-learner gets a turn
        if(terminalState == 0) 
            % Q-Learner move
            [nextStateIndex,chosenAction] = epsilonGreedyAction(Q2(stateIndex,:),actionMatrix(stateIndex,:),epsilon);
           
            % update the learning rate for this (s,a) pair
            aCounter(stateIndex,chosenAction) = aCounter(stateIndex,chosenAction)+ 1;
            a = 1 / aCounter(stateIndex,chosenAction);
            
            % possible actions for the next state
            possibleActions = find(actionMatrix(nextStateIndex,:) ~= 0);
            % find reward for the new state (thus the move made)
            [reward,whoWon,terminalState] = getReward(nextStateIndex);
            
            % learned sum
            if(terminalState == 0)
                learned = (reward + y*min(Q2(nextStateIndex,possibleActions)));
            else
                learned = reward;
            end
            % inertial sum
            inertia = Q2(stateIndex,chosenAction);
            % update Q-value
            Q2(stateIndex,chosenAction) = (1-a)*inertia + a*learned ;
            
            % update state
            stateIndex = nextStateIndex;
        end
        
        % if that move did not win the game, then the opponent gets a turn
        if (terminalState == 0)
            % opponent Q-Learner move (its self play)
            [nextStateIndex,chosenAction] = epsilonGreedyAction(Q2(stateIndex,:),actionMatrix(stateIndex,:),epsilon);

            % update the learning rate for this (s,a) pair
            aCounter(stateIndex,chosenAction) = aCounter(stateIndex,chosenAction)+ 1;
            a = 1 / aCounter(stateIndex,chosenAction);

            % possible actions for the next state
            possibleActions = find(actionMatrix(nextStateIndex,:) ~= 0);
            % find reward for the next state (thus the move made)
            [reward,whoWon,terminalState] = getReward(nextStateIndex);

            % learned sum
            if(terminalState == 0)
                learned = (reward + y*max(Q2(nextStateIndex,possibleActions)));
            else
                learned = reward;
            end
            % inertial sum
            inertia = Q2(stateIndex,chosenAction);
            % update Q-value
            Q2(stateIndex,chosenAction) = (1-a)*inertia + a*learned;

            % update state
            stateIndex = nextStateIndex;
        end
    end
    
    % evaluate result of game
    if n > 1
        if(whoWon == 0)
            Wins(n) = Wins(n-1) + 1;
            Losses(n) = Losses(n-1);
            Ties(n) = Ties(n-1);
        elseif(whoWon == 1)
            Wins(n) = Wins(n-1);
            Losses(n) = Losses(n-1) + 1;
            Ties(n) = Ties(n-1);
        elseif(whoWon == 2)
            Wins(n) = Wins(n-1);
            Losses(n) = Losses(n-1);
            Ties(n) = Ties(n-1) + 1;
        end

        if (mod(n,1000) == 1)
            Wins_rate(n) = Wins(n)-Wins(n-1000);
            Losses_rate(n) = Losses(n)-Losses(n-1000);
            Ties_rate(n) = Ties(n)-Ties(n-1000);
            Q2_sum_rate(n) = Q2_sum(n)-Q2_sum(n-1000);
        else
            Wins_rate(n) = Wins_rate(n-1);
            Losses_rate(n) = Losses_rate(n-1);
            Ties_rate(n) = Ties_rate(n-1);
            Q2_sum_rate(n) = Q2_sum_rate(n-1);
        end
    end
    
end


fprintf('Wins: %d \nLosses: %d \nTies: %d \n',Wins(n),Losses(n),Ties(n));

figure(1);
plot(N,abs(Q2_sum),'color', [0.5 0 1],'LineWidth',2)
title('Q2-Learning')
xlabel('Games')
ylabel('Abs Sum Q')
saveas(gcf,'Q2_sum.jpg')

figure(2)
plot(N, Wins,'g','LineWidth',2);
hold on
plot(N, Losses,'r','LineWidth',2);
plot(N, Ties,'b','LineWidth',2);
hold off
title('Q2-Learning')
xlabel('Games')
ylabel('No.')
legend('Wins','Loses','Ties')
saveas(gcf,'Q2_WLT.jpg')

figure(3);
plot(N,abs(Q2_sum_rate),'color', [0.5 0 1],'LineWidth',2)
title('Q2-Learning Rate')
xlabel('Games')
ylabel('Avg Sum Q Diffrence')
saveas(gcf,'Q2_sum_rate.jpg')

figure(4)
plot(N, Wins_rate,'g','LineWidth',2);
hold on
plot(N, Losses_rate,'r','LineWidth',2);
plot(N, Ties_rate,'b','LineWidth',2);
hold off
title('Q2-Learning Rate')
xlabel('Games')
ylabel('Avg. Rate')
legend('Wins','Loses','Ties')
saveas(gcf,'Q2_WLT_rate.jpg')


save('Q2.mat','Q2');
end

