#************************************************************************
#*                                 SaaS                                 *
#************************************************************************
#* Nombre de la pAgina: UsersController                                 *
#* Descripción        : Gestion y control de usuarios existentes o no,  *
#* Funcional          : Enrique Martínez                                *
#* Fecha Creación     : 26 de Septiembre del 2015.                      *
#************************************************************************
#*                        LOG DE MODIFICACIONES                         *
#************************************************************************
#*                                                                      *
#************************************************************************

class UsersController < ApplicationController

  #Debe estar logeado para poder realizar las siguientes acciones
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  #Solo en su mismo usuario puede realizar las siguientes acciones
  before_action :correct_user,   only: [:edit, :update]
  #Obtiene parametros del usuario
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  #&=====================================================================*
  #&  Nombre de la Función/método: index
  #&  Descripción: Recopilacion de la coleccion de usuarios
  #&=====================================================================*
  #&  Entradas <-  Colección de usuarios
  #&  Salida   ->  
  #&=====================================================================*
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: show
  #&  Descripción: Muestra datos que pertenecen al usuario
  #&=====================================================================*
  #&  Entradas <-  Parametros del usuario
  #&  Salida   ->  
  #&=====================================================================*
  # GET /users/1
  # GET /users/1.json
  def show
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: new
  #&  Descripción: Creacion de nuevo usuario en el sistema
  #&=====================================================================*
  #&  Entradas <-  Parametros a asignar al nuevo usuario
  #&  Salida   ->  
  #&=====================================================================*
  # GET /users/new
  def new
    unless signed_in?
      @user = User.new
    else
      redirect_to current_user
    end
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: new
  #&  Descripción: Edición nuevo usuario en el sistema
  #&=====================================================================*
  #&  Entradas <-  Parametros a editar del usuario
  #&  Salida   ->  
  #&=====================================================================*
  # GET /users/1/edit
  def edit
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: create
  #&  Descripción: Genera nuevos usuarios
  #&=====================================================================*
  #&  Entradas <- atributos del usuario
  #&  Salida   ->  
  #&=====================================================================*
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = "Welcome to the Sample App!"
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: update
  #&  Descripción: Realiza la modificacion de la informacion de usuario
  #&=====================================================================*
  #&  Entradas <- Nuevos atributos del usuario
  #&  Salida   ->  
  #&=====================================================================*
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #&=====================================================================*
  #&  Nombre de la Función/método: destroy
  #&  Descripción: Destruye usuarios
  #&=====================================================================*
  #&  Entradas <- usuario
  #&  Salida   ->  
  #&=====================================================================*
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    #&=======================================================================
    #& Use callbacks to share common setup or constraints between actions.                       
    #&=======================================================================
    def set_user
      @user = User.find(params[:id])
    end

    #&=======================================================================
    #& Never trust parameters from the scary internet, only allow the white list through.                    
    #&=======================================================================
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #&=======================================================================
    #& Realizara la ccion solo si los parametros pertenecen al current_user.                    
    #&=======================================================================
    def correct_user 
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
