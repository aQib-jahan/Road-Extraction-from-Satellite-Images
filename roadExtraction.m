clc
clear all;
close all;

%% Load Image
file = "img1.jpg"; %mention the image location

I=imread(file);

%% ORIGINAL IMAGE

figure;
imshow(I);
title('ORGINAL IMAGE');

%% Conversion to grayscale

J=rgb2gray(I);
figure,imshow(J);
title('GRAYSCALED IMAGE ');

%% Adjust image intensity
K=imadjust(J,[0.5 0.9],[]); 

figure;
imshow(K);

%% Thresholding
level = graythresh(K);  
I=im2bw(K,level); 
figure;
imshow(I);
title('BINARY IMAGE AFTER THRESHOLDING');

%% Filtering
B = medfilt2(I);
figure,imshow(B);
title('MEDIAN FILTERED IMAGE');

%% Morphological Operation
im = bwareaopen(B,500);   
% im = bwmorph(im, 'fill');
im = bwmorph(im, 'majority');

se=strel('square',2);
im1=imclose(im,se);
figure,imshow(im1);
imwrite(im1,"Extracted.jpg")

BW = bwmorph(im,'remove');
figure,imshow(BW);
title('MORPHOLOGICAL FILTERED IMAGE');

%% Edge Detection
%%% Sobel Edge Detection
BW1 = edge(BW,'sobel');
figure,imshow(BW1);
title('SOBEL EDGE DETECTION ON IMAGE');

%%% Canny Edge Detection
% BW1 = edge(BW,'canny',[0.36 0.9]);
% figure,imshow(BW1);
% title('Edge detection(canny)');

%% Final Image
se = ones(2,3);
closeBW=imclose(BW1,se);
subplot(1,2,1), imshow(closeBW), title('CLOSED IMAGE');
subplot(1,2,2), imshow(im1), title('NORMAL');

H = vision.AlphaBlender;
J = im2single(J);
BW1 = im2single(BW1);
Y = step(H,J,BW1);
imwrite(Y,"Overlayed.jpg")
figure,imshow(Y)
title('Overlay on grayscale image');