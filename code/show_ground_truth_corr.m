% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech
% Edits by James Tompkin

function show_ground_truth_corr()

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

load(eval_file)

show_correspondence(image1, image2, x1, y1, x2, y2)