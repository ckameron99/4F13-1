file_a = load("cw1a.mat");
file_e = load("cw1e.mat");

[x, sortIndex] = sort(file_a.x, "ascend")
y = file_a.y(sortIndex)
xs = linspace(-5, 5, 5000)';

meanfunc = [];
covfunc = @covSEiso;%covPERiso covPeriodic
likfunc = @likGauss;

hyp = struct('mean', [], 'cov', [10 0], 'lik', 0);


hyp2 = minimize(hyp, @gp, -1000, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
disp(hyp2)
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);

f = [mu+2*sqrt(s2); flip(mu-2*sqrt(s2),1)];

fill([xs; flip(xs,1)], f, [7 7 7]/8)
%errorbar(xs, mu, 2*sqrt(s2))
hold on
plot(xs, mu)
plot(x, y, "x")