function lab3_2()
    t0Arr = csvread("t.csv");
    y0Arr = csvread("y.csv");
    
    y1Arr = MNK(y0Arr, t0Arr);
    
    delta = calculateDelta(y0Arr, y1Arr);
    fprintf('Delta = %3.2f', delta);
    
    plot(t0Arr, y0Arr, '.b', t0Arr, y1Arr, 'r');
    legend({
        'Sample';
        'Model';
    });
end

function Y = MNK(yArray, tArray)
    psiMatrix = createPsiMatrix(tArray);
    
    thetaArray = (psiMatrix' * psiMatrix) \ (psiMatrix' * yArray'); 
    disp(thetaArray);
    
    n = length(yArray);
    Y = zeros(1, n);
    for i = 1:n
        Y(i) = thetaArray(1) + thetaArray(2)*tArray(i) + thetaArray(3)*tArray(i)*tArray(i);
    end
end

function Psi = createPsiMatrix(tArr)    
    n   = length(tArr);
    p   = 3;
    Psi = zeros(n, p);
    for i = 1:n
        Psi(i, 1) = 1;
        Psi(i, 2) = tArr(i);
        Psi(i, 3) = tArr(i)*tArr(i);
    end
end

function X = calculateDelta(yArray, yNewArray)
    n   = length(yArray);
    sum = 0;
    for i = 1:n
        sum = sum + power((yArray(i) - yNewArray(i)), 2);
    end
    X = sqrt(sum);
end