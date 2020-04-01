function [stat_d] = stationaryDistribution(P)
    P = P';
    for i=1:length(P)
        P(i,i) = P(i,i) - 1;
        P(length(P),i) = 1;
    end
    b = zeros(length(P),1);
    b(end) = 1;
%     stat_d = inv(P) * b;
    stat_d = P \ b;
end

