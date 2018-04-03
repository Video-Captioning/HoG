# Histograms of Oriented Gradients (HoG)
---
title: HoG
author: ~
date: '2018-04-03'
slug: ultimate-captioning-disc-detector-HoG
categories: ["projects"]
tags: ["image processing"]
draft: no
header:
  caption:
  image:
  preview: yes
---

## Data Source

3471 images, excerpted from 2015bsVriot.mp4, roughly 1 frame per second for about 1 hour.

## Data Preparation

Partition the labeled data into two sets: Some portion of the data for *training* and the rest for *testing*. For example: 40% training

```{bash, eval = FALSE, echo=TRUE}
cd /Users/Karl/Dropbox/Projects/Video-Captioning
sh ./partition_data_two_class.sh disc labeled_3471.txt 0.40

```

After partitioning the data, extract HoG (Histograms of Oriented Gradients) features using various numbers of cells and 9 bins:

```{bash, eval = FALSE, echo=TRUE}
cd ./disc40
~/Dropbox/Projects/Video-Captioning/disc40
sh ../hog.sh ../data/2_images/ 4 9
sh ../hog.sh ../data/2_images/ 5 9
sh ../hog.sh ../data/2_images/ 6 9
sh ../hog.sh ../data/2_images/ 7 9
sh ../hog.sh ../data/2_images/ 8 9
sh ../hog.sh ../data/2_images/ 9 9
```

Re-Partition the data, this time using 60% for training:

```{bash, eval = FALSE, echo=TRUE}
cd /Users/Karl/Dropbox/Projects/Video-Captioning
sh ./partition_data_two_class.sh disc labeled_3471.txt 0.60

Once again extract HoG features using various numbers of cells and 9 bins:

```{bash, eval = FALSE, echo=TRUE}
cd ./disc60
~/Dropbox/Projects/Video-Captioning/disc40
sh ../hog.sh ../data/2_images/ 4 9
sh ../hog.sh ../data/2_images/ 5 9
sh ../hog.sh ../data/2_images/ 6 9
sh ../hog.sh ../data/2_images/ 7 9
sh ../hog.sh ../data/2_images/ 8 9
sh ../hog.sh ../data/2_images/ 9 9
```

```{bash, eval = FALSE, echo=TRUE}
# R linear_SVM.R
microbenchmark( (results <- update( './disc40/cells4_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc40/cells5_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc40/cells6_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc40/cells7_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc40/cells8_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc40/cells9_bins9/' )), times=1L )

microbenchmark( (results <- update( './disc60/cells4_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc60/cells5_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc60/cells6_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc60/cells7_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc60/cells8_bins9/' )), times=1L )
microbenchmark( (results <- update( './disc60/cells9_bins9/' )), times=1L )

```
