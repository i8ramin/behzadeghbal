class NoteSweeper < ActionController::Caching::Sweeper
  observe Note # This sweeper is going to keep an eye on the Note model
 
  # If our sweeper detects that a Note was created call this
  def after_create(note)
    expire_cache_for(note)
  end
 
  # If our sweeper detects that a Note was updated call this
  def after_update(note)
    expire_cache_for(note)
  end
 
  # If our sweeper detects that a Note was deleted call this
  def after_destroy(note)
    expire_cache_for(note)
  end
 
  private
  def expire_cache_for(note)
    # Expire the index page now that we added a new note
    expire_page(:controller => 'notes', :action => 'index')
  end
end