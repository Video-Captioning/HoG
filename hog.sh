#!/usr/bin/env bash
# ------------------------------------------
#  Produce Histograms of Oriented Gradients
# ------------------------------------------
# 
# INPUT:
#   image_path
#   cells
#   bins
#
# Implicit input: 
#   partitioned data resides in four files, named:
#     test_pos.csv, test_neg.csv, train_pos.csv, and train_neg.csv
#   images files are available at the image_path, matching the names in the partitioned data files
#
# Call hog.sh from within the subdirectory that contains partitioned data, i.e.,
#   if the project is in:
#     PROJECTPATH
#
#   and the data have been partitioned using:
#     ./partition_data_two_class.sh KEYWORD CLASS_LABELS TRAINING_FRACTION
#
#   then the clumps of data will reside at a location determined
#   by the keyword and the training fraction, '0.60':
#     PROJECTPATH/KEYWORDTRAINING_FRACTION
#
#
# PROCESSING:
# - Verify that the correct number of parameters are available
#     + Issue usage instructions, if needed
# - Describe the parameters
# - Create an appropriately-named subdirectory if needed
# - Produce Histograms of Oriented Gradients
#
# OUTPUT:
#   Save the histograms for each of the four clumps of data in a subdirectory:
#     training_pos.txt      testing_pos.txt
#     training_neg.txt      testing_neg.txt

# --- Check command-line arguments, and give usage instructions, if warranted
if (( $# != 3 ))
then
  echo 
  echo "Usage:"
  echo "  sh $0 image_path cells bins"
  echo "Example:"
  echo "  sh $0 ../data/2_images/ 4 5"
  exit 1
fi

# --- Describe what is about to happen
echo -----------------------------------------
echo 
image_path=$1
cells=$2
bins=$3

# --- The results will be stored in a subdirectory having a name
# that is a concatenation of the number of cells and bins. If the
# subdirectory already exists, use it; otherwise, create it.
destination=cells"$cells"_bins"$bins"
echo "$destination"
[ -d $destination ]&&echo "Using existing subdirectory" $destination||(echo "Creating subdirectory " $destination; mkdir $destination)

# --- Produce Histograms of Oriented Gradients for each of the four clumps of data:
../HoG.R -d $image_path --cells=$cells --bins=$bins -o ./$destination/train_pos.csv ./training_pos.txt
../HoG.R -d $image_path --cells=$cells --bins=$bins -o ./$destination/train_neg.csv ./training_neg.txt
../HoG.R -d $image_path --cells=$cells --bins=$bins -o ./$destination/test_pos.csv  ./testing_pos.txt
../HoG.R -d $image_path --cells=$cells --bins=$bins -o ./$destination/test_neg.csv  ./testing_neg.txt
