#************************************************************************
#*                                 SaaS                                 *
#************************************************************************
#* Nombre de la pAgina: ApplicationController                           *
#* Descripción        : Controlador de metodos compartidas del Saas     *
#* Funcional          : Enrique Martínez                                *
#* Fecha Creación     : 26 de Septiembre del 2015.                      *
#************************************************************************
#*                        LOG DE MODIFICACIONES                         *
#************************************************************************
#*                                                                      *
#************************************************************************
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # include session helper into all project
  include SessionsHelper
end
