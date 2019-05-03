%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Table = State2Table( stateIndex )
% Find table for a given state

% initialize
Table = [0,0,0,0,0,0,0,0,0];
TablePowers = [3^0,3^1,3^2,3^3,3^4,3^5,3^6,3^7,3^8];
stateIndex = stateIndex - 1;

% not so simple conversion...

i = 9; % backwards counting index
while(i >= 1)
    if(stateIndex >= TablePowers(i))
        Table(i) = floor(stateIndex/TablePowers(i));
        stateIndex = mod(stateIndex,TablePowers(i));
        i = i - 1;
    else
        i = i - 1;
    end
end

end

