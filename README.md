# Local-Feature-Matching-using-Harris-Corner-Detector-and-SIFT-Descriptor-

This repo contains a fully developed code for Local Feature Matching using Harris Corner Detector and SIFT Descriptor 

This project was developed for Computer Vision class Spring 2019.

## Table of content
- [Dataset](#Dataset)
- [Harris Corner](#Harris-Corner)
  3. [Results](#Results)
  1. [Algorithm](#Algorithm)
- [SIFT Descriptor](#SIFT-Descriptor)
    - [Results](#Results)
    - [Algorithm](#Algorithm)
- [Feature Matching](#Feature-Matching)
    - [Results](#Results)
    - [Algorithm](#Algorithm)

## Dataset
The dataset is simply 6 images that can be considered as 3 pairs of images as following:
1. Notre Dame de Paris
2. Mount Rushmore
3. Gaudi's Episcopal Palace

## Harris Corner

### Results
Hybrid images can be constructed by using 2 images with respectable shapes and using a low
pass filter on one image and a high pass image on the other one.

![](https://github.com/ahmedwael19/Local-Feature-Matching-using-Harris-Corner-Detector-and-SIFT-Descriptor-/blob/master/report/1_1_01.jpg)
![](https://github.com/ahmedwael19/Local-Feature-Matching-using-Harris-Corner-Detector-and-SIFT-Descriptor-/blob/master/report/1_2_01.jpg)
![](https://github.com/ahmedwael19/Local-Feature-Matching-using-Harris-Corner-Detector-and-SIFT-Descriptor-/blob/master/report/2_1_01.jpg)
![](https://github.com/ahmedwael19/Local-Feature-Matching-using-Harris-Corner-Detector-and-SIFT-Descriptor-/blob/master/report/2_2_01.jpg)
![](https://github.com/ahmedwael19/Local-Feature-Matching-using-Harris-Corner-Detector-and-SIFT-Descriptor-/blob/master/report/3_2_002.jpg)
![](https://github.com/ahmedwael19/Local-Feature-Matching-using-Harris-Corner-Detector-and-SIFT-Descriptor-/blob/master/report/3_1_002.jpg)

### Algorithm 
You can find the algorithm expalined thoroughly in the report.

### FFT vs time vs built-in
The following figure compares the output of the built-in MATLAB function with the implemented
time-based function and with the FFT-based function.
![](https://github.com/ahmedwael19/Image-Filtering-and-Hybrid-Images-/blob/master/Report/images/Image%20Filtering/final_compare.jpg)
## Hybrid Image
### Results
Hybrid images can be constructed by using 2 images with respectable shapes and using a low
pass filter on one image and a high pass image on the other one.

![](https://github.com/ahmedwael19/Image-Filtering-and-Hybrid-Images-/blob/master/hybrid_image.jpg)
![](https://github.com/ahmedwael19/Image-Filtering-and-Hybrid-Images-/blob/master/hybrid_image_scales.jpg)

### Algorithm 
1. Use the large blur filter on the first image to get the low frequencies of the first
image.
2. Use the large blur filter on the second image and subtract it from the second image to
get the high frequencies.
3. Add the two processed images together to get the hybrid image.
