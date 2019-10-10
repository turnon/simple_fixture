class Order < ActiveRecord::Base
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :order
  belongs_to :good
end

class Good < ActiveRecord::Base
  has_many :items
end
