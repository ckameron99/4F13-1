file_e = load("cw1e.mat");

x = file_e.x
y = file_e.y


meanfunc = [];
covfunc = @covSEard; hyppe = [0 0 0];
%covfunc = {@covSum, {@covSEard, @covSEard}}; hyppe = 0.1*randn(6,1);
likfunc = @likGauss;

hyp = struct('mean', [], 'cov', hyppe, 'lik', 0);

hyp2 = minimize(hyp, @gp, -1000, @infGaussLik, meanfunc, covfunc, likfunc, x, y);

%mesh(reshape(x(:,1),11,11),reshape(x(:,2),11,11),reshape(y,11,11));
%hold on;
[yr yrs2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, x);

mesh(reshape(x(:,1),11,11),reshape(x(:,2),11,11),reshape(y-yr,11,11));