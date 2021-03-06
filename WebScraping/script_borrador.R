library(rvest)
library(stringr)

URL.REPES  <- "https://www.cromosrepes.com/listas/marcar/repes/6463"
URL.FALTAS <- "https://www.cromosrepes.com/listas/marcar/faltas/6463"
URL.LOGIN  <- "https://www.cromosrepes.com/usuario/login"

source("param_usuario.R", echo = T)

# param_usuario tiene que haber definido lo siguiente
stopifnot(!is.na(LOGIN.NICK))
stopifnot(!is.na(LOGIN.PASSWORD))


source("login.R", echo = T)

source("objetos.R", echo = T)

source("repes.R", echo = T)

source("faltas.R", echo = T)


# Pintar la lista de faltas

for (i in 1:length(equipos.faltas)) {
  eq <- equipos.faltas[[i]]
  for (j in 1:length(eq$cartas)) {
    car <- eq$cartas[[j]]
    if (!is.na(car$valor)) {
      cat(car$nombre, fill = T)
    }
  }
}
