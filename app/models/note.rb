class Note < ActiveRecord::Base
  attr_accessible :from, :content, :candle, :flame

  validates_presence_of :content
end
