class Album < ActiveRecord::Base
  belongs_to :group
  belongs_to :place
  belongs_to :person, :conditions => ['people.visible = ? ', true]
  belongs_to :site
  has_many :pictures, :dependent => :destroy

  

  attr_accessible :name, :description, :is_public

  acts_as_logger LogItem

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:site_id, :person_id]

  def cover
    @cover ||= pictures.find_by_cover(true)
    @cover ||= pictures.first
  end

  after_destroy :delete_stream_items

  def delete_stream_items
    StreamItem.destroy_all(:streamable_type => 'Album', :streamable_id => id)
  end
end
