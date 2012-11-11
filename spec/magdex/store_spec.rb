require 'spec_helper'

describe Magdex::Store do
  it 'should require a name' do
    lambda { Magdex::Store.new }.should raise_exception(ArgumentError)
    Magdex::Store.new(:batman).name.should be(:batman)
  end
end
