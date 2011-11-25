module MoreShouldaMatchers
  module ActiveRecord
    def accept_nested_attributes_for association
      AcceptsNestedAttributesForMatcher.new association
    end

    class AcceptsNestedAttributesForMatcher
      def initialize association
        @association = association
      end

      def matches? model_class
        @model_class = model_class

        model_class_has_nested_attributes_option_for_association?
      end

      def failure_message
        "Expected #{expectation}"
      end

      def negative_failure_message
        "Did not expect #{expectation}"
      end

      def description
        "accept nested attributes for #{@association}"
      end

    private

      def model_class_has_nested_attributes_option_for_association?
        @model_class.nested_attributes_options.fetch @association
        true
      rescue IndexError
        false
      end

      def expectation
        GeneratesExpectationMessage.
          for_model_class_and_association @model_class, @association
      end

      module GeneratesExpectationMessage
        def self.for_model_class_and_association model_class, association
          "#{model_class} to accept nested attributes for #{association}"
        end
      end
    end
  end
end
