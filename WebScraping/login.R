# Logado en cromosrepes =======================================================

# Inicializar objeto sesión en página Login
sesion <- html_session(URL.LOGIN)

# Obtener formulario
form <- html_form(read_html(sesion$response$content))[[1]]

# Rellenar formulario con nick y password
form$url <- sesion$url
form$fields$nick$value     <- LOGIN.NICK
form$fields$password$value <- LOGIN.PASSWORD

# Enviar formulario
sesion <- submit_form(sesion, form)
