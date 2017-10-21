#################################
# dataset and database
#################################

### big files: locally stored in sergi's computer
# string database
dir_string <- "~/all/devel/datasets/bioinfo/databases/string/10"
# regularised laplacian kernels
dir_kernel <- "~/all/devel/big/diffusion/gsk/"

# raw data
dir_metadata <- "00_metadata"
dir_raw <- "00_rawdata"
file_alzh <- paste0(dir_raw, "/ben_15092017_ot_ad.txt")
file_4diseases <- paste0(dir_raw, "/four_disease_associations_ot_public_20171005.txt")

# params network
params_string <- list(
  version = "10",
  species = 9606, 
  score_threshold = 400, 
  input_directory = dir_string
)

#################################
# directories
#################################
# Section 5.0 5.1 gdocs
dir_data <- "01_data"
dir_performance <- "02_performance"
# graph alzh
graph_alzh <- paste0(dir_data, "/graph_alzh.RData")
# Section 5.2 gdocs
dir_data3 <- "03_data"
graph_4disease <- paste0(dir_data3, "/graph_4disease.RData")
file_descriptive <- paste0(dir_data3, "/descriptive_diseases.csv")
file_kernel3 <- paste0(dir_kernel, "/Net4_weightsIn01.RData")
dir_performance3 <- "03_performance"
#dir_scores <- "02_scores"
# Analysis of the topology
dir_topology <- "04_topology"

#################################
# Other params
#################################
list_methods <- c("raw", "gm", "mc", "z")
cosnet_cost <- 1e-4
wsld_d <- 2
knn_k <- 3
colname_symbol <- "target.id"
