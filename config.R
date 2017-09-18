#################################
# directories
#################################
dir_metadata <- "00_metadata"
dir_raw <- "00_rawdata"
dir_data <- "01_data"
#dir_scores <- "02_scores"
dir_performance <- "02_performance"
### big files: locally stored in sergi's computer
# string database
dir_string <- "~/all/devel/datasets/bioinfo/databases/string/10"
# regularised laplacian kernels
dir_kernel <- "~/all/devel/big/diffusion/gsk/"

#################################
# dataset and database
#################################
file_alzh <- paste0(dir_raw, "/ben_15092017_ot_ad.txt")
# params network
params_string <- list(
  version = "10",
  species = 9606, 
  score_threshold = 400, 
  input_directory = dir_string
)
# graph alzh
graph_alzh <- paste0(dir_data, "/graph_alzh.RData")

#################################
# dataset and database
#################################
list_methods <- c("raw", "gm", "mc", "z")
