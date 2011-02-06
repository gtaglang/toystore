module Toy
  module Identity
    extend ActiveSupport::Concern

    included do
      key Toy.key_factory
    end

    module ClassMethods
      def key(name_or_factory = :uuid)
        @key_factory = case name_or_factory
        when :uuid
          UUIDKeyFactory.new
        when :object_id
          require 'toy/identity/object_id_key_factory'
          ObjectIdKeyFactory.new
        else
          if name_or_factory.respond_to?(:next_key) &&
             name_or_factory.respond_to?(:key_type)
            name_or_factory
          else
            raise InvalidKeyFactory.new(name_or_factory)
          end
        end
        attribute :id, @key_factory.key_type
        @key_factory
      end

      def key_type
        @key_factory.key_type
      end

      def next_key(object = nil)
        @key_factory.next_key(object).tap do |key|
          raise InvalidKey.new if key.nil?
        end
      end
    end
  end
end
