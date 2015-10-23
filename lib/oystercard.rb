require_relative 'journeylog'
require_relative 'station'

class OysterCard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance

  def initialize(journeylog = Log.new)
    @journeylog = journeylog
    @balance = 0
  end

  def touch_in(station)
    raise "min funds not available" if balance < MIN_BALANCE
    journeylog.start_journey(station)
    deduct 
  end

  def touch_out(station)
    journeylog.exit_journey(station)
    deduct
  end

  def top_up(amount)
    fail "The maximum balance is #{MAX_BALANCE}" if amount + balance >= MAX_BALANCE
    @balance += amount
  end

  private
  attr_reader :journeylog

  def deduct
 	  @balance -= @journeylog.outstanding_charges
  end
end
