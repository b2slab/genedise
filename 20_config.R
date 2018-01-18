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

# raw data
dir_raw <- "00_rawdata"
file_alldiseases <- paste0(dir_raw, "/17.06_ot_commondisease_associations_filtered.csv")
file_complexes <- paste0(dir_raw, "/OT-000-20-2_out.rda")

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
dir_data <- "20_data"

# performance metrics
dir_performance <- "22_performance"
dir_models <- "23_models"

# network
graph_alldiseases <- paste0(dir_data, "/graph_alldiseases.RData")

# big network files
file_kernel <- paste0(dir_kernel, "/Net4_weightsIn01.RData")
file_mashup_features <- paste0(dir_kernel, "/string10_features.csv")

# Analysis of the topology and the positives
dir_complexes <- "23_complexes"
dir_boxplots <- "23_boxplots"
dir_contrasts <- "23_contrasts"
dir_topology <- "24_topology"

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
  nslaves <- 12
  cv_jobs <- list_cv_schemes[3]
} else if (host == "sun") {
  nslaves <- 32
  cv_jobs <- list_cv_schemes[1:2]
} else {
  print("This host is unknown. Using default options in 20_config.R")
  # if the host is unknown, use all the cores and
  # run all the validation schemes
  nslaves <- parallel::detectCores()
  cv_jobs <- list_cv_schemes
}
