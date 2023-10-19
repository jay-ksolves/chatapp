# frozen_string_literal: true

class User < ApplicationRecord
  validates_uniqueness_of :username, presence: true
  validates_presence_of :email
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to 'users' }
  has_many :messages, dependent: :destroy
end
