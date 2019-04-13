function [acc100ND,acc100MR,acc100EG,acc100Avg] = proj2_averageAccuracy( )
% Brown CSCI 1430 - James Tompkin
% Our evaluation function to compute your accuracies.

% Setup variables
scale_factor = 0.5;
maxPtsEval = 100;

%% Notre Dame de Paris
fprintf( 'Notre Dame de Paris\n' );
image1 = imread('../data/NotreDame/921919841_a30df938f2_o.jpg');
image2 = imread('../data/NotreDame/4191453057_c86028ce1f_o.jpg');
eval_file = '../data/NotreDame/921919841_a30df938f2_o_to_4191453057_c86028ce1f_o.mat';

image1 = im2single( imresize( rgb2gray(image1), scale_factor, 'bilinear') );
image2 = im2single( imresize( rgb2gray(image2), scale_factor, 'bilinear') );

[x1, y1, x2, y2, matches, ~] = compute_correspondences( image1, image2 );

num_pts_to_evaluate = min(maxPtsEval,size(matches,1));
[~,~,~,acc100ND] = evaluate_correspondence(image1, image2, eval_file, scale_factor, ... 
                        x1(matches(1:num_pts_to_evaluate,1)), ...
                        y1(matches(1:num_pts_to_evaluate,1)), ...
                        x2(matches(1:num_pts_to_evaluate,2)), ...
                        y2(matches(1:num_pts_to_evaluate,2)), ...
                        false );

%% Mount Rushmore
fprintf( '\n\nMount Rushmore\n' );
image1 = imread('../data/MountRushmore/9021235130_7c2acd9554_o.jpg');
image2 = imread('../data/MountRushmore/9318872612_a255c874fb_o.jpg');
eval_file = '../data/MountRushmore/9021235130_7c2acd9554_o_to_9318872612_a255c874fb_o.mat';

image1 = im2single( imresize( rgb2gray(image1), scale_factor, 'bilinear') );
image2 = im2single( imresize( rgb2gray(image2), scale_factor, 'bilinear') );

[x1, y1, x2, y2, matches, ~] = compute_correspondences( image1, image2 );

num_pts_to_evaluate = min(maxPtsEval,size(matches,1));
[~,~,~,acc100MR] = evaluate_correspondence(image1, image2, eval_file, scale_factor, ... 
                        x1(matches(1:num_pts_to_evaluate,1)), ...
                        y1(matches(1:num_pts_to_evaluate,1)), ...
                        x2(matches(1:num_pts_to_evaluate,2)), ...
                        y2(matches(1:num_pts_to_evaluate,2)), ...
                        false );


%% Gaudi's Episcopal Palace
fprintf( '\n\nGaudi''s Episcopal Palace\n' );
image1 = imread('../data/EpiscopalGaudi/4386465943_8cf9776378_o.jpg');
image2 = imread('../data/EpiscopalGaudi/3743214471_1b5bbfda98_o.jpg');
eval_file = '../data/EpiscopalGaudi/4386465943_8cf9776378_o_to_3743214471_1b5bbfda98_o.mat';

image1 = im2single( imresize( rgb2gray(image1), scale_factor, 'bilinear') );
image2 = im2single( imresize( rgb2gray(image2), scale_factor, 'bilinear') );

[x1, y1, x2, y2, matches, ~] = compute_correspondences( image1, image2 );

num_pts_to_evaluate = min(maxPtsEval,size(matches,1));
[~,~,~,acc100EG] = evaluate_correspondence(image1, image2, eval_file, scale_factor, ... 
                        x1(matches(1:num_pts_to_evaluate,1)), ...
                        y1(matches(1:num_pts_to_evaluate,1)), ...
                        x2(matches(1:num_pts_to_evaluate,2)), ...
                        y2(matches(1:num_pts_to_evaluate,2)), ...
                        false );

acc100Avg = (acc100ND + acc100MR + acc100EG) / 3;

end