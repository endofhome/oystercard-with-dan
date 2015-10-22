class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    !!entry_station
  end

  def pass_entry station
    @entry_station = station
  end

  def pass_exit station
    @exit_station = station
  end

  def fare
    ( !!@entry_station && !!@exit_station ) ? MIN_FARE : PENALTY_FARE
  end

end