# Importa bibliotecas
library(readxl)
library(httr)
library(lubridate)
library(magrittr)
library(dplyr)

# importa dados do site de estatísticas de comércio exterior
url_file <- "https://balanca.economia.gov.br/balanca/mes/2022/BCB002.xlsx"
GET(url = url_file, write_disk(tf <- tempfile(fileext = ".xlsx")))

# Dados mensais de exportação/importação
dado_mensal_exp <- read_excel(path = tf, sheet = 1, range = "A9:D20",
col_names = c("no_mes", "ano_maior", "ano_menor", "var"))

dado_mensal_imp <- read_excel(path = tf, sheet = 1, range = "E9:G20",
col_names = c("ano_maior", "ano_menor", "var")) %>%
    mutate(no_mes = dado_mensal_exp$no_mes) %>%
    select(no_mes, ano_maior, ano_menor, var)

# Dados acumulados de exportação/importação
dado_acum_exp <- read_excel(path = tf, sheet = 2, range = "A9:D20",
col_names = c("no_mes", "ano_maior", "ano_menor", "var"))

dado_acum_imp <- read_excel(path = tf, sheet = 2, range = "E9:G20",
col_names = c("ano_maior", "ano_menor", "var")) %>%
    mutate(no_mes = dado_acum_exp$no_mes) %>%
    select(no_mes, ano_maior, ano_menor, var)