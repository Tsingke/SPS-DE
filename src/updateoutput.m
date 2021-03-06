function out = updateoutput(out, X, f, counteval, countiter, varargin)
%UPDATEOUTPUT Update output info
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE

if isempty(out.recordFEs)
	return;
end

if counteval >= out.recordFEs(out.iRecordFEs)
	[fmin, fminidx] = min(f);
	xmin = X(:, fminidx);
	C = cov(X');
	[B, ~] = eig(C);
	condX = cond(C);
	angle = acos(B(1));
	if angle >= 0.5 * pi
		angle = angle - 0.5 * pi;
	end
	while counteval >= out.recordFEs(out.iRecordFEs)
		i = out.iRecordFEs;
		out.fmin(i) = fmin;
		out.fmean(i) = mean(f);
		out.fstd(i) = std(f);
		out.xmin(:, i) = xmin;
		out.xmean(:, i) = mean(X, 2);
		out.xstd(:, i) = std(X, 0, 2);
		out.fes(i) = counteval;
		out.distancemean(i) = mean(centroiddistance(X));
		out.cond(i) = condX;
		out.angle(i) = angle;
		out.G(i) = countiter;
		out.iRecordFEs = out.iRecordFEs + 1;
		
		if ~isempty(varargin)
			for j = 1 : 2 : numel(varargin)
				data = out.(varargin{j});
				if length(varargin{j + 1}) == 1
					data(i) = varargin{j + 1};
				else
					data(:, i) = varargin{j + 1}(:);
				end
				out.(varargin{j}) = data;
			end
		end
		
		if out.iRecordFEs > numel(out.fmin)
			break;
		end
	end
end
end
