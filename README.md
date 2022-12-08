# Biomedical Image processing

# Filtering

Filters are used to remove or suppress noise in the image while preserving the detail and information of the image. Noise can be Salt & paper noise , Gaussian noise etc. Types of filters include mean filter, median filter , Gaussian Filter etc.

## Functions used

```
imnoise()
imfilter()
imgaussfilt(A, sigma)
```

# Segmentation
Image segmentation means partitioning the input image, by clustering pixel values of the image. It is mainly used for identifying various surfaces or living or non-living objects from an image.

## Algorithms used

* Otsu thresholding
* Active contouring
* Region growing
* k-means clustering
* Gaussian mixture model
* Fuzzy c clustering
