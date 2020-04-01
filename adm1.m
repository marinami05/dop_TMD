clc;
close all;
clear all;

T = 10;
N = 10000;

P = [0.6 0.4;
    0.2 0.8];

resP = zeros(2, T);
resP_teor = zeros(2, T);

start = 1;
start_vec = [1 0];
curr_state = start;

for i=1:N
    [curr_state, vec] = conversion(T, start, P);
    for j=1:T
        resP(vec(j),j) = resP(vec(j),j) + 1;
    end    
end

resP(1,:) = resP(1,:) / N;
resP(2,:) = resP(2,:) / N;

for i = 1:T
    tmp = start_vec * P ^ (i-1);
    resP_teor(1,i) = tmp(1);
    resP_teor(2,i) = tmp(2);
end
    
% plot 
figure;
hold on;
grid on;
xlabel('t');
ylabel('p');
plt1 = plot(1:T, resP(1,:), '-b', 'LineWidth', 2); plt1_lable = 'p_1';
plt2 = plot(1:T, resP_teor(1,:), '-r', 'LineWidth', 2); plt2_lable = 'p_1 theor';
plt3 = plot(1:T, resP(2,:), '-g', 'LineWidth', 2); plt3_lable = 'p_2';
plt4 = plot(1:T, resP_teor(2,:), '-yellow', 'LineWidth', 2); plt4_lable = 'p_2 theor';
legend([plt1;plt2;plt3; plt4], plt1_lable, plt2_lable, plt3_lable, plt4_lable)




