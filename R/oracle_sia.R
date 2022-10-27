library(rjson)
library(RJDBC)



jdbcDriver = JDBC("oracle.jdbc.OracleDriver", classPath = "C:/app/client/isis.santos/product/12.2.0/client_1/jdbc/lib/ojdbc8.jar")

###Exemplo para RJPO1DR
esquemapd <- "RJPO1DR.saude.gov"
servidorpd <- "exaccdfdr-scan.saude.gov"


baseodbc <- "jdbc:oracle:thin:@//"

pd_ender <- paste0(baseodbc,servidorpd,":1521/",esquemapd)
con_pd  <-  dbConnect(jdbcDriver, pd_ender,Sys.getenv("usrjp"),Sys.getenv("senharjp"))


procexe <- dbGetQuery(con_pd,'select sum(NU_PA_QTDAPR) FROM sia.tb_pa WHERE ( CO_PA_PROC_ID = 0301010072 AND CO_PA_CMP  = 202106)')

saveRDS(cnesvalidos,"dados/2022-09-19e20-cnes_validos.rds")

tabs_rjp <- dbGetTables(con_pd)





#http://landpage-h.cgu.gov.br/dadosabertos/index.php?url=https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/CNES/cnes_estabelecimentos.zip
#ftp://ftp.datasus.gov.br/cnes/BASE_DE_DADOS_CNES_202208.ZIP

apisaude <- "https://apidadosabertos.saude.gov.br/cnes/estabelecimentos?limit=20&offset="


lepgapi <- function(pg){  t <- rjson::fromJSON(file=paste0(apisaude,pg)) }

cnes_api <- rbindlist(lapply(0:25000,lepgapi))

#CNES_SNP
cnes_val_t <- dbGetQuery(con_pd,'select * from CNES_SNP.TB_CNES_VALIDOS')
