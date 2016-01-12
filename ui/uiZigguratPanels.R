###############################################################################
# Universidad Politécnica de Madrid - EUITT
#   PFC
#   Representación gráfica de redes bipartitas basadas en descomposición k-core 
# 
# Autor         : Juan Manuel García Santi
# Módulo        : uiZigguratPanels.R
# Descricpción  : Contiene las funciones que permiten representar los distintos
#                 paneles que se muestran en el interfaz para el diagrama
#                 ziggurat
###############################################################################
library(shiny)
library(shinythemes)
source("global.R", encoding="UTF-8")
source("ui/uiZigguratControls.R", encoding="UTF-8")

# panel del ziggurat (configuracion + diagrama)
zigguratPanel<-function() {
  panel<-tabsetPanel(
    tabPanel(strings$value("LABEL_ZIGGURAT_DIAGRAM_PANEL"), tags$div(class="panelContent", zigguratDiagramPanel())),
    tabPanel(strings$value("LABEL_ZIGGURAT_CONFIG_PANEL"),  tags$div(class="panelContent", zigguratConfigPanel()))
  )
  return(panel)
}

# panel con el gragico ziggurat
zigguratDiagramPanel <- function() {
  control<-fluidRow(
    column(7,
      fluidRow(
        groupHeader(text=strings$value("LABEL_ZIGGURAT_DIAGRAM_HEADER"), image="network.png")
      ),
      fluidRow(
        tags$span(
          id="zoomPanel", 
          tags$img(id="zoomin",     onclick="svgZoomIn()",    src="images/zoom_in.png"), 
          tags$img(id="zoomout",    onclick="svgZoomOut()",   src="images/zoom_out.png"),
          tags$img(id="zoomfit",    onclick="svgZoomFit()",   src="images/fit_to_width.png"),
          tags$img(id="zoomreset",  onclick="svgZoomReset()", src="images/sinchronize.png")
        )
      ),
      fluidRow(
        uiOutput("ziggurat")
      )
    ),
    column(5, 
      fluidRow(
        groupHeader(text=strings$value("LABEL_ZIGGURAT_DIAGRAM_INFO_HEADER"), image="document.png")
      ),
      fluidRow(
        tags$div(uiOutput("zigguratDetails"))
      ),
      fluidRow(
        groupHeader(text=strings$value("LABEL_ZIGGURAT_DIAGRAM_WIKI_HEADER"), image="wikipedia.png")
      ),
      fluidRow(
        tags$div(uiOutput("zigguratWikiDetails"))
      )
    )
  )
  return(control)
}

# panel de configuracion del diagrama ziggurat
zigguratConfigPanel <- function() {
  panel<-tabsetPanel(
    #tabPanel(
    #  "SVG",
    #  fluidRow(
    #    column(4, svgScaleFactorControl())
    #  )
    #),
    tabPanel(
      strings$value("LABEL_ZIGGURAT_CONFIG_VISUALIZATION_PANEL"),
      fluidRow(
        column(12, groupHeader(text=strings$value("LABEL_ZIGGURAT_CONFIG_VISUALIZATION_GENERAL_HEADER"), image="settings.png"))
      ),
      fluidRow(
        column(3, zigguratDisplayLabelsControl()),
        column(3, zigguratPaintLinksControl())
      ),
      fluidRow(
        column(6, zigguratFlipResultsControl())
      ),
      fluidRow(
        column(12, groupHeader(text=strings$value("LABEL_ZIGGURAT_CONFIG_VISUALIZATION_SIZES_HEADER"), image="ruler.png"))
      ),
      fluidRow(
        column(3, zigguratAspectRatioControl())
      ),
      fluidRow(
        column(3, zigguratLinkSizeControl()),
        column(3, zigguratCoreBoxSizeControl())
      ),
      fluidRow(
        column(3, zigguratYDisplaceControl("GuildA", strings$value("LABEL_ZIGGURAT_Y_DISPLACE_A_CONTROL"))),
        column(3, zigguratYDisplaceControl("GuildB", strings$value("LABEL_ZIGGURAT_Y_DISPLACE_B_CONTROL")))
      ),
      fluidRow(
        column(3, zigguratHeightExpandControl())
      ),
      fluidRow(
        column(3, zigguratKcore2TailVerticalSeparationControl()),
        column(3, zigguratKcore1TailDistToCoreControl("1", strings$value("LABEL_ZIGGURAT_KCORE1_TAIL_DIST_TO_CORE_CONTROL_1"))),
        column(3, zigguratKcore1TailDistToCoreControl("2", strings$value("LABEL_ZIGGURAT_KCORE1_TAIL_DIST_TO_CORE_CONTROL_2"))),
        column(3, zigguratInnerTailVerticalSeparationControl())
      )
    ),
    tabPanel(
      strings$value("LABEL_ZIGGURAT_CONFIG_COLOURS_PANEL"),
      fluidRow(
        column(12, groupHeader(text=strings$value("LABEL_ZIGGURAT_CONFIG_COLOURS_NODES_HEADER"), image="tree_structure.png"))
      ),
      fluidRow(
        column(4, zigguratAlphaLevelControl())
      ),
      fluidRow(
        column(2, zigguratColorControl("GuildA1", strings$value("LABEL_ZIGGURAT_GUILD_A_COLOR_1_CONTROL"), "#4169E1")),
        column(2, zigguratColorControl("GuildA2", strings$value("LABEL_ZIGGURAT_GUILD_A_COLOR_2_CONTROL"), "#00008B")),
        column(2, zigguratColorControl("GuildB1", strings$value("LABEL_ZIGGURAT_GUILD_B_COLOR_1_CONTROL"), "#F08080")),
        column(2, zigguratColorControl("GuildB2", strings$value("LABEL_ZIGGURAT_GUILD_B_COLOR_2_CONTROL"), "#FF0000"))
      ),
      fluidRow(
        column(12, groupHeader(text=strings$value("LABEL_ZIGGURAT_CONFIG_COLOURS_LINKS_HEADER"), image="link.png"))
      ),
      fluidRow(
        column(4, zigguratAlphaLevelLinkControl())
      ),
      fluidRow(
        column(4, zigguratColorControl("Link", strings$value("LABEL_ZIGGURAT_LINKS_COLOR_CONTROL"), "#888888"))
      )
    ),
    tabPanel(
      strings$value("LABEL_ZIGGURAT_CONFIG_LABELS_PANEL"),
      fluidRow(
        column(12, groupHeader(text=strings$value("LABEL_ZIGGURAT_CONFIG_LABELS_SIZE_HEADER"), image="generic_text.png"))
      ),
      fluidRow(
        column(2, zigguratLabelsSizeControl("kCoreMax", strings$value("LABEL_ZIGGURAT_KCOREMAX_LABEL_SIZE_CONTROL"), 10)),
        column(2, zigguratLabelsSizeControl("Ziggurat", strings$value("LABEL_ZIGGURAT_ZIGGURAT_LABEL_SIZE_CONTROL"), 9)),
        column(2, zigguratLabelsSizeControl("kCore1", strings$value("LABEL_ZIGGURAT_KCORE1_LABEL_SIZE_CONTROL"), 8))
      ),
      fluidRow(
        column(2, zigguratLabelsSizeControl("", strings$value("LABEL_ZIGGURAT_GENERAL_LABEL_SIZE_CONTROL"), 20)),
        column(2, zigguratLabelsSizeControl("CoreBox", strings$value("LABEL_ZIGGURAT_COREBOX_LABEL_SIZE_CONTROL"), 8)),
        column(2, zigguratLabelsSizeControl("Legend", strings$value("LABEL_ZIGGURAT_LEGEND_LABEL_SIZE_CONTROL"), 8))
      ),
      fluidRow(
        column(12, groupHeader(text=strings$value("LABEL_ZIGGURAT_CONFIG_LABELS_COLOUR_HEADER"), image="border_color.png"))
      ),
      fluidRow(
        column(2, zigguratColorControl("LabelGuildA", strings$value("LABEL_ZIGGURAT_GUILD_A_LABEL_COLOR_CONTROL"), "#4169E1")),
        column(2, zigguratColorControl("LabelGuildB", strings$value("LABEL_ZIGGURAT_GUILD_B_LABEL_COLOR_CONTROL"), "#F08080"))
      )
    )
  )
  return(panel)
}