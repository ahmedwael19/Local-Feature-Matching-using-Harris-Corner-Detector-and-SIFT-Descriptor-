% Image Correspondence Visualization
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech
% Edits by James Tompkin

% Visualizes corresponding points between two images, either as
% arrows or dots.
% mode='dots': Corresponding points will have the same random color
% mode='arrows': Corresponding points will be joined by a line
%
% Writes out a png of the visualization if 'filename' is not empty ([]).

function [ h ] = show_correspondence(imgA, imgB, X1, Y1, X2, Y2, mode, filename)

h = figure(3);

Height = max(size(imgA,1),size(imgB,1));
Width = size(imgA,2)+size(imgB,2);
numColors = size(imgA, 3);
newImg = zeros(Height, Width,numColors);
newImg(1:size(imgA,1),1:size(imgA,2),:) = imgA;
newImg(1:size(imgB,1),1+size(imgA,2):end,:) = imgB;
imshow(newImg, 'Border', 'tight')
shiftX = size(imgA,2);

hold on
for i = 1:size(X1,1)
    cur_color = rand(3,1);
    if strcmp( mode, 'dots' )
        plot(X1(i),Y1(i), 'o', 'LineWidth',2, 'MarkerEdgeColor','k',...
                           'MarkerFaceColor', cur_color, 'MarkerSize',10)
        plot(X2(i)+shiftX,Y2(i), 'o', 'LineWidth',2, 'MarkerEdgeColor','k',...
                           'MarkerFaceColor', cur_color, 'MarkerSize',10)
    elseif strcmp( mode, 'arrows' )
        plot([X1(i) shiftX+X2(i)],[Y1(i) Y2(i)],'*-','Color', cur_color, 'LineWidth',2)
    end
end
title("Local Feature Matching ");
hold off;

if ~isempty(filename)
  fprintf( 'Saving visualization\n' )
  saveas( gcf, filename );
end