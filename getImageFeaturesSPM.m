function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here

    [row2 col2] = size(wordMap);

    h2=[];
    h1=[];
    h0=[];
    
    % Weights
    w1 = 0.25;
    w2= 0.5;
    
    
    % For level 2 -consider all cases where row or col is multiple of 4 or not
    
     if(mod(row2,4)==0 & mod(col2,4)==0)
        c2 = mat2cell(wordMap,[row2/4 row2/4 row2/4 row2/4],[col2/4 col2/4 col2/4 col2/4]);
     elseif(mod(row2,4)==0 & mod(col2,4)==1)
        c2 = mat2cell(wordMap,[row2/4 row2/4 row2/4 row2/4],[ceil(col2/4) floor(col2/4) floor(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==0 & mod(col2,4)==2)
        c2 = mat2cell(wordMap,[row2/4 row2/4 row2/4 row2/4],[ceil(col2/4) ceil(col2/4) floor(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==0 & mod(col2,4)==3)
        c2 = mat2cell(wordMap,[row2/4 row2/4 row2/4 row2/4],[ceil(col2/4) ceil(col2/4) ceil(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==1 & mod(col2,4)==0)
        c2 = mat2cell(wordMap,[ceil(row2/4) floor(row2/4)  floor(row2/4) floor(row2/4)],[col2/4 col2/4 col2/4 col2/4]); 
     elseif(mod(row2,4)==1 & mod(col2,4)==1)
        c2 = mat2cell(wordMap,[ceil(row2/4) floor(row2/4)  floor(row2/4) floor(row2/4)],[ceil(col2/4) floor(col2/4) floor(col2/4) floor(col2/4)]);
     elseif(mod(row2,4)==1 & mod(col2,4)==2)
        c2 = mat2cell(wordMap,[ceil(row2/4) floor(row2/4)  floor(row2/4) floor(row2/4)] ,[ceil(col2/4) ceil(col2/4) floor(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==1 & mod(col2,4)==3)
        c2 = mat2cell(wordMap,[ceil(row2/4) floor(row2/4)  floor(row2/4) floor(row2/4)],[ceil(col2/4) ceil(col2/4) ceil(col2/4) floor(col2/4)]); 
    elseif(mod(row2,4)==2 & mod(col2,4)==0)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  floor(row2/4) floor(row2/4)],[col2/4 col2/4 col2/4 col2/4]);
     elseif(mod(row2,4)==2 & mod(col2,4)==1)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  floor(row2/4) floor(row2/4)],[ceil(col2/4) floor(col2/4) floor(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==2 & mod(col2,4)==2)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  floor(row2/4) floor(row2/4)],[ceil(col2/4) ceil(col2/4) floor(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==2 & mod(col2,4)==3)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  floor(row2/4) floor(row2/4)],[ceil(col2/4) ceil(col2/4) ceil(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==3 & mod(col2,4)==0)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  ceil(row2/4) floor(row2/4)],[col2/4 col2/4 col2/4 col2/4]); 
     elseif(mod(row2,4)==3 & mod(col2,4)==1)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  ceil(row2/4) floor(row2/4)],[ceil(col2/4) floor(col2/4) floor(col2/4) floor(col2/4)]);
     elseif(mod(row2,4)==3 & mod(col2,4)==2)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  ceil(row2/4) floor(row2/4)],[ceil(col2/4) ceil(col2/4) floor(col2/4) floor(col2/4)]); 
     elseif(mod(row2,4)==3 & mod(col2,4)==3)
        c2 = mat2cell(wordMap,[ceil(row2/4) ceil(row2/4)  ceil(row2/4) floor(row2/4)],[ceil(col2/4) ceil(col2/4) ceil(col2/4) floor(col2/4)]); 
     end  
     
    % Calculate 16 histograms
    for i = 1:4
        for j =1:4
            h2{i,j} = getImageFeatures(c2{i,j},dictionarySize);
        end
    end
    
    % Concatenate 
     h2 = reshape(h2,[1,16]);
     h2 = cell2mat(h2);
     h2 = h2*w2;
        
        
        
    % For level 1 - consider whether row and col are even or odd
    if(mod(row2,2)==1 & mod(col2,2)==0)
        c1 = mat2cell(wordMap,[ceil(row2/2) floor(row2/2)],[col2/2 col2/2]);
    elseif(mod(row2,2)==0 & mod(col2,2)==1)
        c1 = mat2cell(wordMap,[row2/2 row2/2],[ceil(col2/2) floor(col2/2)]);
    elseif(mod(row2,2)==1 & mod(col2,2)==1)
        c1 = mat2cell(wordMap,[ceil(row2/2) floor(row2/2)],[ceil(col2/2) floor(col2/2)]);
    else 
        c1 = mat2cell(wordMap,[row2/2 row2/2],[col2/2 col2/2]);
    end
    
    % Calculate 4 histograms
     for i = 1:2
        for j =1:2
            h1{i,j} = getImageFeatures(c1{i,j},dictionarySize);
        end
     end
    
     h1 = reshape(h1,[1,4]);
     h1 = cell2mat(h1);
     h1=h1*w1;
   
    % Calculate 1 histogram
   h0 = getImageFeatures(wordMap,dictionarySize);
   h0=h0*w1;
   
   % Combine 16+4+1 = 21 histograms in total in one variable
   h3 = cat(2,h0,h1,h2);
   h3 = reshape(h3,dictionarySize*21,1);
   h3 = h3/norm(h3,1);
   h = h3;
   

end