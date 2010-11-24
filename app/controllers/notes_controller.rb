class NotesController < ApplicationController
  before_filter :load
  
  def load
    @notes = Note.all
    @note = Note.new
  end
  
  def index
  end
  
  def create
    @note = Note.new(params[:note])
    
    # detect language
    @note.language = @note.content.language.to_s
    
    @note.candle = rand(6) + 1
    @note.flame  = rand(4) + 1
    
    if @note.save
      flash[:notice] = "Successfully created note."
      @notes = Note.all
    end
  end
end
