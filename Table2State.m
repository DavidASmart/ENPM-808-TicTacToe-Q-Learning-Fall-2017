%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function stateIndex = Table2State( Table )
% find the state for the given table

% simple conversion
stateIndex = Table * [3^0;3^1;3^2;3^3;3^4;3^5;3^6;3^7;3^8] + 1;


end

