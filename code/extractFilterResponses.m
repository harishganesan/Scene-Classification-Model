function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here

    
    [l b] = size(img);
    % for greyscale images
    if(size(img,3)==1)
        img = repmat(img, [1 1 3]);
    end
    
    filterResponses1=[];
    filterResponses=[];
    
    img = double(img);
    data2 = RGB2Lab(img);
    %creates the filters
    filterBank=createFilterBank();
    
    % calculates all filter responses for 20 filters
    for i=1:size(filterBank)
        data3= imfilter(data2,filterBank{i,1});
        filterResponses = cat(3,data3,filterResponses); % for return value of function
        filterResponses1(:,:,:,i)=data3; % for the montage
    end
    %montage(filterResponses1,'Size',[4 5]);    
end
