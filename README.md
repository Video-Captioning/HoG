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
|---------------:|:---------|
|frame_03091.png |          |
|frame_03121.png |          |
|frame_03151.png | _disc_   |
|frame_03181.png |          |
|frame_03211.png | _disc_   |
|frame_03241.png |          |
|...| |

## Data Partitioning
Partition the labeled data into two sets: Some portion of the data for *training* and the rest for *testing*. For example: 80% training

```{bash}
cd path-to-project
#                                keyword      datafile     training fraction
sh ./partition_data_two_class.sh  disc    labeled_data.txt 0.80
```

After partitioning the data, extract HoG (Histograms of Oriented Gradients) features using various numbers of cells and bins:

```{bash}
# --- Round a number, N, to D digits
function round() 
{
  number=$1; digits=$2
  echo $(printf %.$2f $(echo "scale="$digits";(((10^"$digits")*"$number")+0.5)/(10^"$digits")" | bc))
}

hogexec=/path/to/HoG.R
image_path=/path/to/image/files
CELLS=7
BINS=8
FRACTION=0.80

# Note that the group name is a combination of the keyword and training fraction ( i.e., disc80 )
destination="$DATASET"$(printf $KEYWORD%s $(echo "$(round 100*$FRACTION 0)" | bc))
group="$PROJECTPATH"$dataset$destination
subgroup=$group/cells"$CELLS"_bins"$BINS"
for file in training_pos training_neg testing_pos testing_neg; do
  $hogexec \
    --data_path=$image_path --cells=$CELLS --bins=$BINS \
    --output=$subgroup/"$file".csv --input=$group/"$file".txt
done        
```
