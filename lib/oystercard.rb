require_relative 'journey'
require_relative 'station'

class OysterCard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :journey, :journeys

  def initialize
    @balance = 0
    @journey = nil
    @journeys = []
  end

  def touch_in(station, journey_klass=Journey.new)
    raise "min funds not available" if balance < MIN_BALANCE
    @journeys << @journey if in_journey?
    deduct if in_journey? 
    journey_klass.pass_entry(station)
    @journey = journey_klass
  end

  def touch_out(station, journey_klass=Journey.new)
    @journey ||= journey_klass
    @journey.pass_exit(station)
    deduct
    @journeys << @journey
    @journey = nil
  end

  def top_up(amount)
    fail "The maximum balance is #{MAX_BALANCE}" if amount + balance >= MAX_BALANCE
    @balance += amount
  end

  private

  def deduct
 	  @balance -= @journey.fare
  end

  def in_journey?
    journey != nil
  end
end
