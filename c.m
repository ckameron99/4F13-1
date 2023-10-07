file_a = load("cw1a.mat");
file_e = load("cw1e.mat");

[x, sortIndex] = sort(file_a.x, "ascend")
y = file_a.y(sortIndex)
xs = linspace(-5, 5, 50)';

meanfunc = [];
covfunc = {'covPeriodic'}; p = 2; ell = .9; sf = 2; hyppe = log([ell;p;sf]);   % periodic
likfunc = @likGauss;

hyp = struct('mean', [], 'cov', hyppe, 'lik', 0);


hyp2 = minimize(hyp, @gp, -1000, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
disp(hyp2)
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
[yr yrs2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, x);

f = [mu+2*sqrt(s2); flip(mu-2*sqrt(s2),1)];

%fill([xs; flip(xs,1)], f, [7 7 7]/8)
%errorbar(xs, mu, 2*sqrt(s2))
hold on
%plot(xs, mu)
%plot(x, y, "x")
plot(x, y-yr)