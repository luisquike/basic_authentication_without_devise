#************************************************************************
#*                                 SaaS                                 *
#************************************************************************
#* Nombre de la pAgina: ApplicationHelper                               *
#* Descripción        : Modulos de apoyo para el sistema.               *
#* Funcional          : Enrique Martínez                                *
#* Fecha Creación     : 26 de Septiembre del 2015.                      *
#************************************************************************
#*                        LOG DE MODIFICACIONES                         *
#************************************************************************
#*                                                                      *
#************************************************************************
module ApplicationHelper

	#Define el titulo base de la vista
	def full_title(page_title)
    	base_title = "SaaS"
    	if page_title.empty?
      		base_title
    	else
      		"#{base_title} | #{page_title}"
    	end
  	end
end
