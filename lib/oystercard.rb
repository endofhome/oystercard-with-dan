require 'journey'
require 'station'

class OysterCard

  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance, :journey, :journeys

  def initialize
    @balance = 0
    @journey = nil
    @journeys = []
  end

  def touch_in(station, journey_klass=Journey.new)
    raise "min funds not available" if balance < MIN_FARE
    journey_klass.pass_entry(station)
    @journey = journey_klass
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey.pass_exit(station)
    @journeys.push(@journey)
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
