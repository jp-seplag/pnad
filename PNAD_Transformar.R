# Biblotecas

#install.packages('srvyr')
library(PNADcIBGE)
library(survey)
library(srvyr)
library(dplyr)
library(glue)

setwd("S:/NCD/Projetos 2023/PNAD")

# Lista de variáveis
variaveis_selecionadas <- c("UF","Ano", "Trimestre", "UF","UPA", "V1029", "V2007", "V2010", "VD3004", "VD4001",
                            "VD4002", "VD4003", "VD4004", "VD4004A", "VD4005", "VD4009", "VD4010")
ufs <- unlist(readRDS("ufs.rds"))

# LEMBRAR DE TIRAR OS ARQUIVOS JÁ PROCESSADOS 2015 E 2016

# lista de arquivos
file_list <- list.files(path="S:/NCD/Projetos 2023/PNAD/rds")

# Função  -----------------------------------------------------------------
# Loop para processar os dados
for (i in 1:length(file_list)){
pnad_srv <- readRDS(
                    paste("S:/NCD/Projetos 2023/PNAD/rds/",file_list[i],sep = "")
                    )
pnad_srv <- as_survey(pnad_srv)
anofile = pnad_srv$variables$Ano[1]
trimestrefile = pnad_srv$variables$Trimestre[1]
ano_tri = stringr::str_c(anofile,trimestrefile)

  for (uf in ufs) {
  
    pnad <- pnad_srv |> filter(UF == {uf})
    # arquivo <- as.character(glue("dados/{uf}.{ano_tri}.rds"))
    # saveRDS(pnad,file =  arquivo)

    # População
    pasta = "dados/população/"
    população <- pnad %>% group_by(V2007,V2010) %>% summarise(Total = survey_total())
    população$ano <- anofile
    população$tri <- trimestrefile
    população$uf <- {uf}
    write.csv2(população,paste(pasta,"população_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(população)
    cat(pasta,"população",{uf},ano_tri,".csv")

    # Desalentados
    pasta = "dados/desalentados/"
    desalentados <- pnad %>% group_by(V2007,V2010,VD4005) %>% summarise(Total = survey_total())    
    desalentados$ano <- anofile
    desalentados$tri <- trimestrefile
    desalentados$uf <- {uf}
    write.csv2(desalentados,paste(pasta,"desalentados_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(desalentados)
    cat(pasta,"desalentados",{uf},ano_tri,".csv")

    # Força de trabalho
    pasta = "dados/força_de_trabalho/"
    força_de_trabalho <- pnad %>% group_by(V2007,V2010,VD4001) %>% summarise(Total = survey_total())
    força_de_trabalho$ano <- anofile
    força_de_trabalho$tri <- trimestrefile
    força_de_trabalho$uf <- {uf}
    write.csv2(força_de_trabalho,paste(pasta,"força_de_trabalho_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(força_de_trabalho)
    cat(pasta,"força_de_trabalho",{uf},ano_tri,".csv")
    
    # Força de trabalho potencial    
    pasta = "dados/força_trab_potencial/"
    força_trab_potencial<- pnad %>% group_by(V2007,V2010,VD4003) %>% summarise(Total = survey_total())
    força_trab_potencial$ano <- anofile
    força_trab_potencial$tri <- trimestrefile
    força_trab_potencial$uf <- {uf}
    write.csv2(força_trab_potencial,paste(pasta,"força_trab_potencial_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(força_trab_potencial)
    cat(pasta,"força_trab_potencial",{uf},ano_tri,".csv")

    # Ocupados
    pasta = "dados/ocupados/"
    ocupados <- pnad %>% group_by(V2007,V2010,VD4002) %>% summarise(Total = survey_total())
    ocupados$ano <- anofile
    ocupados$tri <- trimestrefile
    ocupados$uf <- {uf}
    write.csv2(ocupados,paste(pasta,"ocupados_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(ocupados)

    # Subocupados     
    pasta = "dados/subocupados/"
    subocupados <- pnad %>% group_by(V2007,V2010,VD4004A) %>% summarise(Total = survey_total())
    subocupados$ano <- anofile
    subocupados$tri <- trimestrefile
    subocupados$uf <- {uf}
    write.csv2(subocupados,paste(pasta,"subocupados_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(subocupados)

    # Atividade
    pasta = "dados/atividade/"
    atividade <- pnad %>% group_by(V2007,V2010,VD4010) %>% summarise(Total = survey_total()) 
    atividade$ano <- anofile
    atividade$tri <- trimestrefile
    atividade$uf <- {uf}
    write.csv2(atividade,paste(pasta,"atividade_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(atividade)
    
    # Cursos mais elevados    
    pasta = "dados/cursos_mais_elevados/"
    cursos_mais_elevados <- pnad %>% group_by(V2007,V2010,VD3004) %>% summarise(Total = survey_total()) 
    cursos_mais_elevados$ano <- anofile
    cursos_mais_elevados$tri <- trimestrefile
    cursos_mais_elevados$uf <- {uf}
    write.csv2(cursos_mais_elevados,paste(pasta,"cursos_mais_elevados_",{uf},"_",ano_tri,".csv",sep = ""))
    rm(cursos_mais_elevados)
    cat("cursos_mais_elevados",ano_tri,".csv")
  }
}