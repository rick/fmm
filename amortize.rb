class Amortize
  attr_reader :loan_value, :duration_years, :annual_rate
  
  def initialize(loan_value, duration_years, annual_rate)
    @loan_value = loan_value
    @duration_years = duration_years
    @annual_rate = annual_rate / 100.0
  end
  
  def monthly_rate
    annual_rate / 12.0
  end
  
  def duration_months
    duration_years * 12
  end
  
  def payment
    loan_value * monthly_rate / (1.0 - ((1.0 + monthly_rate) ** (-1.0 * duration_months)))
  end
  
  def show(amount)
    "%10s" % ("$%0.2f" % amount)
  end
  
  def display(month)
    result = ''
    result += "#{month / 12} years " if month > 12
    result += "#{month % 12} months (#{month + 1})"
    "%25s" % result
  end
  
  def amortization_table(options = {})
    current_principal = options[:current_principal] || loan_value
    additional_principal = options[:additional_principal] || 0.0

    total_paid = 0.0    
    month = 0

    while current_principal > 0.0
      interest_amount = current_principal * monthly_rate
      total_payment = payment + additional_principal
      total_payment = current_principal + interest_amount if total_payment > current_principal
      principal_amount = total_payment - interest_amount
      next_principal = current_principal - principal_amount
      total_paid += total_payment

      puts "#{display month}:  pay #{show total_payment}  interest #{show interest_amount}  principal #{show principal_amount}  remaining: #{show next_principal}  total: #{show total_paid}"
      current_principal = next_principal
      month += 1
    end

    puts "Total paid:  #{show total_paid}"
  end
end

start = ARGV.shift.to_i
duration = ARGV.shift.to_i
rate = ARGV.shift.to_f
extra = ARGV.shift.to_f
current = ARGV.shift.to_f
current = start if current.to_i == 0

Amortize.new(start, duration, rate).amortization_table(:current_principal => current, :additional_principal => extra)

# usage:
# ruby ./amortize.rb 120000 15 6.10 250 95000
#
# amortization table for a $120000 loan, 15 years (fixed), at 6.10%; current principal balance $95000, with $250 additional principal payment per month

