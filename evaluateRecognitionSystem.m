function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

% TODO Implement your code here
    
    % Loads the necessary files
	load('vision.mat');
	load('../data/traintest.mat');
    
    %Calculates predicted labels
    predicted_labels = [];
    for i = 1:length(test_imagenames)
        guessed = guessImage(strcat(['../data/'],test_imagenames{i}));
        guessed_index = find(strcmp(guessed, mapping));
        predicted_labels{i}=guessed_index;
    end
    predicted_labels = predicted_labels.';
    
    predicted_labels = cell2mat(predicted_labels);
    
    % Calculate confusion matrix
    [conf, order]=confusionmat(test_labels, predicted_labels);
	

end