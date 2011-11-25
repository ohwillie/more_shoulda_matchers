require 'more-shoulda-matchers/matchers/active_record/accepts_nested_attributes_for_matcher'

module RSpec
  module Matchers
    include MoreShouldaMatchers::ActiveRecord
  end
end
