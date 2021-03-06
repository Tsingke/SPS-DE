function geninitialx_cec14
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE
rng('default');
lb = -100;
ub = 100;
D = [10, 20, 30, 50, 100];
for i = 1 : numel(D)
	Di = D(i);
	NP = 5 * Di;
	X = ...
		repmat(lb, Di, NP) + ...
		repmat(ub - lb, Di, NP) .* lhsdesign(NP, Di, 'iteration', 100)'; %#ok<*NASGU>
	Xname = sprintf('XD%dNP%d', Di, NP);
	eval(sprintf('%s = X;', Xname));
	
	if i == 1
		save('InitialX.mat', Xname);
	else
		save('InitialX.mat', Xname, '-append');
	end
end
end