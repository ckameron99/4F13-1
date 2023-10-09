file_a = load("cw1a.mat");
file_e = load("cw1e.mat");

[x, sortIndex] = sort(file_a.x);
y = file_a.y(sortIndex);
xs = linspace(-4, 4, 600)';                  % 61 test inputs 

meanfunc = [];                    % empty: don't use a mean function
%covfunc = @covSEiso;              % Squared Exponental covariance function
likfunc = @likGauss;              % Gaussian likelihood
covfunc = @covPeriodic;

hyp = struct('mean', [], 'cov', [-1 0], 'lik', 0);

disp(hyp);

hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);

disp(hyp2);

[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);

disp(mu);
disp(s2);

%plot(xs, mu, "x")

f = [mu+2*sqrt(s2); flip(mu-2*sqrt(s2),1)];
fill([xs; flip(xs,1)], f, [7 7 7]/8)
%errorbar(xs, mu, s2);
hold on;
plot(x, y, "x");