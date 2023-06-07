class TransactionsController < ApplicationController
  # TODO: Add a check for development environment
  skip_before_action :verify_authenticity_token, only: [:update_transactions]

  def index
    render json: Transaction.all
  end

  def update_transactions
    transactions_data = params.require(:transactions)

    transactions_data.each do |transaction_data|
      p transaction_data[:id]
      transaction = Transaction.find(transaction_data[:id])
      transaction.update(transaction_params(transaction_data))
    end
  
    Transaction.all. each do |transaction|
      p transaction.category
      p transaction.reviewed
    end
    
    render json: Transaction.all
  end 

  private

  def transaction_params(transaction_data)
    transaction_data.permit(:id, :category, :reviewed)
  end
end
