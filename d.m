x = linspace(-5,5,200)';

meanfunc = [];
covfunc = {@covProd, {@covPeriodic, @covSEiso}};
likfunc = @likGauss;

hyp = struct('mean', [], 'cov', [-0.5 0 0 2 0], 'lik', 0);

[mu s2] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x);

disp(mu)