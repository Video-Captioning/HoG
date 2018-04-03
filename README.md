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

# Example
Begin with a bunch of image files, some showing a frisbee and some not. For this example, we are classifying images based on whether they depict a disc or not. To use some other class label, simply substitute your own keyword for _disc_

## Class label file
Create a text file to hold class label information as follows:
|file name       |keyword(s)|
|----------------|----------|
|frame_03091.png |          |
|frame_03121.png |          |
|frame_03151.png | _disc_   |
|frame_03181.png |          |
|frame_03211.png | _disc_   |
|frame_03241.png |          |
...

## Data Partitioning
Partition the labeled data into two sets: Some portion of the data for *training* and the rest for *testing*. For example: 40% training

```{bash}
cd path-to-project
sh ./partition_data_two_class.sh _disc_ labeled_data.txt 0.40
```

After partitioning the data, extract HoG (Histograms of Oriented Gradients) features using various numbers of cells and bins:

```{bash}
# Note that the sub-directory name is a combination of the keyword (disc, in this case) and training fraction (40)
cd ./disc40
sh ../hog.sh ../data/2_images/ 4 9
sh ../hog.sh ../data/2_images/ 5 9
sh ../hog.sh ../data/2_images/ 6 9
sh ../hog.sh ../data/2_images/ 7 9
sh ../hog.sh ../data/2_images/ 8 9
sh ../hog.sh ../data/2_images/ 9 9
```

Re-Partition the data, this time using 60% for training:

```{bash, eval = FALSE, echo=TRUE}
cd path-to-project
sh ./partition_data_two_class.sh disc labeled_data.txt 0.60

Once again extract HoG features using various numbers of cells and bins:

```{bash, eval = FALSE, echo=TRUE}
# Note that the sub-directory name is a combination of the keyword (disc, in this case) and training fraction (60)
cd ./disc60
sh ../hog.sh ../data/2_images/ 4 9
sh ../hog.sh ../data/2_images/ 5 9
sh ../hog.sh ../data/2_images/ 6 9
sh ../hog.sh ../data/2_images/ 7 9
sh ../hog.sh ../data/2_images/ 8 9
sh ../hog.sh ../data/2_images/ 9 9
```
