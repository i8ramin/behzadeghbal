class Note < ActiveRecord::Base
  attr_accessible :from, :content, :candle, :flame
  attr_accessor :editable

  validates_presence_of :content
end
