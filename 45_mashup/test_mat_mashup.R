library(igraph)
library(ggplot2)
library(diffuStats)

config <- new.env(parent = globalenv())
source("40_config.R", local = config)

load(config$graph_alldiseases)

# data frames with node id + vector with names
# Also, add unitary weight to explicitly export the column
df_edges <- get.edges(g_filter, es = E(g_filter)) %>% 
  as.data.frame %>% 
  dplyr::mutate(V3 = 1.0)

names_nodes <- V(g_filter)$name
writeLines(names_nodes, con = paste0(config$dir_mashup, "/node_names.txt"))

write.table(
  df_edges, 
  file = paste0(config$dir_mashup, "/test_mashup_omnipath.txt"), 
  row.names = FALSE, 
  col.names = FALSE, 
  sep = "\t"
)
