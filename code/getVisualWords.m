function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    
    filterResponse5 = extractFilterResponses(img,filterBank);
    [row1 col1 third1] = size(filterResponse5);
    filterResponse5 = reshape(filterResponse5, row1*col1, 60);
    
    % calculates the distance
    D = pdist2(filterResponse5,dictionary.');
    d_min = min(D,[],2);
    
    %get back 2D image
    wordMap = reshape(d_min,row1, col1); 
 
end
