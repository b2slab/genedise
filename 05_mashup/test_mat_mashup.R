library(STRINGdb)
library(igraph)
library(ggplot2)
library(diffuStats)

source("config.R")

colname_symbol <- "gene_symbol"

load("03_data/graph_4disease.RData")

# load the whole stringdb
string_db <- do.call(
  STRINGdb$new, params_string
)
string_g <- string_db$get_graph()
string_g

# pick one filter (Net4)
edge.filters <- list(
  Net1 = "combined_score < 400 | experiments < 1", 
  Net2 = "experiments < 600", 
  Net3 = "experiments < 400 & database < 400", 
  Net4 = "combined_score < 700 | (experiments < 1 & database < 1)", 
  Net5 = "combined_score < 700 | (experiments < 1 & database < 1 & textmining < 900)", 
  Net6 = "database < 400" 
)$Net4

# network
g <- delete_edges(
  string_g, 
  E(string_g)[eval(parse(text = edge.filters))]
) %>% largest_cc

# data frames with node id + vector with names
df_edges <- get.edges(g, es = E(g)) %>% as.data.frame

names_nodes <- V(g)$name
writeLines(names_nodes, con = "node_names.txt")

list.df <- lapply(
  c("experiments", "database"), 
  function(atr) {
    g_attr <- get.edge.attribute(g, atr)
    df_edges$V3 <- g_attr/max(g_attr)
    
    write.table(
      df_edges, 
      file = paste0("test_mashup_", atr, ".txt"), 
      row.names = FALSE, 
      col.names = FALSE, 
      sep = "\t"
    )
    
    df_edges
  }
)
