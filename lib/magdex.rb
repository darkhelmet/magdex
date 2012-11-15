require 'magdex/store'

module Magdex
  VERSION = '0.0.1'
  extend self

  def store_for(key)
    store_hash.fetch(key) { store_hash[key] = Store.new(key) }
  end

  def stores
    store_hash.keys
  end

private

  def proot
    Maglev::PERSISTENT_ROOT
  end

  def store_hash
    proot.fetch(:magdex) { |k| proot[k] = {} }
  end
end
