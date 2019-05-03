%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Smart
% 11/3/2017
% University of Maryland, College Park
% Professional Masters of Robotics (MEng/PMRO)
% ENPM 808F - Robot Learning
% HW#4
% Use Q-Learning to teach the computer to play tic-tac-toe optimaly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = ttt_board(Table)
%Converts Table from an Array of numbers to a Matrix of X's and O's
%   (0 - vacant, 1 - X, 2 - O)

    % array of numbers to matrix of numbers
    Table2 = [0,0,0;0,0,0;0,0,0];
    Table2(1,:) = Table(1:3);
    Table2(2,:) = Table(4:6);
    Table2(3,:) = Table(7:9);

    % matrix of numbers to matrix of characters
    Table3 = ['1','2','3';'4','5','6';'7','8','9'];
    for i = 1:3
        for j = 1:3
            if (Table2(i,j) == 1)
                Table3(i,j) = 'X';
            elseif (Table2(i,j) == 2)
                Table3(i,j) = 'O';
            end
        end
    end
    
    disp(Table3)
    
end

