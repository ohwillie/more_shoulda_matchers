require 'active_record'

require 'more_shoulda_matchers/matchers/active_record/accepts_nested_attributes_for_matcher'

module MoreShouldaMatchers
  describe ActiveRecord do
    context '#accept_nested_attributes_for' do
      subject { stub.extend(ActiveRecord) }

      it 'should create a new matcher object' do
        association = :association

        ActiveRecord::AcceptsNestedAttributesForMatcher.
          should_receive(:new).
          with(:association)

        subject.accept_nested_attributes_for(:association)
      end
    end
  end

  module ActiveRecord
    describe AcceptsNestedAttributesForMatcher do
      let(:klass) { AcceptsNestedAttributesForMatcher }

      let(:instance) { klass.new(:association) }

      context '#matches?' do
        subject { instance.matches?(model) }

        describe 'when the model accepts nested attributes for an association' do
          let(:model) do
            define_model do
              has_one :association
              accepts_nested_attributes_for :association
            end
          end

          it 'should be true' do
            subject.should be_true
          end
        end

        describe 'when the model does not accept nested attributes for an association' do
          let(:model) do
            define_model do
              has_one :association
            end
          end

          it 'should be false' do
            subject.should be_false
          end
        end

        describe 'when the model accepts nested attributes for a different association' do
          let(:model) do
            define_model do
              has_one :other_association
              accepts_nested_attributes_for :other_association
            end
          end

          it 'should be false' do
            subject.should be_false
          end
        end

        def define_model(&block)
          Class.new(::ActiveRecord::Base) { class_eval(&block) }
        end
      end

      context 'failure messages' do
        before(:each) do
          klass::GeneratesExpectationMessage.
            stub(:for_model_class_and_association).
            and_return('expectation')
        end

        context '#failure_message' do
          subject { instance.failure_message }

          it 'should give a failure message' do
            subject.should == "Expected expectation"
          end
        end

        context '#negative_failure_message' do
          subject { instance.negative_failure_message }

          it 'should give a failure message' do
            subject.should == "Did not expect expectation"
          end
        end
      end

      context '#description' do
        subject { instance.description }

        it 'should return a description based on the association' do
          subject.should == 'accept nested attributes for association'
        end
      end
    end

    class AcceptsNestedAttributesForMatcher
      describe GeneratesExpectationMessage do
        it 'should generate the expected message' do
          result = subject.
            for_model_class_and_association('model_class', 'association')

          result.should ==
            'model_class to accept nested attributes for association'
        end
      end
    end
  end
end
