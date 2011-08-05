require "arel_or/version"
require 'arel_or/or'

module ArelOr
  ActiveRecord::Base.send :include, Or
end
