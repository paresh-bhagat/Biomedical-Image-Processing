%Ques-1

%Load image

path = 'C:\Users\Paresh\Desktop\brain.dcm';
Img=dicomread(path);
figure,imagesc(Img),colormap(gray),colorbar,axis off,axis image;
title('Original');

Img=double(Img);

%%

%Ques-2

%Scale image to 0-255

m1 = min(Img(:));
M1 = max(Img(:));
m2 = 0; M2 = 255;

img_nor = m2 + (double(Img-m1)./double(M1-m1))*(M2-m2);
figure, imagesc(img_nor), colormap(gray), colorbar, axis off, axis image
title('Normalized');


%%

%Ques-3

%convert to unit8

img_nor = uint8(img_nor);
figure,imagesc(img_nor),colormap(gray),colorbar,axis off,axis image;
title('Converted to unit8');

%%

%Ques-4

%add noise salt&pepper

%noise density 0.01

Img_sp1 = imnoise(img_nor,'salt & pepper',0.01);

%noise density 0.05
Img_sp2 = imnoise(img_nor,'salt & pepper',0.05);

%noise density 0.08
Img_sp3 = imnoise(img_nor,'salt & pepper',0.08);

figure,
subplot(1,3,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(1,3,2),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(1,3,3),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');

%%

%Ques-5

%Denoise using mean filter

%Size 3x3

filt_mean1 = fspecial('average',3);
Img_filter1 = imfilter(Img_sp1,filt_mean1);
Img_filter2 = imfilter(Img_sp2,filt_mean1);
Img_filter3 = imfilter(Img_sp3,filt_mean1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 3x3');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 3x3');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 3x3');

%Size 9x9

filt_mean1 = fspecial('average',9);
Img_filter1 = imfilter(Img_sp1,filt_mean1);
Img_filter2 = imfilter(Img_sp2,filt_mean1);
Img_filter3 = imfilter(Img_sp3,filt_mean1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 9x9');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 9x9');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 9x9');

%Size 15x15

filt_mean1 = fspecial('average',15);
Img_filter1 = imfilter(Img_sp1,filt_mean1);
Img_filter2 = imfilter(Img_sp2,filt_mean1);
Img_filter3 = imfilter(Img_sp3,filt_mean1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 15x15');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 15x25');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 15x15');

%%

%Ques-6

%Denoise using median filter

%Size 3x3

Img_filter1 = medfilt2(Img_sp1,[3,3]);
Img_filter2 = medfilt2(Img_sp2,[3,3]);
Img_filter3 = medfilt2(Img_sp3,[3,3]);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 3x3');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 3x3');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 3x3');

%Size 9x9

Img_filter1 = medfilt2(Img_sp1,[9,9]);
Img_filter2 = medfilt2(Img_sp2,[9,9]);
Img_filter3 = medfilt2(Img_sp3,[9,9]);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 9x9');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 9x9');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 9x9');

%Size 15x15

Img_filter1 = medfilt2(Img_sp1,[15,15]);
Img_filter2 = medfilt2(Img_sp2,[15,15]);
Img_filter3 = medfilt2(Img_sp3,[15,15]);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 15x15');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 15x25');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 15x15');

%%

%Ques-7

%Denoise using gaussian filter

%Size 3x3 standard deviation-0.25

filt_gaussian1 = fspecial('gaussian',3,0.25);
Img_filter1 = imfilter(Img_sp1,filt_gaussian1);
Img_filter2 = imfilter(Img_sp2,filt_gaussian1);
Img_filter3 = imfilter(Img_sp3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.25');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.25');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.25');

%Size 3x3 standard deviation-0.5

filt_gaussian1 = fspecial('gaussian',3,0.5);
Img_filter1 = imfilter(Img_sp1,filt_gaussian1);
Img_filter2 = imfilter(Img_sp2,filt_gaussian1);
Img_filter3 = imfilter(Img_sp3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.5');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.5');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.5');


%Size 9x9 standard deviation-0.25

filt_gaussian1 = fspecial('gaussian',9,0.25);
Img_filter1 = imfilter(Img_sp1,filt_gaussian1);
Img_filter2 = imfilter(Img_sp2,filt_gaussian1);
Img_filter3 = imfilter(Img_sp3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.25');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.25');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.25');

%Size 9x9 standard deviation-0.5

filt_gaussian1 = fspecial('gaussian',9,0.5);
Img_filter1 = imfilter(Img_sp1,filt_gaussian1);
Img_filter2 = imfilter(Img_sp2,filt_gaussian1);
Img_filter3 = imfilter(Img_sp3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.5');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.5');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.5');


%Size 15x15 standard deviation-0.25

filt_gaussian1 = fspecial('gaussian',15,0.25);
Img_filter1 = imfilter(Img_sp1,filt_gaussian1);
Img_filter2 = imfilter(Img_sp2,filt_gaussian1);
Img_filter3 = imfilter(Img_sp3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.25');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.25');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.25');

%Size 15x15 standard deviation-0.5

filt_gaussian1 = fspecial('gaussian',15,0.5);
Img_filter1 = imfilter(Img_sp1,filt_gaussian1);
Img_filter2 = imfilter(Img_sp2,filt_gaussian1);
Img_filter3 = imfilter(Img_sp3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_sp1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.5');
subplot(3,2,3),imagesc(Img_sp2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.05');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.5');
subplot(3,2,5),imagesc(Img_sp3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Salt & pepper with noise density 0.08');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.5');

%%

%Part-2

%Ques-8

%add gausssian noise

%mean=0 , variance=0.01

Img_g1 = imnoise(img_nor,'gaussian',0,0.01);

%mean=0 , variance=0.025

Img_g2 = imnoise(img_nor,'gaussian',0,0.025);

%mean=0 , variance=0.05

Img_g3 = imnoise(img_nor,'gaussian',0,0.05);


figure,
subplot(1,3,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(1,3,2),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(1,3,3),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');

%%

%Ques-9

%Denoise using mean filter

%Size 3x3

filt_mean1 = fspecial('average',3);
Img_filter1 = imfilter(Img_g1,filt_mean1);
Img_filter2 = imfilter(Img_g2,filt_mean1);
Img_filter3 = imfilter(Img_g3,filt_mean1);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 3x3');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 3x3');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 3x3');

%Size 9x9

filt_mean1 = fspecial('average',9);
Img_filter1 = imfilter(Img_g1,filt_mean1);
Img_filter2 = imfilter(Img_g2,filt_mean1);
Img_filter3 = imfilter(Img_g3,filt_mean1);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 9x9');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 9x9');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 9x9');

%Size 15x15

filt_mean1 = fspecial('average',15);
Img_filter1 = imfilter(Img_g1,filt_mean1);
Img_filter2 = imfilter(Img_g2,filt_mean1);
Img_filter3 = imfilter(Img_g3,filt_mean1);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 15x15');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 15x15');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - mean filter of size 15x15');

%%

%Ques-10

%Denoise using median filter

%Size 3x3

Img_filter1 = medfilt2(Img_g1,[3,3]);
Img_filter2 = medfilt2(Img_g2,[3,3]);
Img_filter3 = medfilt2(Img_g3,[3,3]);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 3x3');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 3x3');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 3x3');

%Size 9x9

Img_filter1 = medfilt2(Img_g1,[9,9]);
Img_filter2 = medfilt2(Img_g2,[9,9]);
Img_filter3 = medfilt2(Img_g3,[9,9]);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 9x9');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 9x9');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 9x9');

%Size 15x15

Img_filter1 = medfilt2(Img_g1,[15,15]);
Img_filter2 = medfilt2(Img_g2,[15,15]);
Img_filter3 = medfilt2(Img_g3,[15,15]);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 15x15');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 15x25');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - median filter of size 15x15');

%%

%Ques-11

%Denoise using gaussian filter

%Size 3x3 standard deviation-0.25

filt_gaussian1 = fspecial('gaussian',3,0.25);
Img_filter1 = imfilter(Img_g1,filt_gaussian1);
Img_filter2 = imfilter(Img_g2,filt_gaussian1);
Img_filter3 = imfilter(Img_g3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.25');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.25');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.25');

%Size 3x3 standard deviation-0.5

filt_gaussian1 = fspecial('gaussian',3,0.5);
Img_filter1 = imfilter(Img_g1,filt_gaussian1);
Img_filter2 = imfilter(Img_g2,filt_gaussian1);
Img_filter3 = imfilter(Img_g3,filt_gaussian1);


figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.5');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.5');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 3x3 & sd-0.5');


%Size 9x9 standard deviation-0.25

filt_gaussian1 = fspecial('gaussian',9,0.25);
Img_filter1 = imfilter(Img_g1,filt_gaussian1);
Img_filter2 = imfilter(Img_g2,filt_gaussian1);
Img_filter3 = imfilter(Img_g3,filt_gaussian1);


figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.25');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.25');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.25');

%Size 9x9 standard deviation-0.5

filt_gaussian1 = fspecial('gaussian',9,0.5);
Img_filter1 = imfilter(Img_g1,filt_gaussian1);
Img_filter2 = imfilter(Img_g2,filt_gaussian1);
Img_filter3 = imfilter(Img_g3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.5');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.5');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 9x9 & sd-0.5');


%Size 15x15 standard deviation-0.25

filt_gaussian1 = fspecial('gaussian',15,0.25);
Img_filter1 = imfilter(Img_g1,filt_gaussian1);
Img_filter2 = imfilter(Img_g2,filt_gaussian1);
Img_filter3 = imfilter(Img_g3,filt_gaussian1);

figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.25');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.25');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.25');

%Size 15x15 standard deviation-0.5

filt_gaussian1 = fspecial('gaussian',15,0.5);
Img_filter1 = imfilter(Img_g1,filt_gaussian1);
Img_filter2 = imfilter(Img_g2,filt_gaussian1);
Img_filter3 = imfilter(Img_g3,filt_gaussian1);


figure,
subplot(3,2,1),imagesc(Img_g1),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.01');
subplot(3,2,2),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.5');
subplot(3,2,3),imagesc(Img_g2),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.025');
subplot(3,2,4),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.5');
subplot(3,2,5),imagesc(Img_g3),colormap(gray),colorbar,axis off,axis image;title('Noisy image - Gaussian with mean=0 and variance=0.05');
subplot(3,2,6),imagesc(Img_filter1),colormap(gray),colorbar,axis off,axis image;title('After denoising image - gaussian filter of size 15x15 & sd-0.5');

%%

%Home work assignment


