require 'spec_helper'

module Trello
  describe Label do
    include Helpers

    let(:label) { Label.new(JSON.generate(label_details.first)) }
    let(:client) { Trello.client }

    context "fields" do
      it "gets its id" do
        label.id.should_not be_nil
      end

      it "gets its name" do
        label.name.should_not be_nil
      end

      it "gets its color" do
        label.color.should_not be_nil
      end
    end

    context "finding" do
      it "gets all labels for a given board" do
        client.should_receive(:get).with("/boards/abcdef123456789123456789/labels").and_return label_payload
        Label.all_for_board('abcdef123456789123456789')
      end
    end

    context "updating" do
      it "updates the label name" do
        expected_new_name = "xxx"

        payload = {
          value: expected_new_name,
        }

        result = JSON.generate(label_details.first.merge(name: expected_new_name))
        client.should_receive(:put).once.with("/labels/id/name", payload).and_return result

        label.name = expected_new_name
        label.save
      end
    end
  end
end