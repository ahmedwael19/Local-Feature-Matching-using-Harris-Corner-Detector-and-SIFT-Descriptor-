% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech with Henry Hu <henryhu@gatech.edu>
% Edited by James Tompkin

% Your feature points should be unique within a local region,
% I.E., your detection non-maximal suppression function should work.
% 
% Look at the 'uniqueness test' for how we enforce this.
% It is intentionally simplistic and biased, 
% so make your detector _do the right thing_.

function [numGoodMatches,numBadMatches,precision,accuracy100] = evaluate_correspondence(imgA, imgB, ground_truth_correspondence_file, scale_factor, x1_est, y1_est, x2_est, y2_est, vis)

x1_est = x1_est ./ scale_factor;
y1_est = y1_est ./ scale_factor;
x2_est = x2_est ./ scale_factor;
y2_est = y2_est ./ scale_factor;

good_matches = zeros(length(x1_est),1); %indicator vector

% Loads `ground truth' positions x1, y1, x2, y2
load(ground_truth_correspondence_file)

%%%%%%%%%%%%%%%%%%%%%%
% Uniqueness test
%
x1_est_tmp = x1_est;
y1_est_tmp = y1_est;
x2_est_tmp = x2_est;
y2_est_tmp = y2_est;
uniquenessDist = 5;

% For each ground truth point
numPreMerge = length(x1_est);
for i=1:length(x1)
    % Compute distance of each estimated point to
    % the ground truth point
    x_dists = x1(i) - x1_est_tmp;
    y_dists = y1(i) - y1_est_tmp;
    dists = sqrt(  x_dists.^2 + y_dists.^2 );
    toMerge = dists < uniquenessDist;
    
    if sum(toMerge) > 1
        % Do something to remove duplicates. Let's
        % average the coordinates of all points 
        % within 'uniquenessDist' pixels.
        % Also average the corresponded point (!)
        %
        % This part is simplistic, but a real-world
        % computer vision system would not know
        % which correspondences were good.
        avgX1 = mean( x1_est_tmp( toMerge ) );
        avgY1 = mean( y1_est_tmp( toMerge ) );
        avgX2 = mean( x2_est_tmp( toMerge ) );
        avgY2 = mean( y2_est_tmp( toMerge ) );

        x1_est_tmp( toMerge ) = [];
        y1_est_tmp( toMerge ) = [];
        x2_est_tmp( toMerge ) = [];
        y2_est_tmp( toMerge ) = [];

        % Add back point
        x1_est_tmp(end+1) = avgX1;
        y1_est_tmp(end+1) = avgY1;
        x2_est_tmp(end+1) = avgX2;
        y2_est_tmp(end+1) = avgY2;
    end
end
x1_est = x1_est_tmp;
y1_est = y1_est_tmp; 
x2_est = x2_est_tmp;
y2_est = y2_est_tmp;
numPostMerge = length(x1_est);
%
% Uniqueness test end
%%%%%%%%%%%%%%%%%%%%%%

if vis
    figure;
    Height = max(size(imgA,1),size(imgB,1));
    Width = size(imgA,2)+size(imgB,2);
    numColors = size(imgA, 3);
    newImg = zeros(Height, Width,numColors);
    newImg(1:size(imgA,1),1:size(imgA,2),:) = imgA;
    newImg(1:size(imgB,1),1+size(imgA,2):end,:) = imgB;
    imshow(newImg, 'Border', 'tight')
    shiftX = size(imgA,2);
    hold on;
end

% Distance test
for i = 1:length(x1_est)
    
    fprintf('( %4.0f, %4.0f) to ( %4.0f, %4.0f)', x1_est(i), y1_est(i), x2_est(i), y2_est(i));

    % For each x1_est, find nearest ground truth point in x1
    x_dists = x1_est(i) - x1;
    y_dists = y1_est(i) - y1;
    dists = sqrt(  x_dists.^2 + y_dists.^2 );
    
    [dists, best_matches] = sort(dists);
    
    current_offset = [x1_est(i) - x2_est(i), y1_est(i) - y2_est(i)];
    most_similar_offset = [x1(best_matches(1)) - x2(best_matches(1)), y1(best_matches(1)) - y2(best_matches(1))];
    
    match_dist = sqrt( sum((current_offset - most_similar_offset).^2));
    
    % A match is bad if there's no ground truth point within 150 pixels 
    % or
    % If nearest ground truth correspondence offset isn't within 40 pixels
    % of the estimated correspondence offset.
    fprintf(' g.t. point %4.0f px. Match error %4.0f px.', dists(1), match_dist);
    
    if(dists(1) > 150 || match_dist > 40)
        good_matches(i) = 0;
        edgeColor = [1 0 0];
        fprintf('  incorrect\n');
    else
        good_matches(i) = 1;
    	edgeColor = [0 1 0];
        fprintf('  correct\n');
    end

    if vis
        cur_color = rand(1,3);
        plot(x1_est(i)*scale_factor,y1_est(i)*scale_factor, 'o', 'LineWidth',2, 'MarkerEdgeColor',edgeColor,...
                       'MarkerFaceColor', cur_color, 'MarkerSize',10)

        plot(x2_est(i)*scale_factor+shiftX,y2_est(i)*scale_factor, 'o', 'LineWidth',2, 'MarkerEdgeColor',edgeColor,...
                       'MarkerFaceColor', cur_color, 'MarkerSize',10)
    end
end

if vis
    hold off;
end
title("x");
numGoodMatches = sum(good_matches);
numBadMatches = length(x1_est) - sum(good_matches);
precision = (sum(good_matches) / length(x1_est)) * 100;
accuracy100 = min(sum(good_matches),100); % / 100) * 100; % If we were testing more than the top 100, then this would be important.
fprintf('Uniqueness: Pre-merge: %d  Post-merge: %d\n', numPreMerge, numPostMerge );
fprintf('%d total good matches, %d total bad matches.\n', numGoodMatches, numBadMatches)
fprintf('  %.2f%% precision\n', precision);
fprintf('  %.2f%% accuracy (top 100)\n', accuracy100);

% Visualize and save the result
if vis
  fprintf('Saving visualization to eval.png\n')
  saveas( gcf, 'eval.png' );
end