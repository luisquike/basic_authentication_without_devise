#&=======================================================================
#& User < ActiveRecord::Base                       
#&=======================================================================
class User < ActiveRecord::Base

	#VALIDACION DE NOMBRE
  	VALID_NAME_FORMAT = /\A[a-zA-Z\s]*\z/i
  	validates :name, presence: true,
                	 format: { with: VALID_NAME_FORMAT },
               	 	 length: { minimum: 20 }
                   
  	#VALIDACION DE EMAIL
  	before_save { self.email = email.downcase }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence:    true,
                      format:    { with: VALID_EMAIL_REGEX },
                      uniqueness:{ case_sensitive: false }

  	#VALIDACION DE CONTRASEÑA
  	has_secure_password #presencia, confirmacion, coincidencia, verificacion
  	validates :password, length: { minimum: 6 }  

    #CREAR REMEMMBER TOKEN
    before_create :create_remember_token

    #&=====================================================================*
    #&  Nombre de la Función/método: User.new_remember_token
    #&  Descripción: Crea el Hash Remmember token.
    #&=====================================================================*
    #&  Entradas <-  
    #&  Salida   ->  
    #&=====================================================================*
    def User.new_remember_token
      SecureRandom.urlsafe_base64
    end

    #&=====================================================================*
    #&  Nombre de la Función/método: User.digest(token)
    #&  Descripción: Encripta Token.
    #&=====================================================================*
    #&  Entradas <-  Token
    #&  Salida   ->  
    def User.digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end  

    private
      #&=====================================================================*
      #&  Nombre de la Función/método: create_remember_token
      #&  Descripción: Crea token de usuario para iniciar session.
      #&=====================================================================*
      #&  Entradas <-  
      #&  Salida   ->  
      #&=====================================================================*
      def create_remember_token
        self.remember_token = User.digest(User.new_remember_token)
      end 
end
