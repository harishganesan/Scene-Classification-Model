function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.


    % TODO Implement your code here
    
    % Creates the filters 
    filterBank  = createFilterBank();
    % Loads necessary files
    load('traintest.mat');
    
    rand_pix3 = [];
   
   
    % load all the image names one at a time
    for i = 1:length(train_imagenames)
        
        I = imread(imPaths{i});
        
        %for greyscale images
        if(size(I,3) == 1)
            I =  cat(3,I,I,I)
        end

        %extract filter responses for the image
        train_filter =  extractFilterResponses(I,filterBank);
        [row col third] = size(I);
    
        % pick 100 random pixels
        loc = randperm(row*col,100);
        s = [row col];
        [x y] = ind2sub(s,loc);
        
        for j = 1:size(x,2)
            rand_pix = train_filter(x(j),y(j),:);
            rand_pix = permute(rand_pix,[1 3 2]);
            rand_pix3 = cat(1,rand_pix3,rand_pix);
        end
       
    end 
   
    % compute k-means for 250 clusters
    [~,dictionary] = kmeans(rand_pix3,250,'EmptyAction','drop');
    % compute transpose of dictionary
    dictionary=transpose(dictionary);
end
