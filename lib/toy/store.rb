module Toy
  module Store
    extend ActiveSupport::Concern

    include Toy::Object
    include Identity
    include Persistence
    include MassAssignmentSecurity
    include DirtyStore
    include Querying
    include Reloadable

    include Callbacks
    include Validations
    include Timestamps

    include Lists
    include References
    include AssociationSerialization

    include IdentityMap
    include Caching
    include Indices
  end
end
