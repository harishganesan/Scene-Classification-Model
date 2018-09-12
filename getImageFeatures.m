function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
	
    % Calculates the histogram
    h_obj = histogram(wordMap,dictionarySize);
    h = h_obj.Values;
    % Check for size
	assert(numel(h) == dictionarySize);
    % Normalizing
    h = h/norm(h,1);
    h = h.';
    
end