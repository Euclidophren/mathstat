clear all;

T = csvread('data_t.csv');
Y = csvread('data_y.csv');

Tsquare = T .* T;
Psi = horzcat(ones(length(T), 1), T', Tsquare');

theta = (Psi' * Psi) \ (Psi' * Y'); 

Ycap = theta(1) + theta(2) * T + theta(3) * Tsquare;

sum = 0;
for i = 1:length(Y)
    sum = sum + power((Y(i) - Ycap(i)), 2);
end
delta_1 = sqrt(sum);

plot(T, Y, '.b', T, Ycap, 'r');
legend({
    'Input data';
    'Output approximation';
});