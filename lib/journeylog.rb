class JourneyLog

  attr_reader :journey, :journeys

  def initialize
    @journey = nil
    @journeys = []
  end

  def start_journey (station, journey_klass=Journey.new)
    # @journeys << @journey if in_journey?
    journey_klass.pass_entry(station)
    @journey = journey_klass
  end

  private

  def in_journey?
    journey != nil
  end

end