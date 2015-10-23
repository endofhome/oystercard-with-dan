require_relative 'journeylog'
require_relative 'station'

class OysterCard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :journeylog

  def initialize(journeylog = JourneyLog.new)
    @journeylog = journeylog
    @balance = 0
  end

  def touch_in(station)
    raise "min funds not available" if balance < MIN_BALANCE
    deduct(journeylog.outstanding_charges) if journeylog.in_journey?
    journeylog.start_journey(station)
  end

  def touch_out(station)
    deduct(journeylog.exit_journey(station))
  end

  def top_up(amount)
    fail "The maximum balance is #{MAX_BALANCE}" if amount + balance >= MAX_BALANCE
    @balance += amount
  end

  private
  
  def deduct(amount)
 	  @balance -= amount
  end
end
