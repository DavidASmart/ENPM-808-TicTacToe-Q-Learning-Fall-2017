%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function whos = whosTurn( Table, whoFirst )
% 1 = oponent's turn
% 0 = Q-learner's turn
% -1 = state not reachable

% count Xs and Os
num_Os = size(find(Table == 2),2);
num_Xs = size(find(Table == 1),2);

% based on the number you can determine who goes next 
if (whoFirst == 0) % O goes first
    if(num_Xs == num_Os) 
        whos = 1; % Os Turn
    elseif(num_Os - num_Xs == 1)
        whos = 0; % Xs Turn
    else
        whos = -1; % because certain states are not possible
    end
    
elseif (whoFirst == 1) % X goes first
    if(num_Xs == num_Os) 
        whos = 0; % Xs Turn
    elseif(num_Xs - num_Os == 1)
        whos = 1; % Os Turn
    else
        whos = -1; % because certain states are not possible
    end
end


end

