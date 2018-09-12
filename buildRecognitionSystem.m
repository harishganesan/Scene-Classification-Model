function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    dictionarySize = size(dictionary,2); 
    layerNum = 3;
    train_features = [];
  
    for i = 1:size(train_imagenames,1)
        wordMap_name = [];
        wordMap_path = [];
        wordMap_name = strrep(train_imagenames{i},'.jpg','.mat');
        wordMap_path = strcat(['../data/'],wordMap_name);
        wordMap = load(wordMap_path);
        wordMap=wordMap.wordMap;
        train_features(:,i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
    end


	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end