% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% 'features1' and 'features2' are the n x feature dimensionality features
%   from the two images.
% If you want to include geometric verification in this stage, you can add
% the x and y locations of the features as additional inputs.
%
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index
%   in features2. 
% 'Confidences' is a k x 1 matrix with a real valued confidence for every
%   match.
% 'matches' and 'confidences' can empty, e.g. 0x2 and 0x1.
function [matches, confidences] = match_features(features1, features2)

% This function does not need to be symmetric (e.g. it can produce
% different numbers of matches depending on the order of the arguments).

% To start with, simply implement the "ratio test", equation 4.18 in
% section 4.1.3 of Szeliski. For extra credit you can implement various
% forms of spatial verification of matches.
Threshold_test = 0.96; % empirical value
num_features = min(size(features1, 1), size(features2,1)); %% the number of features is minimum of both
matches = zeros(num_features, 2); % pre-allocation for speed
[index_nearest_two,nearest_two_neighbors] = knnsearch(features2,features1,'k',2); %% BONUS
index_feature1 = (1:size(features1,1)); % create features1 index vector
NNDR = nearest_two_neighbors(:,1)./nearest_two_neighbors(:,2); % perform the NNDR test (ratio test)
good_matches = []; % these are the only taken points
mathecs_counter = 1; % increase only if it is a good candidate
for i = 1:length(NNDR)
   if NNDR(i) < Threshold_test
       good_matches = [good_matches NNDR(i)]; % concatenate the good matches
       matches(mathecs_counter,1) = index_feature1(i); % assign the index in the feature1 vector
       matches(mathecs_counter,2) = index_nearest_two(i,1); % assign the index of the first neighbour, hence the "1"
       mathecs_counter = mathecs_counter+1;  % increment the counter
   end
end

% Sort the matches so that the most confident onces are at the top of the
% list. You should not delete this, so that the evaluation
% functions can be run on the top matches easily.
[confidences, ind] = sort(good_matches, 'ascend');
matches = matches(ind,:);