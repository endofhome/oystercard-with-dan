require 'journey'

describe Journey do

subject(:journey) {described_class.new}

  context '#complete' do
    it 'defaults to false' do
      expect(journey.complete?).to be false
    end
    it 'after passing exit station only it will not be complete' do
      journey.pass_exit(:exit_station)
      expect(journey).not_to be_complete
    end
    it 'after passing entry and exit station it will be complete' do
      journey.pass_entry(:entry_station)
      journey.pass_exit(:exit_station)
      expect(journey).to be_complete
    end
    it 'after passing entry station only it will not be complete' do
      journey.pass_entry(:entry_station)
      expect(journey).not_to be_complete
    end
    it 'after passing exit station only it will not be complete' do
      journey.pass_exit(:exit_station)
      expect(journey).not_to be_complete
    end
  end

  context '#pass_entry' do
    it 'stores entry station as variable' do
      journey.pass_entry(:entry_station)
      expect(journey.entry_station).to eq :entry_station
    end
  end

  context '#pass_exit' do
    it 'stores an exit station as a variable' do
      journey.pass_exit(:exit_station)
      expect(journey.exit_station).to eq :exit_station
    end
  end

  context '#fare' do
    it 'a minimum fare is calculated if a full journey is completed' do
      journey.pass_entry(:entry_station)
      journey.pass_exit(:exit_station)
      expect(journey.fare).to eq Journey::MIN_FARE
    end

    it 'a penalty fare is calculated if touched in but not touched out' do
      journey.pass_entry(:entry_station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'a penalty fare is calculated if touched out but not touched in' do
      journey.pass_exit(:exit_station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end