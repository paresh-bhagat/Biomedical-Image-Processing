% Assignment - 5

%% For contrast enhancing tumor region

clc;
clear;

% Read image

Img = double(dicomread('T1CE_BrainTumor.dcm')); % Read an image
figure, imagesc(Img), colormap(gray), colorbar, axis off, axis image,title('Original Image');
[W, H]  = size(Img);

% Normalize image

Img_norm = (double(Img-min(Img(:)))/double(max(Img(:)-min(Img(:)))));
figure,imagesc(Img_norm),colormap(gray),colorbar,title('Normalized Image');

%%

% Compute ground truth using mask operation

figure, imagesc(Img_norm), colormap(gray), colorbar, axis off, axis image
mask1 =  roipoly();
mask2 = roipoly();

mask = double(mask1)- double(mask2);

figure
subplot(1,3,1), imagesc(mask1), colormap(gray), colorbar, axis off, axis image, title('mask-1');
subplot(1,3,2), imagesc(mask2), colormap(gray), colorbar, axis off, axis image, title('mask-2');
subplot(1,3,3), imagesc(mask), colormap(gray), colorbar, axis off, axis image, title('Ground truth');

%% k-means clustering

% k-means clustering

tic
figure,imagesc(Img_norm),colormap(gray)
nuClusters = 5;
[Indx, Cval] = kmeans(double(Img_norm(:)), nuClusters);
I_seg = reshape(Indx, size(Img_norm));
figure,imagesc(I_seg),colormap(gray),colorbar,axis image,title('Segmented image using k-means clustering');

% convert image to binary image using two tumor intensity values
intensity1 = I_seg(280,130);
intensity2 = I_seg(273,162);
img_kmeans = I_seg;
for i = 1:W
    for j =1:H
        if( img_kmeans(i,j) == intensity1 || img_kmeans(i,j) == intensity2 )
            img_kmeans(i,j) = 1;
        else
            img_kmeans(i, j) = 0;
        end
    end
end

figure, imagesc(img_kmeans), axis image, colormap(gray) , colorbar, title('Binary Image'); 

% Cut the tumor part of image

Img_cut = img_kmeans ;
for i= 1: W
    for j= 1: H
        if(i<200 || i>340) || (j<105 || j>220)
            Img_cut(i,j) = 0;
       
        end
    end
end

figure,imagesc(Img_cut),colormap(jet)


% Cleaning image using opening and closing

SE = strel('diamond', 3);
Img_clean = imopen(Img_cut, SE); 
figure,imagesc(Img_clean),colormap(gray)
Img_clean = imclose(Img_clean,SE); 
figure,imagesc(Img_clean),colormap(gray)
timeElapsed_kmeans = toc;

figure
subplot(3,1,1) ,imagesc(I_seg),colormap(jet),colorbar,axis image,title('Segmented image using k-means clustering');
subplot(3,1,2) ,imagesc(img_kmeans),colormap(gray),colorbar,axis image, title('Binary Image'); 
subplot(3,1,3) ,imagesc(Img_clean),colormap(gray),colorbar,axis image,title('Final segmented image after cleaning');

% Compute dice coefficient

[perc_error, dice_kmeans, jacc_kmeans, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_clean,mask,0);

%% Segmentation based on GMM

tic
X=double(reshape(Img,[W*H,1]));
[n,p] = size(X);
t=1:n;
k = 7; % number of Gaussians
options = statset('MaxIter',200); % Increase number of EM iterations
gmfit = fitgmdist(X,k,'CovType', 'full', 'SharedCov',true,'Options',options);
clusterX = cluster(gmfit,X);
h1 = gscatter(t,X,clusterX);
A22=reshape(clusterX,[W,H]);
figure,imagesc(A22), colormap(gray), colorbar, axis image, axis off,title('Segmented image using GMM');

% Convert image to binary image using two tumor intensity values

intensity1 = A22(280,130);
intensity2 = A22(273,162);
img_gmm = A22;
for i = 1:W
    for j =1:H
        if( img_gmm(i,j) == intensity1 || img_gmm(i,j) == intensity2)
            img_gmm(i,j) = 1;
        else
            img_gmm(i, j) = 0;
        end
    end
end

figure, imagesc(img_gmm), axis image, colormap(gray) ,colorbar, title('Binary Image'); 

% Cut the tumor part of image

Img_cut = img_gmm ;
for i= 1: W
    for j= 1: H
        if(i<200 || i>340) || (j<105 || j>220)
            Img_cut(i,j) = 0;
       
        end
    end
end

figure,imagesc(Img_cut),colormap(jet)


% Cleaning image using opening and closing

SE = strel('diamond', 3);
Img_clean = imopen(Img_cut, SE); 
figure,imagesc(Img_clean),colormap(gray)
Img_clean = imclose(Img_clean,SE); 
figure,imagesc(Img_clean),colormap(gray)

timeElapsed_gmm = toc;

figure,
subplot(3,1,1) ,imagesc(A22),colormap(jet),colorbar,axis image,title('Segmented image using GMM');
subplot(3,1,2) ,imagesc(img_gmm),colormap(gray),colorbar,axis image, title('Binary Image'); 
subplot(3,1,3) ,imagesc(Img_clean),colormap(gray),colorbar,axis image,title('Final segmented image after cleaning');

% compute dice coefficient

[perc_error, dice_gmm, jacc_gmm, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_clean,mask,0);

%% Fuzzy-c means clustering

tic
k=3;
[centers,U] = fcm(double(Img(:)),k);
Output=reshape(U,[3, W,H]);
figure,imagesc(squeeze(Output(3,:,:))), colormap(gray), colorbar, axis image, axis off,title('Segmented image using fuzzy c-means');
img = squeeze(Output(3,:,:));

% Convert image to binary image thresholding

n = 5;
t = multithresh(img,n);
figure,
for i=1:n
    ot_results(:,:,i) = im2bw(img,t(i));
    
    subplot(3,2,i), imagesc(ot_results(:,:,i)),axis image,colormap(gray), title(strcat('Segmented mask threshold, t = ',num2str(t(i))));
    subplot(3,2,6), imagesc(Img_norm), axis image, colormap(gray), title('Ground truth mask');
end

% after observation t = 0.54 is best value

t = 0.54;
img_fuzzycmeans = im2bw(img,t);

if img_fuzzycmeans(280,130) == 0
    img_fuzzycmeans(:)=~img_fuzzycmeans;
end
figure,imagesc(img_fuzzycmeans ),colormap(gray),colorbar,axis off,axis image,title('thresholding result');


% Cut the tumor part of image

Img_cut = img_fuzzycmeans ;
for i= 1: W
    for j= 1: H
        if(i<200 || i>340) || (j<105 || j>220)
            Img_cut(i,j) = 0;
       
        end
    end
end

figure,imagesc(Img_cut),colormap(jet)


% Cleaning image using opening and closing

SE = strel('diamond', 3);
Img_clean = imopen(Img_cut, SE); 

figure,imagesc(Img_clean),colormap(gray)

SE = strel('diamond', 4);
Img_clean = imclose(Img_clean,SE);
figure,imagesc(Img_clean),colormap(gray)
timeElapsed_fuzzycmeans = toc;

figure,
subplot(3,1,1) ,imagesc(squeeze(Output(3,:,:))),colormap(jet),colorbar,axis image,title('Segmented image using Fuzzy-c means clustering');
subplot(3,1,2) ,imagesc(img_fuzzycmeans),colormap(gray),colorbar,axis image, title('Binary Image using thresholding'); 
subplot(3,1,3) ,imagesc(Img_clean),colormap(gray),colorbar,axis image,title('Final segmented image after cleaning');

% compute dice coefficient
[perc_error, dice_fuzzycmeans, jacc_fuzzycmeans, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_clean,mask,0);



%%

%% For necromatic tumor region

clc;
clear;

% Read image

Img = double(dicomread('T1CE_BrainTumor.dcm')); % Read an image
figure, imagesc(Img), colormap(gray), colorbar, axis off, axis image,title('Original Image');
[W, H]  = size(Img);

% Normalize image

Img_norm = (double(Img-min(Img(:)))/double(max(Img(:)-min(Img(:)))));
figure,imagesc(Img_norm),colormap(gray),colorbar,title('Normalized Image');

%%

% Compute ground truth using mask operation

figure, imagesc(Img_norm), colormap(gray), colorbar, axis off, axis image
mask =  roipoly();

figure, imagesc(mask), colormap(gray), colorbar, axis off, axis image, title('Ground truth');

%% k-means clustering

tic
figure,imagesc(Img_norm),colormap(gray)
nuClusters = 5;
[Indx, Cval] = kmeans(double(Img_norm(:)), nuClusters);
I_seg = reshape(Indx, size(Img_norm));
figure,imagesc(I_seg),colormap(gray),colorbar,axis image,title('Segmented image using k-means clustering');

% convert image to binary image using two tumor intensity values
intensity1 = I_seg(280,130);
intensity2 = I_seg(273,162);
img_kmeans = I_seg;
for i = 1:W
    for j =1:H
        if( img_kmeans(i,j) == intensity1 || img_kmeans(i,j) == intensity2 )
            img_kmeans(i,j) = 0;
        else
            img_kmeans(i, j) = 1;
        end
    end
end

figure, imagesc(img_kmeans), axis image, colormap(gray) , colorbar, title('Binary Image'); 

% Cut the necrotic tumor part of image

Img_cut = img_kmeans ;
for i= 1: W
    for j= 1: H
        if(i<265 || i>312) || (j<130 || j>185)
            Img_cut(i,j) = 0;
       
        end
    end
end

figure,imagesc(Img_cut),colormap(gray)


% Cleaning image using opening and closing

SE = strel('diamond', 2);
Img_clean = imopen(Img_cut, SE); 
figure,imagesc(Img_clean),colormap(gray)

SE = strel('diamond', 1);
Img_clean = imclose(Img_clean,SE); 
figure,imagesc(Img_clean),colormap(gray)
timeElapsed_kmeans = toc;

figure
subplot(3,1,1) ,imagesc(I_seg),colormap(jet),colorbar,axis image,title('Segmented image using k-means clustering');
subplot(3,1,2) ,imagesc(img_kmeans),colormap(gray),colorbar,axis image, title('Binary Image'); 
subplot(3,1,3) ,imagesc(Img_clean),colormap(gray),colorbar,axis image,title('Final segmented image after cleaning');

% Compute dice coefficient

[perc_error, dice_kmeans, jacc_kmeans, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_clean,mask,0);

%% Segmentation based on GMM

tic
X=double(reshape(Img,[W*H,1]));
[n,p] = size(X);
t=1:n;
k = 7; % number of Gaussians
options = statset('MaxIter',200); % Increase number of EM iterations
gmfit = fitgmdist(X,k,'CovType', 'full', 'SharedCov',true,'Options',options);
clusterX = cluster(gmfit,X);
h1 = gscatter(t,X,clusterX);
A22=reshape(clusterX,[W,H]);
figure,imagesc(A22), colormap(gray), colorbar, axis image, axis off,title('Segmented image using GMM');

% Convert image to binary image using two tumor intensity values

intensity1 = A22(280,130);
intensity2 = A22(273,162);
img_gmm = A22;
for i = 1:W
    for j =1:H
        if( img_gmm(i,j) == intensity1 || img_gmm(i,j) == intensity2)
            img_gmm(i,j) = 0;
        else
            img_gmm(i, j) = 1;
        end
    end
end

figure, imagesc(img_gmm), axis image, colormap(gray) ,colorbar, title('Binary Image'); 

% Cut the necrotic tumor part of image

Img_cut = img_gmm ;
for i= 1: W
    for j= 1: H
        if(i<265 || i>312) || (j<130 || j>185)
            Img_cut(i,j) = 0;
       
        end
    end
end

figure,imagesc(Img_cut),colormap(jet)


% Cleaning image using opening and closing

SE = strel('diamond', 3);
Img_clean = imopen(Img_cut, SE); 
figure,imagesc(Img_clean),colormap(gray)

SE = strel('diamond', 1);
Img_clean = imclose(Img_clean,SE); 
figure,imagesc(Img_clean),colormap(gray)

timeElapsed_gmm = toc;

figure,
subplot(3,1,1) ,imagesc(A22),colormap(jet),colorbar,axis image,title('Segmented image using GMM');
subplot(3,1,2) ,imagesc(img_gmm),colormap(gray),colorbar,axis image, title('Binary Image'); 
subplot(3,1,3) ,imagesc(Img_clean),colormap(gray),colorbar,axis image,title('Final segmented image after cleaning');

% compute dice coefficient

[perc_error, dice_gmm, jacc_gmm, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_clean,mask,0);

%% Fuzzy-c means clustering

tic
k=3;
[centers,U] = fcm(double(Img(:)),k);
Output=reshape(U,[3, W,H]);
figure,imagesc(squeeze(Output(3,:,:))), colormap(gray), colorbar, axis image, axis off,title('Segmented image using fuzzy c-means');
img = squeeze(Output(3,:,:));

n = 5;
t = multithresh(img,n);
figure,
for i=1:n
    ot_results(:,:,i) = im2bw(img,t(i));
    
    subplot(3,2,i), imagesc(ot_results(:,:,i)),axis image,colormap(gray), title(strcat('Segmented mask threshold, t = ',num2str(t(i))));
    subplot(3,2,6), imagesc(Img_norm), axis image, colormap(gray), title('Ground truth mask');
end

% after observation t = 0.54 is best value

t = 0.54;
img_fuzzycmeans = im2bw(img,t);

if img_fuzzycmeans(280,130) == 1
    img_fuzzycmeans(:)=~img_fuzzycmeans;
end
figure,imagesc(img_fuzzycmeans ),colormap(gray),colorbar,axis off,axis image,title('thresholding result');


% Cut the necrotic tumor part of image

Img_cut = img_fuzzycmeans ;
for i= 1: W
    for j= 1: H
        if(i<265 || i>312) || (j<130 || j>185)
            Img_cut(i,j) = 0;
       
        end
    end
end

figure,imagesc(Img_cut),colormap(gray)


% Cleaning image using opening and closing

SE = strel('diamond', 3);
Img_clean = imopen(Img_cut, SE); 

figure,imagesc(Img_clean),colormap(gray)

SE = strel('diamond', 1);
Img_clean = imclose(Img_clean,SE);
figure,imagesc(Img_clean),colormap(gray)
timeElapsed_fuzzycmeans = toc;

figure,
subplot(3,1,1) ,imagesc(squeeze(Output(3,:,:))),colormap(jet),colorbar,axis image,title('Segmented image using Fuzzy-c means clustering');
subplot(3,1,2) ,imagesc(img_fuzzycmeans),colormap(gray),colorbar,axis image, title('Binary Image using thresholding'); 
subplot(3,1,3) ,imagesc(Img_clean),colormap(gray),colorbar,axis image,title('Final segmented image after cleaning');

% compute dice coefficient
[perc_error, dice_fuzzycmeans, jacc_fuzzycmeans, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_clean,mask,0);