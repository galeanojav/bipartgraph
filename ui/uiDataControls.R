###############################################################################
# Universidad Politécnica de Madrid - EUITT
#   PFC
#   Representación gráfica de redes bipartitas basadas en descomposición k-core 
# 
# Autor         : Juan Manuel García Santi
# Módulo        : uiDataControls.R
# Descricpción  : Funciones para la representación de los disintos controles
#                 de configuración, relativos a los datos, en el interfaz 
#                 de usuario (UI)
###############################################################################
library(shinyjs)

# control para la seleccion del fichero
selectDataFileControl <- function(path, pattern) {
  filesList<-as.list(list.files(path=path, pattern=pattern))
  names(filesList)<-filesList
  choices<-list(c(""))
  names(choices)<-strings$value("LABEL_SELECT_DATAFILE_LOADING")
  control<-selectInput(
    inputId   = "selectedDataFile", 
    label     = controlLabel(strings$value("LABEL_SELECT_DATAFILE_CONTROL")),
    choices   = choices,
    selected  = NULL,
    multiple  = FALSE
  )
  return(control)
}

# control para subida de ficheros
uploadFilesControl <- function() {
  control<-fileInput(
    inputId   = "uploadedFiles",
    accept    = c("txt/csv", "text/comma-separated-values", "text/plain", ".csv"),
    label     = controlLabel(strings$value("LABEL_UPLOAD_FILES_CONTROL")),
    multiple  = TRUE
  )
  return(control)
}

# control para refrescar la lista de ficheros disponibles
refreshFilesControl <- function() {
  control<-actionButton(
    inputId   = "refreshFiles",
    label     = controlLabel(strings$value("LABEL_REFRESH_FILES_CONTROL"))
  )
  return(control)
}

# control para eliminar la lista de ficheros que se hayan seleccionado
deleteFilesControl <- function() {
  control<-actionButton(
    inputId   = "deleteFiles",
    label     = controlLabel(strings$value("LABEL_DELETE_FILES_CONTROL"))
  )
  return(control)
}