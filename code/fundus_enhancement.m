clc                     % Clear the command window
close all               % Close all open figure windows
imtool close all        % Close all image tool windows

% Read the input retinal image
I = imread('13_right.jpeg');
figure, imshow(I);
title('Original Image');

% Convert image to double precision for processing
b = im2double(I);

% Apply sharpening filter to enhance edges
O1 = imsharpen(b, 'Radius', 3, 'Amount', 1.2);
figure, imshow(O1);
title('Sharpened Image');

% Convert RGB image to grayscale
O2 = rgb2gray(I);
figure, imshow(O2);
title('Gray-scale Image');

% Enhance contrast using adaptive histogram equalization
O3 = adapthisteq(O2, 'numtiles', [12 12], 'nBins', 128);
figure, imshow(O3);
title('Enhanced Gray-scale Image');

% Create an averaging filter and apply it to smooth the image
h = fspecial('average', [36 36]);
filtered_O = imfilter(O3, h);
figure, imshow(filtered_O);
title('Average Filtered Image');

% Subtract smoothed image from enhanced image to extract point of interest
O4 = imsubtract(filtered_O, O3);
figure, imshow(O4);
title('Extracted POI');

% Adjust image intensity for better contrast
output = imadjust(O4);
figure, imshow(output);
title('Final Output with Noise');

% Apply median filtering to remove noise
out = medfilt2(output, [18 18]);
figure, imshow(out);
title('Final Output');

% Show all processing stages in a montage
figure, montage({I, O1, O2, O3, filtered_O, O4, output, out}, 'Size', [2 4]);
title('Stages of Image Processing');
