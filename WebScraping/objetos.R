# Definiciones de objetos =====================================================

# Equipo ======================================================================
equipo <- function(nombre, indice_tabla = NULL) {
  result <- list(
    "nombre"=nombre, 
    "indice_tabla"=indice_tabla,
    "cartas"=list()
  )
  class(result) <- "equipo"
  return(result)
}

print.equipo <- function(x, ...) {
  cat(paste('"',x$nombre, '" (indice:', x$indice_tabla, "; cartas:", 
            length(x$cartas), ')"', sep=""))
}

# Carta (de jugador o de lo que sea) ==========================================
carta <- function(nombre, indice_td=NULL, valor=NULL, nombre_equipo=NULL) {
  result <- list(
    "nombre"=nombre,
    "indice_td"=indice_td, 
    "valor"=valor, 
    "nombre_equipo"=nombre_equipo
  )
  class(result) <- "carta"
  return(result)
}

print.carta <- function(x, ...) {
  cat(paste('"', x$nombre, '" (indice:',x$indice_td, "; valor:", x$valor, 
            '; equipo:"',x$nombre_equipo,'")', sep=""))
}
