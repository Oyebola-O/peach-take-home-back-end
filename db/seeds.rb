require 'database_cleaner'
require 'csv'

class Seeds
  COLOR_SCALE_GREEN = '#DDF1A3'
  COLOR_SCALE_RED = '#FFC9C9'
  COLOR_SCALE_BLUE = '#B6E4FB'
  COLOR_SCALE_PINK = '#FFDAF9'
  COLOR_SCALE_BROWN = '#E5CBAF'
  COLOR_SCALE_YELLOW = '#FFECC6'

  CATEGORIES_MAP = [
    # INCOME
    ["Income", "🤑", COLOR_SCALE_GREEN],

    # SPENDING
    ["Food and Drink", "🍕", COLOR_SCALE_RED],
    ["Healthcare", "🏥", COLOR_SCALE_BROWN],
    ["Shops", "🛍", COLOR_SCALE_BLUE],
    ["Subscription Service", "📺", COLOR_SCALE_PINK],
    ["Travel", "✈️", COLOR_SCALE_YELLOW],
  ]

  MERCHANTS  = %w[Uber, United, Chiptole, Payroll, Amazon, Turbo Tax, Blue Cross, AMC, Netflix, Hulu]

  def update
      clean_db
      create_categories
      create_merchants
      create_transactions
      Rails.logger.info('Database is seeded')
  end

  private

  def clean_db
    DatabaseCleaner.clean_with :truncation
    Rails.logger.info('Database is cleaned')
  end

  def create_categories
    CATEGORIES_MAP.each do |c|
      name = c[0]
      emoji = c[1]
      color = c[2]

      Category.create(
        name: name,
        emoji: emoji,
        color: color,
      )
    end

    Rails.logger.info('Added Categories')
  end

  def create_merchants
    MERCHANTS.each do |m|
      Merchant.create(
        name: m,
      )
    end

    Rails.logger.info('Added Merchants')
  end

  def create_transactions
    csv_file = Rails.root.join('transactions.csv')

    CSV.foreach(csv_file, headers: true, header_converters: ->(h) { h.strip }) do |row|
      Transaction.create(
        transaction_name: row['Transaction Name'].strip,
        merchant: row['Merchant'].strip,
        amount: row['Amount'].strip,
        date: Date.strptime(row['Date'].strip, '%m/%d/%Y'),
        category: row['Category'].strip,
        reviewed: false,
      )
    end
    
    Rails.logger.info('Added Transactions')
  end
end

Seeds.new.update
