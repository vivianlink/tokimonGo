      
class TokimonsController < ApplicationController
  before_action :set_tokimon, only: [:show, :edit, :update, :destroy]

  # GET /tokimons
  # GET /tokimons.json
  def index
    @tokimons = Tokimon.all
    @trainers = Trainer.all

    # puts(@tokimons)
    @tokimons.each_with_index do |tokimon, index| 
      puts(@tokimons[index][:name])
      # @tokimons[index][:trainer_name] = "asd"
      # @tokimons[index][:trainer_name] = Trainer.find(tokimon.trainer_id).name
      # puts(@tokimons[index][:trainer_name])
    end
  end

  # GET /tokimons/1
  # GET /tokimons/1.json
  def show
  end

  # GET /tokimons/new
  def new
    @tokimon = Tokimon.new

    @trainers_count = Trainer.all.count
  end

  # GET /tokimons/1/edit
  def edit
  end

  # POST /tokimons
  # POST /tokimons.json
  def create
    @params = tokimon_params
    @params[:total] = 0

    if (@params[:fly] != "")
      @params[:total] += Integer(@params[:fly])
    end

    if (@params[:fight] != "")
      @params[:total] += Integer(@params[:fight])
    end

    if (@params[:ice] != "")
      @params[:total] += Integer(@params[:ice])
    end

    if (@params[:fire] != "")
      @params[:total] += Integer(@params[:fire])
    end

    if (@params[:electric] != "")
      @params[:total] += Integer(@params[:electric])
    end

    if (@params[:water] != "")
      @params[:total] += Integer(@params[:water])
    end

    # @params[:total] = Integer(@params[:fly]) + Integer(@params[:fight]) + Integer(@params[:fire]) + Integer(@params[:water]) + Integer(@params[:electric]) + Integer(@params[:ice])
    @tokimon = Tokimon.new(@params)

    respond_to do |format|
      if @tokimon.save
        @tokimon_trainer = Trainer.find(tokimon_params[:trainer_id])
        @new_level = (@tokimon_trainer.tokimons.count)/3 + 1

        if(@tokimon_trainer[:level] != @new_level)
          @tokimon_trainer.update(level: @new_level)
          format.html { redirect_to @tokimon, notice: 'Tokimon was successfully created. ' + @tokimon_trainer[:name] + ' level up!' }
        else
          format.html { redirect_to @tokimon, notice: 'Tokimon was successfully created.' }
        end

        format.json { render :show, status: :created, location: @tokimon }
      else
        format.html { render :new }
        format.json { render json: @tokimon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tokimons/1
  # PATCH/PUT /tokimons/1.json
  def update

    @params = tokimon_params
    @params[:total] = 0

    if (@params[:fly] != "")
      @params[:total] += Integer(@params[:fly])
    end

    if (@params[:fight] != "")
      @params[:total] += Integer(@params[:fight])
    end

    if (@params[:ice] != "")
      @params[:total] += Integer(@params[:ice])
    end

    if (@params[:fire] != "")
      @params[:total] += Integer(@params[:fire])
    end

    if (@params[:electric] != "")
      @params[:total] += Integer(@params[:electric])
    end

    if (@params[:water] != "")
      @params[:total] += Integer(@params[:water])
    end

   # @params[:total] = Integer(@params[:fly]) + Integer(@params[:fight]) + Integer(@params[:fire]) + Integer(@params[:water]) + Integer(@params[:electric]) + Integer(@params[:ice])

    @old_tokimon_trainer = Trainer.find(@tokimon[:trainer_id])
    @new_tokimon_trainer = Trainer.find(tokimon_params[:trainer_id])

    if (@old_tokimon_trainer != @new_tokimon_trainer) 
      @old_tokimon_trainer_new_level = (@old_tokimon_trainer.tokimons.count - 1)/3 + 1
      @new_tokimon_trainer_new_level = (@new_tokimon_trainer.tokimons.count + 1)/3 + 1

      respond_to do |format|
        if @tokimon.update(@params)
          if (@old_tokimon_trainer[:level] != @old_tokimon_trainer_new_level) 
            @old_tokimon_trainer.update(level: @old_tokimon_trainer_new_level)
          end

          if (@new_tokimon_trainer[:level] != @new_tokimon_trainer_new_level) 
            format.html { redirect_to @tokimon, notice: 'Tokimon was successfully updated. ' + @new_tokimon_trainer[:name] + ' level up!' }

            @new_tokimon_trainer.update(level: @new_tokimon_trainer_new_level)
          else
            format.html { redirect_to @tokimon, notice: 'Tokimon was successfully updated.' }
          end

          format.json { render :show, status: :ok, location: @tokimon }
        else
          format.html { render :edit }
          format.json { render json: @tokimon.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to action: "show"
    end

  end

  # DELETE /tokimons/1
  # DELETE /tokimons/1.json
  def destroy
    @tokimon_trainer = Trainer.find(@tokimon[:trainer_id])
    @tokimon.destroy
    respond_to do |format|
      @new_level = (@tokimon_trainer.tokimons.count)/3 + 1

      if(@tokimon_trainer[:level] != @new_level)
        @tokimon_trainer.update(level: @new_level)
        format.html { redirect_to @tokimon, notice: 'Tokimon was successfully destroyed. ' + @tokimon_trainer[:name] + ' level down!' }
      else
        format.html { redirect_to @tokimon, notice: 'Tokimon was successfully destroyed.' }
      end

      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tokimon
      @tokimon = Tokimon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tokimon_params
      params.require(:tokimon).permit(:name, :height, :weight, :fly, :fight, :fire, :water, :electric, :ice, :total, :eating_habit, :weapon, :strength, :trainer_id)
    end
end
