% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of interest points for the input image

% 'image' can be grayscale or color, your choice.
% 'descriptor_window_image_width', in p ixels.
%   This is the local feature descriptor width. It might be useful in this function to 
%   (a) suppress boundary interest points (where a feature wouldn't fit entirely in the image, anyway), or
%   (b) scale the image filters being used. 
% Or you can ignore it.

% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
% 'confidence' is an nx1 vector indicating the strength of the interest
%   point. You might use this later or not.
% 'scale' and 'orientation' are nx1 vectors indicating the scale and
%   orientation of each interest point. These are OPTIONAL. By default you
%   do not need to make scale and orientation invariant local features.
function [x, y, confidence, scale, orientation] = get_interest_points(image, descriptor_window_image_width,im_n)

% Implement the Harris corner detector (See Szeliski 4.1.1) to start with.
% You can create additional interest point detector functions (e.g. MSER)
% for extra credit.

% If you're finding spurious interest point detections near the boundaries,
% it is safe to simply suppress the gradients / corners near the edges of
% the image.

% The lecture slides and textbook are a bit vague on how to do the
% non-maximum suppression once you've thresholded the cornerness score.
% You are free to experiment. Here are some helpful functions:
%  BWLABEL and the newer BWCON      MP will find connected components in 
% thresholded binary image. You could, for instance, take the maximum value
% within each component.
%  COLFILT can be used to run a max() operator on each sliding window. You
% could use this to ensure that every interest point is at a local maximum
% of cornerness.

% Placeholder that you can delete -- random points

%% Step 1 : Compute x and y derivatives of the image
sobel_x = [-1 0 1 ; -2 0 2 ; -1 0 1];
sobel_y = transpose(sobel_x)*-1;
sobel_x_gauss = imgaussfilt(sobel_x);
sobel_y_gauss = imgaussfilt(sobel_y);
Ix = imfilter(image,sobel_x_gauss,'conv');
Iy = imfilter(image,sobel_y_gauss,'conv');

%% Step 2 : Compute products of derivatives at every pixel
Ix2 = Ix.*Ix;
Iy2 = Iy .*Iy;
Ixy = Ix .*Iy;

%% Step 3 : Compute the sums of products of derivaties at each pixel
Sx2 = imgaussfilt(Ix2);
Sy2 = imgaussfilt(Iy2);
Sxy = imgaussfilt(Ixy);
 
%% Step 4 : define the matrix H at each pixel
[r,c] = size(image);
det_H = Sx2 .*Sy2 - Sxy.*Sxy;
trace_H = Sx2 + Sy2;

%% Step 5 : Compute the respone of the detector at each pixel
R = det_H - 0.04*(trace_H).^2;


%% Step 6 : Apply non maximum suppresion using 5*5 window
x = []; % this will be the interest point coordinates in x
y = []; % this will be the interest point coordinates in y
t = 0.002;
for i = 8:1:c-20 % columns ( start from 8 and end with c-20, so we discard the corners of the image )
    for j = 8:1:r-20 % rows ( same )
        % Get the current pixel R value and compare it to the 8 values
        % around it ( 3*3 window ). 
        current_pixel_R = R(j,i); 
        start_x = j-1; 
        start_y = i-1;
        end_x = j+1;
        end_y = i+1;
        window = R(start_x:end_x,start_y:end_y);  

        values_sorted = sort(reshape(window, [9,1]),'descend'); % sort the window and reshape it to be a vector
        if current_pixel_R >t % got this value from trial and error 
            if current_pixel_R == values_sorted(1) % if the current value is the maximum-> add its coordinates
                x = [x i];
                y = [y j];
            end
        end
    end
end
x = x'; % transponse to be a column vector
y = y';
figure;

imshow(image);
hold on
scatter(x,y);
title("The image number"+string(im_n)+" with all interest points and Threshold of" +string(t) );
end

