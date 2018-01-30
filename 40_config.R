#################################
# dataset and database
#################################

### big files: locally stored in UPC's servers
# regularised laplacian kernels
dir_kernel <- "~/all/devel/big/diffusion/gsk/"

# reproducibility
dir_metadata <- "00_metadata"

# raw data
dir_raw <- "00_rawdata"
file_alldiseases <- paste0(dir_raw, "/17.06_ot_commondisease_associations_filtered.csv")
file_complexes <- paste0(dir_raw, "/OT-000-20-2_out.rda")
file_omnipath <- paste0(dir_raw, "/omnipath.rda")

# Thresholds to generate the dataset
# this has already been computed for the STRING database
col_genetic <- "association_score.datatypes.genetic_association"
threshold_genetic <- .160
# as the number of genes in the new network does not greatly vary
# we are going to use the same diseases as for STRING
file_list_diseases <- "20_data/diseases_over_50_genes.txt"

#################################
# output directories
#################################

# data for the runs
dir_data <- "40_data"

# performance metrics
dir_performance <- "42_performance"
dir_models <- "43_models"

# mashup 
dir_mashup <- "45_mashup"

# network
graph_alldiseases <- paste0(dir_data, "/graph_alldiseases.RData")

# big network files
file_kernel <- paste0(dir_kernel, "/omnipath.RData")
file_mashup_features <- paste0(dir_kernel, "/omnipath_features.csv")

# Analysis of the topology and the positives
dir_complexes <- "43_complexes"
dir_boxplots <- "43_boxplots"
dir_contrasts <- "43_contrasts"
dir_topology <- "44_topology"

# MashUp features
file_mashup_names <- "45_mashup/node_names.txt"

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
