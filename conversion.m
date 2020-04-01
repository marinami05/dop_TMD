function [state, conversion_vec] = conversion(T, curr_state, P)
    state = curr_state;
    conversion_vec = zeros(1,T);
    for i =1:T
        conversion_vec(i) = state;
        r = rand(1,1);
        cumul_p = 0;
        for j = 1:length(P(state,:))
            cumul_p = cumul_p + P(state,j);
            if r < cumul_p
                state = j;
                break;
            end
        end
    end
end

