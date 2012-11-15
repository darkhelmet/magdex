require 'rspec'
load 'magdex.rb'
load 'magdex/store.rb'

class Person
  self.__fixed_instvars :@id, :@name

  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
