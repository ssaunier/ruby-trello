module Trello

  # A colored Label attached to a card
  class Label < BasicData
    register_attributes :name, :color, :id,
      read_only: [ :id, :color ]

    class << self
      # @return [Array]
      def all_for_board(board_id)
        client.get("/boards/#{board_id}/labels").json_into(self)
      end
    end

    # Update the fields of a label.
    #
    # Supply a hash of stringkeyed data retrieved from the Trello API representing
    # a label.
    def update_fields(fields)
      attributes[:name]  = fields['name']
      attributes[:color] = fields['color']
      attributes[:id] = fields['id']
      self
    end

    def save
      client.put("/labels/#{id}/name", { value: attributes[:name] }).json_into(self)
    end

  end

end
