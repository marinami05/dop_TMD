clc;
close all;
clear all;

N = 100000;

P = [0.65, 0.2, 0.15;
    0.2, 0.75, 0.05;
    0.0, 0.0, 1.0];

start = 1;

counter = 0;
for i=1:N
    currState = start;
    while currState ~= 3
        currState = conversion(1,currState, P);
        counter = counter + 1;
    end    
end

disp('sim');
disp(counter/N)

theor = [1 - P(1,1), -P(1,2);
        -P(2,1), 1 - P(2,2)];

% theorRes = inv(theor) * [1;1];
theorRes = theor \ [1;1];
disp('theor');
disp(theorRes)

