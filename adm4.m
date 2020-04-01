clc;
close all;
clear all;


messageToSend = 100000;
lambdas = 0.1:0.1:1;
b = 4;

resD = zeros(1, length(lambdas));
resN = zeros(1, length(lambdas));
resDTheor = zeros(1, length(lambdas));
resNTheor = zeros(1, length(lambdas));


for i = 1:length(lambdas)
    buf_queue = zeros(0,0);
    
    disp(lambdas(i));
    
    D = 0;
    window = 0;
    counter = 0;
    N = 0;
    
    while counter ~= messageToSend
        messageAppearInWindow = 0;
        time_in_window = exprnd(1 / lambdas(i));
        while time_in_window < 1
            messageAppearInWindow = messageAppearInWindow + 1;
            time_in_window = time_in_window + exprnd(1 / lambdas(i));
        end
        
        buf_queue = [buf_queue, zeros(1, min(messageAppearInWindow, ...
                                          b - length(buf_queue)))];
        
%         while messageInWindow ~= 0 && length(buf_queue) < b
%             buf_queue = [buf_queue, 0];
%         end
        
        if ~isempty(buf_queue) && buf_queue(1) ~= 0
            D = D + buf_queue(1);
            buf_queue(1) = [];
            counter = counter + 1;
        end
        
        N = N + length(buf_queue);
        window = window + 1;
        buf_queue = buf_queue + 1;        
    end
    
    resD(i) = D / counter;
    resN(i) = N / window;
    
    P = zeros(b+1, b+1);
%     j = 1:b;
    for j = 1:b
        P(1,j) = (lambdas(i) ^ (j-1)) / factorial(j-1) * exp(-lambdas(i));
    end
    P(1, b+1) = 1 - sum(P(1,:));
    for ii = 2:b
        k = 0;
        for j = 1:(b-1)
            if j >= (ii-1)
                P(ii,j) = (lambdas(i) ^ k) / factorial(k) * exp(-lambdas(i));
                k = k + 1;
            end
        end        
        P(ii,b) = 1 - sum(P(ii,:));
    end
    P(b+1,b) = 1;
    
    stat_d = stationaryDistribution(P);
    N = sum(stat_d' .* ((1:(b+1)) - 1));     
    lambdaOut = 1 - stat_d(1);
   
    resDTheor(i) = N / lambdaOut;
    resNTheor(i) = N;    
end


% plot 
figure;
hold on;
grid on;
xlabel('t');
ylabel('p');
disp(resD);
disp(resDTheor);
disp(resN);
disp(resNTheor);
plt1 = plot(lambdas, resD, '-b', 'LineWidth', 2); plt1_lable = 'D';
plt2 = plot(lambdas, resDTheor, '-r', 'LineWidth', 2); plt2_lable = 'D_{theor}';
plt3 = plot(lambdas, resN, '-g', 'LineWidth', 2); plt3_lable = 'N_2';
plt4 = plot(lambdas, resNTheor, '-yellow', 'LineWidth', 2); plt4_lable = 'N_{theor}';
legend([plt1;plt2;plt3; plt4], plt1_lable, plt2_lable, plt3_lable, plt4_lable)


