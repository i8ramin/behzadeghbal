class NotesController < ApplicationController
  respond_to :html, :js
  caches_page :index
  cache_sweeper :note_sweeper
  
  def index
    @note = Note.new
    sorted_notes
    
    editable_notes(sorted_notes)
    
    respond_with(@note, @notes)
  end
  
  def create
    @note = Note.new(params[:note])
    sorted_notes
    
    # detect language
    @note.language = @note.content.language.to_s
    
    @note.candle = rand(6) + 1
    @note.flame  = rand(4) + 1
    
    if @note.save
      cookies['note-' + @note.id.to_s] = @note.id
      @note.editable = true
      @notes << @note
    end
    
    respond_with(@note, @notes)
  end
  
  def update
    @note = Note.find(params[:id])
    @note.update_attributes(params[:note])
    
    editable_notes(sorted_notes)
    
    respond_with(@note, @notes)
  end
  
  private
  
  def sorted_notes
    @notes = Note.find(:all, :order => 'created_at ASC')
  end
  
  def editable_notes(notes)
    # which notes are editable based on cookie
    for note in notes
      note.editable = cookies['note-' + note.id.to_s].nil? ? false : true
    end
    
    @notes = notes
  end
  
end