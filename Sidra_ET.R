#install.packages("sidrar")
library(sidrar)
library(glue)

setwd("S:/NCD/Projetos 2023/PNAD")

## Abre a url com as informações da tabela 5436 (Descomentar)
#info_sidra(5436, wb=TRUE)

# Lê um arquivo com os nomes das UF
ufs <- read.csv2("uf_csv.csv")
# Os Trimestres que queremos os dados devem estar no vetor 
trimestres = c(
 "201202",	"201203",	"201204",	"201301",	"201302",	"201303",	"201304",	"201401",	"201402",	"201403",	"201404",	"201501",	"201502",	"201503",	"201504",	"201601",	"201602",	"201603",	"201604",	"201701",
               "201702",	"201703",	"201704",	"201801",	"201802",	"201803",	"201804",	"201901",	"201902",	"201903",	"201904",	"202001",	"202202",	"202203",	"202204",	"202301",	"202302"
)

# Loop que itera entre os trimestres e as UF, baixando os dados
# e salvando como um arquivo csv.
for (tri in trimestres) {
  print(glue("O trimestre é {tri}."))
  for (uf in ufs[,2]) {
    
    print(glue("A UF é {uf}."))
    # Exraindo os dados com o pacote sidrar do IBGE
    
    # Rendimento por sexo
    sexo <- get_sidra(x = 5436,
                      variable = 5933,
                      period = tri,
                      geo = "State",
                      geo.filter = as.integer(uf))
    nome = glue("dados/sidra/sexo/{tri}{uf}_sexo.csv")
    write.csv2(sexo, file = nome)
    
    
    # Rendimento por raça
    raça <- get_sidra(x = 6405,
                      variable = 5933,
                      period = tri,
                      geo = "State",
                      geo.filter = as.integer(uf))
    nome = glue("dados/sidra/raça/{tri}{uf}_raça.csv")
    write.csv2(raça, file = nome)
  }}




