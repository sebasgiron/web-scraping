# Abrir página de faltas y obtener tablas ======================================

sesion <- jump_to(sesion, URL.FALTAS)

tables <- read_html(sesion$response$content) %>%
  html_nodes("table")


# Crear lista de equipos ======================================================

equipos.faltas <- list()

for(i in 5:length(tables)) {
  # Obtener los <td> de la tabla actual 
  td <- html_nodes(tables[[i]], "td")
  if (length(td)>0) {
    # El nombre del equipo estará en la primera entrda 
    texto <- html_text(td[[1]]) %>%
      str_sub(start=4L, end=-2L)
    # Crear objeto y añadirlo a la lista
    e <- equipo(texto, i)
    equipos.faltas[[length(equipos.faltas)+1]] <- e
    names(equipos.faltas)[length(equipos.faltas)] <- texto
  }
}

# Limpieza de variables auxiliares
rm(i, td, texto, e)

# Obtener lista de cartas de cada equipo ======================================

# Recorrer la lista de equipos.faltas
# Para obtener las cartas, nos vale la misma función get.cartas 
# definida en la parte de repes
for(i in 1:length(equipos.faltas)) {
  equipos.faltas[[i]]$cartas <- get.cartas(equipos.faltas[[i]], tables)
}


# Limpieza
rm(i, tables)
