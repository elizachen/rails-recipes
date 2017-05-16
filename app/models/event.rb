class Event < ApplicationRecord
  include RankedModel
  ranks :row_order
  mount_uploader :logo, EventLogoUploader
  mount_uploaders :images, EventImageUploader
  serialize :images, JSON


 has_many :tickets, :dependent => :destroy
 has_many :registrations, :dependent => :destroy

 accepts_nested_attributes_for :tickets, :allow_destroy => true,  :reject_if => :all_blank
 belongs_to :category, :optional => true

 STATUS = ["draft", "public", "private"]
 validates_inclusion_of :status, :in => STATUS

 validates_presence_of :name, :friendly_id

 validates_uniqueness_of :friendly_id
 validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

scope :only_public, -> { where( :status => "public" ) }
scope :only_available, -> { where( :status => ["public", "private"] ) }


 def to_param
   #"#{self.id}-#{self.name}"
   self.friendly_id
 end

 protected

 def generate_friendly_id
   self.friendly_id ||= SecureRandom.uuid
 end

end
