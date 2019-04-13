function [x1, y1, x2, y2, matches, confidences] = compute_correspondences( image1, image2,eval_file,scale_factor )
% Brown CSCI1430 - James Tompkin
%
% This script:
% (1) Finds interest points in those images                 (you code this)
% (2) Describes each interest point with a local feature    (you code this)
% (3) Finds matching features                               (you code this)


% Width and height of the descriptor window around each local feature, in image pixels.
% In SIFT, this is 16 pixels.
%
descriptor_window_image_width = 16;

%% 1) Find distinctive points in each image. Szeliski 4.1.1
% !!! You will need to implement get_interest_points. !!!
[x1, y1] = get_interest_points(image1, descriptor_window_image_width,1);
[x2, y2] = get_interest_points(image2, descriptor_window_image_width,2);

% % Use cheat_interest_points only for development and debugging!
% [x1, y1, x2, y2] = cheat_interest_points(eval_file, scale_factor,image2);

%% 2) Create feature vectors at each interest point. Szeliski 4.1.2
% !!! You will need to implement get_features. !!!
[image1_features] = get_features(image1, x1, y1, descriptor_window_image_width);
[image2_features] = get_features(image2, x2, y2, descriptor_window_image_width);


%% 3) Match features. Szeliski 4.1.3
% !!! You will need to implement get_features. !!!
[matches, confidences] = match_features(image1_features, image2_features);

end

