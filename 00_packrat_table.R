# this function is a modified version of packrat::status 
# (packrat version 0.4.8.1)
# that exports the project packages as a formatted table
packrat_table <- function(project = NULL, lib.loc = libDir(project), 
                          quiet = FALSE) {
  project <- packrat:::getProjectDir(project)
  packrat:::stopIfNotPackified(project)
  projectDefault <- identical(project, ".")
  project <- normalizePath(project, winslash = "/", mustWork = TRUE)
  packratPackages <- packrat:::lockInfo(project, fatal = FALSE)
  if (length(packratPackages) == 0) {
    initArg <- if (projectDefault) 
      ""
    else deparse(project)
    cat("This directory does not appear to be using packrat.\n", 
        "Call packrat::init(", initArg, ") to initialize packrat.", 
        sep = "")
    return(invisible())
  }
  packratNames <- packrat:::getPackageElement(packratPackages, "name")
  packratVersions <- packrat:::getPackageElement(packratPackages, "version")
  packratSources <- packrat:::getPackageElement(packratPackages, "source")
  
  df.ans <- data.frame(
    "Number" = rank(packratNames), 
    "Package" = packratNames, 
    "Version" = packratVersions, 
    "Source" = packratSources
  )
  dplyr::arrange(df.ans, Package)
}

# write the summary in the metadata folder
tab.packrat <- packrat_table()
tex.packrat <- knitr::kable(
  tab.packrat, format = "latex", 
  longtable = TRUE, booktabs = TRUE)
writeLines(tex.packrat, con = "00_metadata/packrat_table.tex")
