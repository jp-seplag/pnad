###
 # install.packages("PNADcIBGE")
 # install.packages("survey")

# pacotes
library(survey)
library(PNADcIBGE)
library(data.table)
library(glue)

# Defininda a pasta de trabalho
pasta <- "S:/NCD/Projetos 2023/PNAD/rds"
setwd(pasta)

# Intervalo de tempo que queremos os dados
anos <- c(2016:2023)
trimestres <- c(1:4)

# As variáveis desejadas devem estar no vetor
variaveis_selecionadas <- c("V1029", "UF", "V2007", "V2010","VD4019","VD4020","VD4023")


# Loop que itera entre ano e trimestre, baixando os dados com a biblioteca do IBGE 
# e salvando um objeto survey em um arquivo rds.
for (ano in anos) {
  for (tri in trimestres) {
    if (ano == 2020 & tri > 2) { break; }
    print(glue("O ano é {ano}, o tri é {tri}."))
    dadosPNADc <- get_pnadc(year = ano, quarter = tri, vars = variaveis_selecionadas)
     nome = glue("dadosPNADc_{ano}{tri}.RDS")
     saveRDS(dadosPNADc, file = nome)
  }}
