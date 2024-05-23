class User < ApplicationRecord
  has_many :grades
  has_many :courses, through: :grades

  enum role: { student: 0, admin: 1 }

  attribute :role, default: 'student'
end
