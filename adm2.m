clc;
close all;
clear all;

T = 1000000;

P = [0.65, 0.2, 0.15;
    0.2, 0.75, 0.05;
    0.3, 0.6, 0.1];

start = 1;
start_vec = [1 0 0];

[curr_state, vec] = conversion(T, start, P);

stat_distrb = zeros(1,3);

stat_distrb(1) = sum(vec(:) == 1);
stat_distrb(2) = sum(vec(:) == 2);
stat_distrb(3) = sum(vec(:) == 3);

stat_distrb(:) = stat_distrb(:) / T;

disp('sim')
disp(stat_distrb)


theor_matr = start_vec * P ^ 1000;
disp('theor_matr')
disp(theor_matr(1,:))

stat_d = stationaryDistribution(P);
disp('lin_uravn')
disp(stat_d)
