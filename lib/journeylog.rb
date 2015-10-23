require_relative 'journey'

class JourneyLog

  attr_reader :current_journey, :journeys

  def initialize
    @current_journey = nil
    @journeys = []
  end

  def start_journey (station, journey_klass=Journey.new)
    journey_klass.pass_entry(station)
    @current_journey = journey_klass
  end

  def exit_journey (station, journey_klass=Journey.new)
    @current_journey ||= journey_klass
    @current_journey.pass_exit(station)
    outstanding_charges
  end

  def outstanding_charges
    @journeys << @current_journey
    fare = current_journey.fare
    @current_journey = nil
    fare
  end

  def in_journey?
    current_journey != nil
  end

end