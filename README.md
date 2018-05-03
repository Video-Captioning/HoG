# object_detector ( a convenience wrapper for making Histograms of Oriented Gradients using HoG.R )
---
title: Object Detector
author: ~
date: '2018-04-03'
slug: ultimate-captioning-object-detector-HoG
categories: ["projects"]
tags: ["image processing"]
draft: no
header:
  caption:
  image:
  preview: yes
---

# Examples

## Partition a labeled dataset

```{bash, eval=FALSE}
# 80% of images for training; 20% for testing
#
#  eXtract HoG features ---+  +--- classify images
# partition the data ---+  |  |    +--- training fraction
#                       |  |  |    |       +--- keyword
#      the script       |  |  |    |       |          +--- class label file
#          |            |  |  |    |       |          |
# ____________________ __ __ __ _______ _______ ___________________
./object_detector.sh -p -x -c -f 0.80 -k disc -l labeled_3471.txt
```

## Extract HoG Features

```{bash, eval=FALSE}
# Initiate feature extraction
#
# number of cells (windows)---+     +--- number of bins
#    eXtract features ---+    |     |       +--- keyword
#      the script        |    |     |       |        +--- training fraction
#          |             |    |     |       |        |
# ____________________  __  ____  _____  _______  _______
./object_detector.sh  -x  -w 8  -b 15  -k disc  -f 0.80
```

## Classify Images Using Extracted Features

```{bash, eval=FALSE}
# For classification only:
./object_detector.sh  -c  -w 8  -b 15  -k disc  -f 0.80
```

## Initiate Feature Extraction and Classification Together
```{bash, eval=FALSE}
./object_detector.sh  -x -c  -w 8  -b 15  -k disc  -f 0.80
```
