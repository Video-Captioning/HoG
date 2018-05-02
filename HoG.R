#!/usr/bin/env Rscript --vanilla

# Reference https://cran.r-project.org/web/packages/OpenImageR/vignettes/The_OpenImageR_package.html
# Reference https://gist.github.com/louist87/9248952#file-image-findhogfeatures

cat(sprintf('--------\nHoG.R\n\n'))

require( purrr )
start_time <- Sys.time()  
 
# --- Configuration
cfg <- list()
cfg[[ 1 ]] <- list(
    c( '-c', '--cells' ), default = 3, type = 'integer' 
  , help = 'Number of grid cells [default %default]'
)
cfg[[ 2 ]] <- list(
    c( '-b', '--bins' ), default = 9
  , help = 'Number of histogram bins [default %default]'
)
cfg[[ 3 ]] <- list(
    c( '-o', '--output' ), default = '', type = 'character'
  , help = 'Output file'
)
cfg[[ 4 ]] <- list(
    c( '-t', '--transform' ), default = '', type = 'character'
  , help = 'Transformation to apply'
)
cfg[[ 5 ]] <- list(
    c( '-d', '--data_path' ), default = './data/2_images/', type = 'character'
  , help = 'Data Directory'
)
cfg[[ 6 ]] <- list(
    c( '-i', '--input' ), default = '', type = 'character'
  , help = 'Input file'
)
options <- lapply(
    cfg
  , function( f ) do.call( optparse::make_option, f )
)

# --- Constants
IMAGE_FILE_EXTENSIONS <- '.(png|jpeg|tiff|tif)$'
LIST_FILE_EXTENSIONS  <- '.(txt|tab|csv|tsv)$'

# --- Histogram of Oriented Gradients (HoG) function
# Length of resulting vector is bins x cells x cells
HoG <- function( f, bins=3, cells=6 ){
  #cat( sprintf( 'Creating HoG for %s\n', f ))
  if( file.exists( f )){
    input_image <- OpenImageR::readImage( f )  
    normalized_image <- input_image * 255
    hog <- OpenImageR::HOG( normalized_image, cells  = cells, orientations  =  bins )
    # Tick the progress bar forward 1 tick after each completed action
    pb$tick()
    data.frame( matrix( hog, nrow  =  1 ) )
  }
}

get_im     <- function( f ) OpenImageR::readImage( f )
find_edges <- function( im, method = 'Sobel' ) OpenImageR::edge_detection(
  im, method = method, conv_mode = 'same'
)
threshold  <- function( im, h=0.25 ) OpenImageR::image_thresholding( im, h )
downsample <- function( im, by=2.0 ) OpenImageR::down_sample_image(
  im, factor=by, gaussian_blur = TRUE, gauss_sigma = 1, range_gauss = 2
)
transformation_A <- function( f ){
  im <- downsample( find_edges( threshold( get_im( f ), 0.35 ),'Scharr' ), 5 )
  data.frame( matrix( im, nrow  =  1 ) )
}

# --- One file, or many?
is.directory <- function( f ){
  as.logical( file.info( f )[ 'isdir' ] )
}

show_configuration <- function( items ){
  cat( sprintf( '\n--- options ---\n'))
  print( t(t(opt)))
}

# -----------------------------------------------
#     M  A  I  N
# -----------------------------------------------  

# --- Get command line options and print help, if warranted.
parser <- optparse::OptionParser(usage = "%prog [options] file", option_list = options )

#tryCatch(
#    arguments <- optparse::parse_args( parser, positional_arguments = TRUE )
#  , error = function(e){
#      cat( sprintf( 'abrupt end'))
#      arguments <- 'none'
#    }
#)
  
arguments <- optparse::parse_args(parser, positional_arguments = TRUE )
opt <- arguments$options
##input_file <- arguments$args
input_file <- opt$input

show_configuration( opt )

if( any( grepl( tools::file_ext( input_file ), LIST_FILE_EXTENSIONS ) ) ){

  # Input might be a file containing a list of file names

  # Make a list of full file names
  # Read the list
  x <- strsplit( readLines( input_file ), " ")  #[[1]]
  # Keep the first element of each line and reduce to a vector
  x <- x %>% map_chr( 1 )
 
  # Prepend data directory
  input_file <- paste0( opt$data_path, x )
}

if( !length( input_file ) )
  stop( paste( 'No image files found in', input_file ) )
  
# --- We have one or more images to process, proceed!
N <- length( input_file )
cat( sprintf( 'Processing %d files...\n', N ) )

# --- Initialize progress bar
pb <- progress::progress_bar$new( total = N )

# --- Select a transformation
if( opt$transform %in% c( 'a', 'b' )){
  df <- do.call( rbind, lapply( input_file, transformation_A ))
  
} else {
  df <- do.call( rbind, lapply( input_file, function(f) HoG( f, opt$bins, opt$cells) ) )
}

# --- Show a sample of the results
rownames( df ) <- basename( input_file )
print( dim( df ))

if( nchar( opt$output ) > 0 ){
  cat(sprintf( 'Saving results to %s\n', opt$output ))
  write.table( df, file = opt$output, col.names = FALSE, sep = ',', quote = FALSE )
}

# --- Report how much time was used
end_time   <- Sys.time()  
time_spent <- end_time - start_time
cat( sprintf( 'Time elapsed: ' ))
print( time_spent )
cat(sprintf('--------\nEND HoG.R\n\n'))
