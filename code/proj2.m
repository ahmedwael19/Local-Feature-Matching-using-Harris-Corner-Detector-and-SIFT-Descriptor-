
% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech
% Edited by James Tompkin

% This script 
% - Loads and resizes images
% - Computes correspondence
% - Visualizes the matches
% - Evaluates the matches based on ground truth correspondences

clear 
clc 
close all

%% Define image pairs
imagePair = 1;
if imagePair == 1
    % Notre Dame de Paris
    % Easiest
    image1 = imread('../data/NotreDame/921919841_a30df938f2_o.jpg');
    image2 = imread('../data/NotreDame/4191453057_c86028ce1f_o.jpg');
    eval_file = '../data/NotreDame/921919841_a30df938f2_o_to_4191453057_c86028ce1f_o.mat';
elseif imagePair == 2
    % Mount Rushmore 
    % A little harder than Notre Dame
    image1 = imread('../data/MountRushmore/9021235130_7c2acd9554_o.jpg');
    image2 = imread('../data/MountRushmore/9318872612_a255c874fb_o.jpg');
    eval_file = '../data/MountRushmore/9021235130_7c2acd9554_o_to_9318872612_a255c874fb_o.mat';
elseif imagePair == 3
    % Gaudi's Episcopal Palace
    % This pair is difficult
    image1 = imread('../data/EpiscopalGaudi/4386465943_8cf9776378_o.jpg');
    image2 = imread('../data/EpiscopalGaudi/3743214471_1b5bbfda98_o.jpg');
    eval_file = '../data/EpiscopalGaudi/4386465943_8cf9776378_o_to_3743214471_1b5bbfda98_o.mat';
end

%% Load images
% We will test your algorithm at scale_factor = 0.5.
% NOTE: This parameter gets passed into the evaluation code,
% so don't resize the images except by changing this parameter.
scale_factor = 0.5;
image1 = im2single( imresize( image1, scale_factor, 'bilinear') );
image2 = im2single( imresize( image2, scale_factor, 'bilinear') );
image1g = rgb2gray(image1);
image2g = rgb2gray(image2);

%% Compute correspondences
% YOUR WORK IN HERE!
[x1, y1, x2, y2, matches, confidences] = compute_correspondences( image1g, image2g,eval_file,scale_factor );


%% Visualization
num_pts_to_visualize = min(100,size(matches,1));
% Feel free to set this to some constant (e.g., 100) once you start 
% detecting hundreds of interest points.
% You could also threshold based on confidence.

% You may also switch to a different visualization method, by passing
% 'arrows' into show_correspondence instead of 'dots'.
% e.g., 'arrows', 'vis_arrows.png'
show_correspondence(image1, image2, x1(matches(1:num_pts_to_visualize,1)), ...
                                     y1(matches(1:num_pts_to_visualize,1)), ...
                                     x2(matches(1:num_pts_to_visualize,2)), ...
                                     y2(matches(1:num_pts_to_visualize,2)), ...
                                 'arrows', 'vis_arrows.png');

                             
%% Evaluation
num_pts_to_evaluate = min(100,size(matches,1));
% Again, feel free to set this to some constant (e.g., 100) 
% once you start detecting hundreds of interest points.
% You could also threshold based on confidence.
% We will compute your accuracy using the first 100 matches.

% Only the Notre Dame, Episcopal Gaudi, and Mount Rushmore image pairs
% have ground truth for evaluation.
% You can use collect_ground_truth_corr.m to build ground truth for 
% other image pairs, but it's tedious.
[numGoodMatches,numBadMatches,precision,accuracy100] = evaluate_correspondence(image1, image2, eval_file, scale_factor, ... 
                        x1(matches(1:num_pts_to_evaluate,1)), ...
                        y1(matches(1:num_pts_to_evaluate,1)), ...
                        x2(matches(1:num_pts_to_evaluate,2)), ...
                        y2(matches(1:num_pts_to_evaluate,2)), ...
                        true ); % Visualize/write result

