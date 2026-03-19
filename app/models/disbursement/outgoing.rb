# frozen_string_literal: true

class Disbursement
  class Outgoing
    include Base

    def hcb_code
      disbursement.outgoing_hcb_code
    end

    def event
      disbursement.source_event
    end

    def amount
      -disbursement.amount
    end

    def subledger
      disbursement.source_subledger
    end

    def transaction_category
      disbursement.source_transaction_category
    end

    # Label for sharing comments with the other side (destination)
    def shared_comment_recipient_label
      card_grant = destination_subledger&.card_grant
      card_grant ? "Grant to #{card_grant.user.name}" : destination_event.name
    end

  end

end
