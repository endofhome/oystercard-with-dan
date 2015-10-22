class Journey

  attr_reader :entry_station, :exit_station

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

end