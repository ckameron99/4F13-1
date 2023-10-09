file_a = load("cw1a.mat");

x = linspace(-5,5,200)';

meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0; 0];
covfunc = {@covProd, {@covPeriodic, @covSEiso}}; hyp.cov = [-0.5 0 0 2 0];
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);

n = length(x);
K = feval(covfunc{:}, hyp.cov, x);
K = K + 1e-6*eye(200);
mu = 0%feval(meanfunc{:}, hyp.mean, x);
y = chol(K)'*gpml_randn(0.15, n, 1) + mu + exp(hyp.lik)*gpml_randn(0.2, n, 1);
disp("here");
plot(x, y, '+');
disp("done");