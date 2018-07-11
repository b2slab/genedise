#################################
# dataset and database
#################################

### big files: locally stored in UPC's servers
# string database
dir_string <- "~/all/devel/datasets/bioinfo/databases/string/10"
# regularised laplacian kernels
dir_kernel <- "~/all/devel/big/diffusion/gsk/"

# reproducibility
dir_metadata <- "00_metadata"

# abbreviations
file_abbrev <- "60_abbreviations.R"
# color palettes
# see http://tools.medialab.sciences-po.fr/iwanthue/
file_palette25 <- "60_palette25.txt"

# raw data
dir_raw <- "00_rawdata"
file_alldiseases <- paste0(dir_raw, "/17.06_ot_commondisease_associations_filtered.csv")
file_complexes <- paste0(dir_raw, "/OT-000-20-2_out.rda")

# abbreviations (plots, tables, etc)
file_abbrev <- "60_abbreviations.R"

# Thresholds to generate the dataset
# (Ben. Subject: Genetics OT score, 2 nov)
# The OT genetics threshold score for distinguishing positives 
# and negatives would be 0.160.
col_genetic <- "association_score.datatypes.genetic_association"
threshold_genetic <- .160
# very important: threshold for diseases on both genetically associated 
# and drug genes
threshold_ngenes <- 50

# Parameters to generate network
params_string <- list(
  version = "10",
  species = 9606, 
  score_threshold = 400, 
  input_directory = dir_string
)

#################################
# output directories
#################################

# data for the runs
dir_data <- "30_data"

# performance metrics
dir_performance <- "32_performance"
dir_models <- "33_models"

# network (this script reuses the one in 20_data)
graph_alldiseases <- "20_data/graph_alldiseases.RData"

# big network files
file_kernel <- paste0(dir_kernel, "/Net4_weightsIn01.RData")
file_mashup_features <- paste0(dir_kernel, "/string10_features.csv")

# Analysis of the topology and the positives
dir_topology <- "31_topology"
dir_complexes <- "33_complexes"
dir_boxplots <- "33_boxplots"
dir_contrasts <- "33_contrasts"
file_palette25 <- "60_palette25.txt"

# MashUp features
file_mashup_names <- "05_mashup/node_names.txt"

# Preprocessed input RData file
file_input <- paste0(dir_data, "/tables_input.RData")

#################################
# Other params
#################################

# regularised laplacian kernel
kernel_normalised <- FALSE

# repeated k-fold cross validation
k_cv <- 3
times_cv <- 25
list_cv_schemes <- c("classic", "block", "representative")

# diffustats methods
list_methods <- c("raw", "gm", "mc", "z")
mc_nperm <- 1e3

# cosnet cost parameter
cosnet_cost <- 1e-4

# RANKS parameters
wsld_d <- 2
knn_k <- 3

# bagged svm and ML (svm, rf) parameters 
# can be found in their function definitions 
# in 22_performance.Rmd

colname_symbol <- "target.id"

#################################
# Hostnames
#################################

# get the host name (linux)
# our machines at UPC are "eko" and "sun"
host <- Sys.info()["nodename"]
print(paste("You are running the CV on the host:", host))

# options for each machine
# - number of threads to use
# - cv schemes to run (each cv produces its own file, 
#     outputs can be combined later between machines). 
#     Order matters!
#     
# If you want to add your own machines, you can do so by 
# appending more options with their hostnames
if (host == "eko") {
  nslaves <- 11
  cv_jobs <- list_cv_schemes[3]
} else if (host == "sun") {
  nslaves <- 32
  cv_jobs <- list_cv_schemes[1:3]
} else {
  print("This host is unknown. Using default options in 30_config.R")
  # if the host is unknown, use all the cores and
  # run all the validation schemes
  nslaves <- parallel::detectCores()
  cv_jobs <- list_cv_schemes
}
