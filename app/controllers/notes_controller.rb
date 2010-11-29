class NotesController < ApplicationController
  respond_to :html, :js
  caches_page :index
  cache_sweeper :note_sweeper
  
  # GET /notes
  def index
    @note = Note.new
    sorted_notes
    
    sorted_notes
    
    respond_with(@note, @notes)
  end
  
  # POST /notes
  def create
    sorted_notes
    @note = Note.new(params[:note])
    
    @note.from.strip!
    @note.content.strip!
    
    note = Note.find_by_from(@note.from)
    
    if note && note.content == @note.content
      # existing identical note, ignore
    else
      # detect language
      @note.language = @note.content.language.to_s
  
      @note.candle = rand(6) + 1
      @note.flame  = rand(4) + 1
  
      if @note.save
        # cookies['note-' + @note.id.to_s] = @note.id
        # @note.editable = true
        @notes << @note
      end
    end
    
    respond_with(@note, @notes)
  end
  
  # PUT /notes/1
  # def update
  #   @note = Note.find(params[:id])
  #   @note.update_attributes(params[:note])
  #   
  #   sorted_notes
  #   
  #   respond_with(@note, @notes)
  # end
  
  # DELETE /notes/1
  # def destroy
  #   @note = Note.find(params[:id])
  #   
  #   if (cookies['note-' + @note.id.to_s] == @note.id.to_s)
  #     @note_id = @note.id
  #     @note.destroy
  #   end
  # end
  
  private
  
  def sorted_notes
    @notes = Note.find(:all, :order => 'created_at ASC')
  end
  
end