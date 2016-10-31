#************************************************************************
#*                                 SaaS                                 *
#************************************************************************
#* Nombre de la pAgina: SessionsController                              *
#* Descripción        : Gestiona las secciones de cada usuario,         *
#*                      validando su presencia y tipo de usuario        *
#* Funcional          : Enrique Martínez                                *
#* Fecha Creación     : 26 de Septiembre del 2015.                      *
#************************************************************************
#*                        LOG DE MODIFICACIONES                         *
#************************************************************************
#*                                                                      *
#************************************************************************

class SessionsController < ApplicationController
  #&=====================================================================*
  #&  Nombre de la Función/método: new
  #&  Descripción: Metodos para gestionar datos de vista SignIn
  #&=====================================================================*
  #&  Entradas <-  
  #&  Salida   ->  
  #&=====================================================================*
  def new
    !cookies[:remember_user_SaaS].nil? ? @check = true : @check = false
    !cookies[:remember_user_SaaS].nil? ? @email ||= User.find_by(remember_token: User.digest(cookies[:remember_user_SaaS])).email : @email = "Correo Electronico"
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: create
  #&  Descripción: Logeo nuevo usuario a al sistema
  #&=====================================================================*
  #&  Entradas <-  Parametros de la nueva session 
  #&  Salida   ->  
  #&=====================================================================*
  def create
    if !cookies[:remember_user_SaaS].nil?
      user = User.find_by(remember_token: User.digest(cookies[:remember_user_SaaS]))
      if !user.nil?
        sign_in user
        cookies.delete(:remember_user_SaaS)
        remmember_user
        redirect_back_or current_user
      end
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if params[:session][:remmember].to_i == 1
          remmember_user
        end 
        sign_in user
        redirect_back_or current_user
      else
        flash[:danger] = 'Invalid email/password combination'
        redirect_to login_path
      end
    end 
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: destroy
  #&  Descripción: Deslogea usuario del sistema
  #&=====================================================================*
  #&  Entradas <- 
  #&  Salida   ->  
  #&=====================================================================*
  def destroy
    sign_out
    redirect_to root_url
  end
  
end
