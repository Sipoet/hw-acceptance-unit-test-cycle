class Movie < ActiveRecord::Base

  scope :with_director, ->(director){where(director: director)}
end
