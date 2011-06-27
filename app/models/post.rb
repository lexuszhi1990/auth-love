class Post < ActiveRecord::Base
  validates :user_id,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 2 }

  ## for will_paginate
  cattr_reader :per_page
  @@per_page = 10

  has_many :comments, :dependent => :destroy
  belongs_to :user
  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['title like ?', "%#{search}%"], 
             :order => 'id DESC' #DESC: list in reverse order
  end

end
