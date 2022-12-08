% Assignment - 4

% Ques - 1

% Read image

Img = double(dicomread('BrainTumor_FLAIR'));
gt_mask = double(dicomread('TumorMask'));

% Normalization
Img_norm = (double(Img-min(Img(:)))/double(max(Img(:)-min(Img(:)))));

figure,
subplot(1,3,1),imagesc(Img),colormap(gray),colorbar,axis off,axis image,title('Input Image');
subplot(1,3,2),imagesc(Img_norm),colormap(gray),colorbar,axis off,axis image,title('Normalized Image');
subplot(1,3,3),imagesc(gt_mask),colormap(gray),colorbar,axis off,axis image,title('Ground truth mask');

%%

% Otsu thresholding

n = 9;
t = multithresh(Img_norm,n);
figure,
for i=1:n
    ot_results(:,:,i) = im2bw(Img_norm,t(i));
    
    subplot(5,2,i), imagesc(ot_results(:,:,i)),axis image,colormap(gray), title(strcat('Segmented mask threshold, t = ',num2str(t(i))));
    subplot(5,2,10), imagesc(gt_mask), axis image, colormap(gray), title('Ground truth mask');
end

% After comparing images we conclude that t = 0.4783  gives best result

t = 0.4783;
ot_results = im2bw(Img_norm,t);
figure,imagesc(ot_results ),colormap(gray),colorbar,axis off,axis image,title('thresholding result');

%Image cleaning
SE = strel('line',5,1);
img1 = imopen(ot_results,SE);  %using opening
Img_otsu = imfill(img1,'holes');   %to fill holes

%compute accuracy

[perc_error, dice, jacc, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_otsu,gt_mask,0);

% compute area of segmented tumor
[r1,c1] = size(Img_otsu);
c = 0;
for i = 1:r1
    for j =1:c1
        if(Img_otsu(i,j)==1)
            c = c+1;
        end
    end
end
area_tumor_otsu = c*0.0055;

figure, 
subplot(1,2,1), imagesc(ot_results), colormap(gray), colorbar, axis off, axis image, title('Segmented mask using Otsu thresholding');
subplot(1,2,2), imagesc(Img_otsu), colormap(gray), colorbar, axis off, axis image, title('After cleaning');
%%

% Segmentation using Region Growing

figure, imagesc(Img), axis image, colormap(gray) , title('Input Image'); 

[y,x] = ginput(1);
x1 = round(x);
y1 = round(y);

result = regiongrowing(Img,x1,y1,120);

title('Result of segmntation (mask)');
hold on;contour(result,'r','linewidth',2);
figure,imagesc(result),colormap(gray),colorbar;

%Image cleaning 
SE = strel('diamond',2);
img2 = imopen(result,SE); %using opening
Img_rg = imfill(img2,'holes'); %to fill holes

%compute accuracy
[perc_error, dice, jacc, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_rg,gt_mask,0);

% compute area of segmented tumor
[r1,c1] = size(Img_rg);
c = 0;
for i = 1:r1
    for j =1:c1
        if(Img_rg(i,j)==1)
            c = c+1;
        end
    end
end
area_tumor_rg = c*0.0055;

figure, 
subplot(1,2,1), imagesc(result), colormap(gray), colorbar, axis off, axis image, title('Segmented mask using region growing');
subplot(1,2,2), imagesc(Img_rg), colormap(gray), colorbar, axis off, axis image, title('After cleaning');

%%

% Segmentation using active cotouring

A = active_contour_seg(Img_norm,gt_mask,200);
figure,imagesc(A),colormap(gray),colorbar,axis image,title('Segmented mask using active cotouring');

%compute accuracy
[perc_error, dice, jacc, truePos ,trueNeg, falsPos, falseNeg] = displayresults(A,gt_mask,0);

% compute area of segmented tumor
[r1,c1] = size(A);
c = 0;
for i = 1:r1
    for j =1:c1
        if(A(i,j)==1)
            c = c+1;
        end
    end
end
area_tumor_ac = c*0.0055;

%%

% Ques - 2

% Segmentation using active cotouring

% First contour

A_ac_1 = active_contour_seg(Img_norm,gt_mask,200);   
figure,imagesc(A_ac_1),colormap(gray),title('Segmented mask using active contour,first contour');   
%compute accuracy  
[perc_error, dice_ac_1 , jacc_ac_1 , truePos ,trueNeg, falsPos, falseNeg] = displayresults(A_ac_1,gt_mask,0);

% Second contour

A_ac_2 = active_contour_seg(Img_norm,gt_mask,200);   
figure,imagesc(A_ac_2),colormap(gray),title('Segmented mask using active contouring,second contour');   
%compute accuracy  
[perc_error, dice_ac_2 , jacc_ac_2 , truePos ,trueNeg, falsPos, falseNeg] = displayresults(A_ac_2,gt_mask,0);

% Third contour

A_ac_3 = active_contour_seg(Img_norm,gt_mask,200);   
figure,imagesc(A_ac_3),colormap(gray),title('Segmented mask using active contouring,third contour');   
%compute accuracy  
[perc_error, dice_ac_3 , jacc_ac_3 , truePos ,trueNeg, falsPos, falseNeg] = displayresults(A_ac_3,gt_mask,0);


%%

% Segmentation using Region Growing for 3 seed points

% First seed point

 figure, imagesc(Img), axis image, colormap(gray) , title('Input Image'); 
 [y,x] = ginput(1);
 x1 = round(x);
 y1 = round(y);
 result_rg_1 = regiongrowing(Img,x1,y1,120);
 title('Result of segmntation (mask)');
 hold on;contour(result_rg_1,'r','linewidth',2);
 figure,imagesc(result_rg_1),colormap(gray),colorbar;
 
 %Image cleaning
 SE = strel('diamond',2);
 img2 = imopen(result_rg_1,SE);  %using opening
 Img_rg_1 = imfill(img2,'holes');  %to fill holes
    
 figure, 
 subplot(1,2,1),imagesc(result_rg_1), colormap(gray), colorbar, axis off, axis image, title('Segmented mask using active contouring,first seed point');
 subplot(1,2,2),imagesc(Img_rg_1), colormap(gray), colorbar, axis off, axis image, title('After cleaning');
    
 %compute accuracy
    
 [perc_error, dice_rg_1, jacc_rg_1, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_rg_1,gt_mask,0);  
 
 % Second seed point
 
 figure, imagesc(Img), axis image, colormap(gray) , title('Input Image'); 
 [y,x] = ginput(1);
 x1 = round(x);
 y1 = round(y);
 result_rg_2 = regiongrowing(Img,x1,y1,120);
 title('Result of segmntation (mask)');
 hold on;contour(result_rg_2,'r','linewidth',2);
 figure,imagesc(result_rg_2),colormap(gray),colorbar;
 
 %Image cleaning
 SE = strel('diamond',2);
 img2 = imopen(result_rg_2,SE);  %using opening
 Img_rg_2 = imfill(img2,'holes');  %to fill holes
    
 figure, 
 subplot(1,2,1),imagesc(result_rg_2), colormap(gray), colorbar, axis off, axis image, title('Segmented mask using active contouring, second seed point');
 subplot(1,2,2),imagesc(Img_rg_2), colormap(gray), colorbar, axis off, axis image, title('After cleaning');
    
 %compute accuracy
    
 [perc_error, dice_rg_2, jacc_rg_2, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_rg_2,gt_mask,0);

 % Third seed point
 
 figure, imagesc(Img), axis image, colormap(gray) , title('Input Image'); 
 [y,x] = ginput(1);
 x1 = round(x);
 y1 = round(y);
 result_rg_3 = regiongrowing(Img,x1,y1,120);
 title('Result of segmntation (mask)');
 hold on;contour(result_rg_3,'r','linewidth',2);
 figure,imagesc(result_rg_3),colormap(gray),colorbar;
 
 %Image cleaning
 SE = strel('diamond',2);
 img2 = imopen(result_rg_3,SE);  %using opening
 Img_rg_3 = imfill(img2,'holes');  %to fill holes
    
 figure, 
 subplot(1,2,1),imagesc(result_rg_3), colormap(gray), colorbar, axis off, axis image, title('Segmented mask using active contouring,third seed point');
 subplot(1,2,2),imagesc(Img_rg_3), colormap(gray), colorbar, axis off, axis image, title('After cleaning');
    
 %compute accuracy
    
 [perc_error, dice_rg_3, jacc_rg_3, truePos ,trueNeg, falsPos, falseNeg] = displayresults(Img_rg_3,gt_mask,0);

%%

% Ques - 3

% Segmentation using Region Growing

% Lets find seed points using intensity 

M = max(Img(:));
mean1 = mean(Img(:));
std1 = std(Img(:));
[W,H] = size(Img);

% find image point with intensity max-std

intensity = round(M-std1);
error = 25;
found = 0;
x=0;
y=0;
for i=1:W
    for j=1:H
        if( ( Img(i,j) > (intensity-error) ) && ( Img(i,j) < (intensity+error)));
            x = i;
            y = j;
            found = 1;
            break;
        end
    end
     if(found==1)
         break;
     end
end
    

% Segmentation using Region Growing

x1 = round(x);
y1 = round(y);

result = regiongrowing(Img,x1,y1,120);

title('Result of segmntation (mask)');
hold on;contour(result,'r','linewidth',2);
figure,imagesc(result),colormap(gray),colorbar, title('Segmented mask using region growing');
figure, imagesc(gt_mask),colormap(gray),colorbar, title('Ground truth');

%%

% Segmentation using Active contouring

intensity = round(M-2*std1);
img2 = Img;
for i=1:W
    for j=1:H
        if( ( Img(i,j) > intensity) && ( Img(i,j) < M));
            img2(i,j) = 1;
        else
            img2(i,j) = 0;
        end
     end
end
figure, imagesc(img2),colormap(gray), colorbar, axis off, axis image, title('mask');

BW = activecontour(Img,img2,80);
figure, imagesc(BW), colormap(gray), colorbar, axis off, axis image, title('Segmented mask using active contouring');
figure, imagesc(gt_mask),colormap(gray),colorbar, title('Ground truth');
