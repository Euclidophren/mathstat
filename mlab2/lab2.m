function lab2()
    clear all;

    X = csvread("data.csv");
    
    N = 10:120;
    
    gamma = 0.9;
    alpha = (1 - gamma) / 2;

    mu = mean(X);
    sSqr = var(X); 

    muArray = expArray(X, N);
    varArray = devArray(X, N);
    
 
    figure
    plot([N(1), N(end)], [mu, mu], 'm');
    hold on;
    plot(N, muArray, 'g');
    Ml = muArray - sqrt(varArray./N).*tinv(1 - alpha, N - 1);
    plot(N, Ml, 'b');
    
    Mh = muArray + sqrt(varArray./N).*tinv(1 - alpha, N - 1);
    plot(N, Mh, 'r');
    grid on;
    hold off;

    fprintf('mu = %.2f\n', mu); 
    fprintf('S^2 = %.2f\n\n', sSqr);
    fprintf('mu_low = %.2f\n', Ml(end));
    fprintf('mu_high = %.2f\n', Mh(end));

    
    figure
    plot([N(1), N(end)], [sSqr, sSqr], 'm');
    hold on;
    plot(N, varArray, 'g');
    
    Sl = varArray.*(N - 1)./chi2inv(1 - alpha, N - 1);
    plot(N, Sl, 'b');
    
    Sh = varArray.*(N - 1)./chi2inv(alpha, N - 1);
    plot(N, Sh, 'r');
    grid on;
    hold off;
    fprintf('sigma^2_low = %.2f\n', Sl(end));
    fprintf('sigma^2_high = %.2f\n', Sh(end));
end

function muArray = expArray(X, N)
    muArray = [];
    for i = N
        muArray = [muArray, mean(X(1:i))];
    end
end

function varArray = devArray(X, N)
    varArray = [];
    for i = N
        varArray = [varArray, var(X(1:i))];
    end
end
