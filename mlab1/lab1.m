function lab1()
    clear all;
    X = csvread("datalab1.csv"); 
    
    X = sort(X);
    
    minX = X(1);
    fprintf('Mmin = %s\n', num2str(minX));

    maxX = X(end);
    fprintf('Mmax = %s\n', num2str(maxX));

    R = maxX - minX;
    fprintf('R = %s\n', num2str(R));

    mu = sExp(X);
    fprintf('mu = %s\n', num2str(mu));

    sSqr = unDeviation(X);
    fprintf('S^2: %s\n', num2str(sSqr));

    m = subintervals(length(X));
    fprintf('m = %s\n ', num2str(m));
    
    intervals(X, m);
    hold on;
    f(X, mu, sSqr, m);
    
    figure;
    empiricF(X);
    hold on;
    F(X, mu, sSqr, m);
        
end

function m = subintervals(size)
    m = floor(log2(size) + 2);
end

function mu = sExp(X)
    n   = length(X);
    sum = 0;

    for i = 1:n
        sum = sum + X(i);
    end
    
    mu = sum / n;
end

function sSqr = unDeviation(X)
    n   = length(X);
    mu  = sExp(X);
    sum = 0;

    for i = 1:n
        sum = sum + (X(i) - mu)^2;
    end
    
    sigmaSqr = sum / n;
    sSqr = n / (n - 1) * sigmaSqr;
end

function intervals(X, m)
    count = zeros(1, m+2);  
    delta = (X(end) - X(1)) / m;
    
    J = X(1):delta:X(end);
    J(length(J)+1) = 24; 
    j = 1;
    n = length(X);
   
    for i = 1:n      
        if (j ~= m)
            if ((not (X(i) >= J(j) && X(i) < J(j+1))))
                j = j + 1;
                fprintf('[%.2f;%.2f) (%.2f;)\t', J(j-1), J(j), count(j-1));
            end
        end
        count(j) = count(j) + 1;
    end
    fprintf('[%2.2f;%2.2f; %2.2f]\n', J(m), J(m + 1), count(m));
    
    Xbuf = count(1:m+2);
    for i = 1:m+2
        Xbuf(i) = count(i) / (n*delta);
    end
    
    L = [4,5,6,7,8,9,9.54];
    Y=[0,0,0,0,0,0,0];
    C = horzcat(L,J);
    D = horzcat(Y,Xbuf);
    stairs(C, D, 'blue'), grid;
end

function f(X, MX, DX, m)
    R = X(end) - X(1);
    delta = R/m;
    Sigma = sqrt(DX);
    
    Xn = 4: delta/50 :(MX + R);
    Xn(length(Xn)+1) = 24;
    Y = normpdf(Xn, MX, Sigma);
    
    plot(Xn, Y, 'red');
end

function F(X, MX, DX, m)
    R = X(end) - X(1);
    delta = R/m;
    
    Xn = (MX - R): delta :(MX+R);
    
    Xs = 4:delta:24;
    Y = normcdf(Xs, MX, sqrt(DX));
    
    plot(Xs, Y, 'r');
end

function empiricF(X)
    X = [4, X];
    [yy, xx] = ecdf(X);
    yy(2) = 0;
    yy(length(yy)+1) = 1;
    xx(length(xx)+1) = 24;
    stairs(xx, yy);
    
end