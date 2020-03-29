# reproducing generation of chembl complex data
# with newest UniProt mapping
library(DBI)
library(RSQLite)
library(UniProt.ws)
library(plyr)
library(dplyr)

originalfile.path <- "00_rawdata/OT-000-20-2_out.rda"

# original file in publication
load(originalfile.path)
tid2ens.orig <- a$all$genes.for.complexes

# download sqlite database and unzip
# http://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_23/
# here, we save it to /data/chembl/chembl_23/chembl_23_sqlite/chembl_23.db
chembl.path <- "/data/chembl/chembl_23/chembl_23_sqlite/chembl_23.db"

chembl <- dbConnect(RSQLite::SQLite(), chembl.path)

# complex data
query.P1 <- "select
               td.tid,
               td.pref_name,
               td.target_type,
               tc.component_id,
               cs.component_type,
               cs.description,
               cs.accession
               from target_dictionary td,
               target_components tc,
               component_sequences cs
               where td.tax_id = 9606 and
               td.target_type like 'PROTEIN COMPLEX%' and
               td.tid = tc.tid and
               tc.component_id = cs.component_id
               "

P1 <- dbGetQuery(chembl, query.P1)

# uniprot to ensembl
uniprot <- UniProt.ws(taxId = 9606)

columns <- c("ENSEMBL_PROTEIN", "UNIPROTKB")
# keys <- c("Q15125", "Q15125")
keys <- P1$accession
keytype <- "UNIPROTKB"

P3 <- AnnotationDbi::select(uniprot, keys, columns, keytype)
P3.unique <- unique(P3)

# before and after removing duplicate entries
dim(P3)
dim(P3.unique)

tab.repr <- select(P1, tid, accession) %>%
  dplyr::rename(UNIPROTKB = accession) %>%
  inner_join(P3.unique) %>%
  select(-UNIPROTKB) %>%
  unique %>%
  mutate_all(as.character) %>%
  na.omit

tab.orig <- plyr::ldply(
  tid2ens.orig, 
  function(x) data.frame(ENSEMBL_PROTEIN = as.character(x)),
  .id = "tid") %>%
  mutate_all(as.character) %>%
  na.omit

# newer table is larger
dim(tab.repr)
dim(tab.orig)

# mapping in list format, as used in publication
tid2ens.repr <- split(tab.repr$ENSEMBL_PROTEIN, tab.repr$tid) %>%
  lapply(unique)

# compare lengths: complexes are exactly the same
length(tid2ens.repr)
length(tid2ens.orig)
all(names(tid2ens.repr) == names(tid2ens.orig))

# in orig, not in new
anti_join(tab.orig, tab.repr)
# probably older IDs that have changed in recent ENSEMBL, e.g. 
# http://www.ensembl.org/Homo_sapiens/Transcript/Summary?p=ENSP00000480616

# in new, not in orig
anti_join(tab.repr, tab.orig)
# new working IDs, e.g.
# https://www.ensembl.org/Homo_sapiens/Transcript/ProteinSummary?t=ENST00000617316
