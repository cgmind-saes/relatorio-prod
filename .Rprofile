library(utils)
#automatizado baseado em requ.R
pacotes <-  gsub(")","",read.delim("requ.R",sep = "(", header = F)[[2]])

pacotesnovos <- pacotes[ !( pacotes %in% utils::installed.packages()[ , "Package" ] ) ]
if( length( pacotesnovos ) ) utils::install.packages( pacotesnovos )


sapply(pacotes, function (x) {
  suppressPackageStartupMessages(require(x[[1]],character.only = T))}) 
rm(pacotes)

