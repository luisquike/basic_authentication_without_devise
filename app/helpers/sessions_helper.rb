#************************************************************************
#*                                 SaaS                                 *
#************************************************************************
#* Nombre de la pAgina: SessionsHelper                                  *
#* Descripción        : Modulo de apoyo con metodos para sessiones      *
#* Funcional          : Enrique Martínez                                *
#* Fecha Creación     : 26 de Septiembre del 2015.                      *
#************************************************************************
#*                        LOG DE MODIFICACIONES                         *
#************************************************************************
#*                                                                      *
#************************************************************************
module SessionsHelper
	#Logear usuario
	#Guarda una cookie encriptada en la BD
	#Guarda una cookie hash en browser del cliente
	#Crea variable instanciada current_user
	def sign_in(user)
    	remember_token = User.new_remember_token
    	cookies.permanent[:remember_token_SaaS] = remember_token
    	user.update_attribute(:remember_token, User.digest(remember_token))
    	self.current_user = user
  	end

  	#Instancia a var Current_user
	def current_user=(user)
	    @current_user = user
	end

	#Retorna Objeto Currrent_user o nulo
	def current_user
    	remember_token = User.digest(cookies[:remember_token_SaaS])
    	@current_user ||= User.find_by(remember_token: remember_token)
  	end

  	#Verifica si esta lodeago el usuario y retorna Current_user
  	def signed_in?
	  	!current_user.nil?
	end

	def current_user?(user)
	  	user == current_user
	end

	def remmember_user
    	cookies.permanent[:remember_user_SaaS] = User.new_remember_token
	end

	def not_remember_user
		begin
			cookies.delete(:remember_user_SaaS)
	      	@send = 0
	    rescue Exception => e
		    @send = 1
		    puts "EXCEPTION!!"
	    end
		respond_to do |format| 
	      format.json { render json: @send } 
	      format.js 
	    end 
	end 

	def sign_out
		if !cookies[:remember_user_SaaS].nil?
			current_user.update_attribute(:remember_token,
	                 User.digest(cookies[:remember_user_SaaS]))
	    else
			current_user.update_attribute(:remember_token,
	                 User.digest(User.new_remember_token))
	    end
	    cookies.delete(:remember_token_SaaS)
	    self.current_user = nil
	end

	def redirect_back_or(default)
	  redirect_to(session[:return_to_SaaS] || default)
	  session.delete(:return_to_SaaS)
	end

	def store_location
	  session[:return_to_SaaS] = request.url if request.get?
	end

	def signed_in_user
      unless signed_in?
      	store_location
      	flash[:danger] = 'Please sign in.'
      	redirect_to root_path
      end
  	end
end
