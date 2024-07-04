class UserSerializer < ActiveModel::Serializer
  attributes :id,
            :name,
            :email,
            :role,
            :created_at,
            :updated_at,
            :some_message


  has_many :courses

  def some_message
    "Hi my name is #{self.object.name}, I am a #{self.object.role} nice to meet you"
  end
end
