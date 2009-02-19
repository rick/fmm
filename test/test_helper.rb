require 'test/unit'

Dir[File.dirname(__FILE__)+'/../lib/gems/**'].each do |dir| 
  $:.unshift File.directory?(lib = "#{dir}/lib") ? lib : dir
end

require 'context'
require 'stump'
require 'matchy'
require 'pending'
