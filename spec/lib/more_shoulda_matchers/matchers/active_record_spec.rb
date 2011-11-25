require 'active_record'

describe 'including the matchers' do
  it 'should load the matchers into RSpec' do
    matchers_included?.should be_false

    require 'more_shoulda_matchers/matchers/active_record'

    matchers_included?.should be_true
  end

  def matchers_included?
    !!defined? ::RSpec::Matchers::AcceptsNestedAttributesForMatcher
  end
end
