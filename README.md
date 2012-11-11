# magdex

A MagLev indexer for the persistent root

# Usage

    Users = Magdex.store_for(:users)
    class User
      attr_accessor :id, :name

      def initialize(name)
        @name = name
      end
    end

    bob = User.new('Bob')
    id = Users.store(bob) # => 1
    bob.id == id # => true

    ...

    bob2 = Users.find(1)
    bob2.name # => "Bob"
    bob == bob2 # => true

    Users.index_by(:name) # => true

    bob3 = Users.find_by(:name => 'Bob').first
    bob3.name # => "Bob"
    bob3 == bob2 # => true

    Users.index_by(:name, :unique => true) # => false
    Users.remove_index(:name) # => true
    Users.index_by(:name, :unique => true) # => true

    bob4 = Users.find_by(:name => 'Bob')
    bob4.name # => "Bob"
    bob4 == bob3 # => true
