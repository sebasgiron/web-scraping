# Abrir página de repes y obtener tablas ======================================

sesion <- jump_to(sesion, URL.REPES)

tables <- read_html(sesion$response$content) %>%
  html_nodes("table")


# Crear lista de equipos ======================================================

equipos.repes <- list()

for(i in 5:length(tables)) {
  # Obtener los <td> de la tabla actual 
  td <- html_nodes(tables[[i]], "td")
  if (length(td)>0) {
    # El nombre del equipo estará en la primera entrda 
    texto <- html_text(td[[1]]) %>%
      str_sub(start=4L, end=-2L)
    # Crear objeto y añadirlo a la lista
    e <- equipo(texto, i)
    equipos.repes[[length(equipos.repes)+1]] <- e
    names(equipos.repes)[length(equipos.repes)] <- texto
  }
}

# Limpieza de variables auxiliares
rm(i, td, texto, e)


# Obtener lista de cartas de cada equipo ======================================

get.cartas <- function(this.equipo, nodos_table) {
  # Para obtener la lista de cartas a partir de un equipo
  # Necesitas los nodos_table para leer el del equipo en cuestión
  
  # Obtener los <td> de la tabla del equipo
  nodos <- html_nodes(nodos_table[this.equipo$indice_tabla], "td")
  
  # Crear lista de cartas recorriendo los nodos
  cartas <- list()
  
  for(j in 2:length(nodos)) {
    # trabajar con el <td>
    this.td <- nodos[j]
    # Nombre del equipo viene así
    texto <- str_sub(html_text(this.td), start=26L, end=-6L) %>%
      str_trim(side="right")
    
    if (texto != "") {
      # Si no es casilla vacía, habrá un primer <input> que puede tener
      # el nº de veces que está repe
      this.inputs <- html_nodes(this.td, "input")
      this.values <- html_attr(this.inputs, "value") %>% as.numeric()
      # Crear objeto carla y añadirlo a la lista
      this.carta <- carta(texto, j, valor=this.values[1], 
                          nombre_equipo=this.equipo$nombre)
      cartas[[length(cartas)+1]] <- this.carta
    }
  }
  
  return(cartas)
  
}

# Obtener las cartas de todos los equipos
for(i in 1:length(equipos.repes)) {
  equipos.repes[[i]]$cartas <- get.cartas(equipos.repes[[i]], tables)
}

# Limpieza
rm(i, tables)

