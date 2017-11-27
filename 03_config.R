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
file_alldiseases <- paste0(dir_raw, "/17.06_ot_commondisease_associations_filtered.csv")

# Thresholds
# (Ben. Subject: Genetics OT score, 2 nov)
# The OT genetics threshold score for distinguishing positives 
# and negatives would be 0.160.
col_genetic <- "association_score.datatypes.genetic_association"
threshold_genetic <- .160
# very important: threshold for diseases on both genetically associated 
# and drug genes
threshold_ngenes <- 50

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
dir_data10 <- "10_data"

graph_4disease <- paste0(dir_data3, "/graph_4disease.RData")
file_descriptive <- paste0(dir_data3, "/descriptive_diseases.csv")
file_kernel3 <- paste0(dir_kernel, "/Net4_weightsIn01.RData")

graph_alldisease <- paste0(dir_data10, "/graph_alldisease.RData")

dir_performance3 <- "03_performance"
dir_performance12 <- "12_performance"
file_csv_perf12 <- paste0(dir_performance12, "/performance_sink.tsv")
#dir_scores <- "02_scores"
# Analysis of the topology
dir_topology <- "04_topology"

dir_topology11 <- "11_topology"

# MashUp features
file_mashup_names <- "05_mashup/node_names.txt"
file_mashup_features <- "05_mashup/string10_features.csv"

#################################
# Other params
#################################
list_methods <- c("raw", "gm", "mc", "z")
cosnet_cost <- 1e-4
wsld_d <- 2
knn_k <- 3
colname_symbol <- "target.id"
