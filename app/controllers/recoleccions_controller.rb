class RecoleccionsController < ApplicationController  
  require 'open-uri'
  require 'json'
  
  # GET /recoleccions
  # GET /recoleccions.json
  def index
    @recoleccions = Recoleccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recoleccions }
      format.csv { send_data @recoleccions.to_csv }
    end
  end

  # GET /recoleccions/1
  # GET /recoleccions/1.json
  def show
    @recoleccion = Recoleccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recoleccion }
    end
  end

  # GET /recoleccions/new
  # GET /recoleccions/new.json
  def new
    @recoleccion = Recoleccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recoleccion }
    end
  end

  # GET /recoleccions/1/edit
  def edit
    @recoleccion = Recoleccion.find(params[:id])
  end

  # POST /recoleccions
  # POST /recoleccions.json
  def create
    puts
    puts
    puts ".............................................................."
    puts
    linea_inicial = "104"
    codigo_paradero_inicial="PC37" 
    linea_id = nil
    recoleccions = Array.new
    all_recoleccion_valid = true
    numero_secuencia = nil
    # Buscar todas las lineas para encontrar el id
    lineas = JSON.parse(open("http://citppuc.cloudapp.net/api/lineas").read)
    #Accion para la primera recoleccion y encontra el id
    recoleccion_inicial = params[:recoleccion].first
    lineas.each do |linea|
      linea_id = linea["linea_id"] if linea["codigo_linea"] == linea_inicial
    end
    #fetch secuencia y encontrar la sequencia donde parte
    secuencias = JSON.parse(open("http://citppuc.cloudapp.net/api/lineas/"+linea_id.to_s).read) if linea_id
    secuencia_paraderos = secuencias["secuencias"][0]["secuencia_paraderos"]
    # secuencia_paraderos[0] -> primer paradero de la sequencia
    secuencia_paraderos.each do |paradero|
      numero_secuencia = paradero["numero_secuencia"].to_i if paradero["codigo_paradero"] == codigo_paradero_inicial
    end
    
    #incializa las recolecciones
    params[:recoleccion].each do |recoleccion|
      #puts secuencia_paraderos
      #revisar cual es mas cercano
      sqr_error = 1000
      for i in 0..10
        i -= secuencia_paraderos.count+1  if numero_secuencia-5+i > secuencia_paraderos.count
        if secuencia_paraderos[numero_secuencia-5+i]
          sqr_error_act = (recoleccion["latitude"].to_f - secuencia_paraderos[numero_secuencia-5+i]["gps_latitud"].to_f)**2 +
                        (recoleccion["longitude"].to_f - secuencia_paraderos[numero_secuencia-5+i]["gps_longitud"].to_f)**2
          #puts sqr_error_act
          if (sqr_error >= sqr_error_act)
            sqr_error = sqr_error_act
            paradero = secuencia_paraderos[numero_secuencia-5+i]["codigo_paradero"]
          end
        end
      end
      recoleccion["paradero"] = paradero 
      new_recoleccion = Recoleccion.new(recoleccion)
      recoleccions << new_recoleccion
      unless new_recoleccion.valid?
        all_recoleccion_valid = false
        invalid_recoleccion = recoleccion
      end
    end

    respond_to do |format|
      if all_recoleccion_valid
        @recoleccions = []
        recoleccions.each do |recoleccion|
              recoleccion.save
              @recoleccions << recoleccion
            end
        
        format.html { redirect_to @recoleccions.first, notice: 'Recoleccion was successfully created.' }
        format.json { render json: @recoleccions, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: invalid_recoleccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recoleccions/1
  # PUT /recoleccions/1.json
  def update
    @recoleccion = Recoleccion.find(params[:id])

    respond_to do |format|
      if @recoleccion.update_attributes(params[:recoleccion])
        format.html { redirect_to @recoleccion, notice: 'Recoleccion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recoleccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recoleccions/1
  # DELETE /recoleccions/1.json
  def destroy
    @recoleccion = Recoleccion.find(params[:id])
    @recoleccion.destroy

    respond_to do |format|
      format.html { redirect_to recoleccions_url }
      format.json { head :no_content }
    end
  end
end
