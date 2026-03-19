# frozen_string_literal: true

class Disbursement
  class Incoming
    include Base

    def hcb_code
      disbursement.incoming_hcb_code
    end

    def event
      disbursement.destination_event
    end

    delegate :amount, to: :disbursement

    def subledger
      disbursement.destination_subledger
    end

    def transaction_category
      disbursement.destination_transaction_category
    end

    def canonical_transactions
      @canonical_transactions ||= disbursement.canonical_transactions.where("amount_cents > 0")
    end

    def canonical_pending_transactions
      @canonical_pending_transactions ||= disbursement.canonical_pending_transactions.where("amount_cents > 0")
    end

    def pending_expired?
      canonical_pending_transactions.pending_expired.any?
    end

    # Label for sharing comments with the other side (source)
    def shared_comment_recipient_label
      card_grant = source_subledger&.card_grant
      card_grant ? "Grant to #{card_grant.user.name}" : source_event.name
    end

  end

end
