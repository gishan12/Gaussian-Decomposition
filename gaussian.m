function gaussian() 
T = readtable('Gaussian_test.xlsx','ReadVariableNames',false);
A = table2array(T);
x = A(:,1);
y = A(:,2);
new= y * 1000;
new = abs(round(new));
final = [];

for i = 1: length(x) 
    list =x(i) *ones(1, new(i));
    final = cat(2, final, list);    
end
value = mod(length(final),100);
final(:, [length(final)-value+1:end]) = [];
list = [];
for i = 1: (length(final)/100)
    list = cat(1, final((i-1)*100+1:i*100), list);
end
size(list)
Data = list;

Model = fitgmdist(Data, 6,'CovarianceType', 'diagonal', 'SharedCovariance', true);
sigma = Model.Sigma;
mu = Model.mu;
weight = Model.ComponentProportion;
histogram(final, 'Normalization', 'pdf', 'EdgeColor', 'none');
hold on 
 
xlim = 2200:0.001:3800;
p = pdf('Normal', xlim, mu(1), sigma(1)^0.5);
q = pdf('Normal', xlim, mu(2), sigma(2)^0.5);
r = pdf('Normal', xlim, mu(3), sigma(3)^0.5);
s = pdf('Normal', xlim, mu(4), sigma(4)^0.5);
t = pdf('Normal', xlim, mu(5), sigma(5)^0.5);
%l = pdf('Normal', xlim, mu(6), sigma(6)^0.5);

plot(xlim, p*weight(1))
plot(xlim, q*weight(2))
plot(xlim, r*weight(3))
plot(xlim, s*weight(4))
plot(xlim, t*weight(5))
%plot(xlim, l*weight(6))
plot(xlim, p*weight(1)+q*weight(2)+r*weight(3)+s*weight(4)+t*weight(5))
end




