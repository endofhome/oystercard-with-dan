require 'journeylog'

describe JourneyLog do 

  subject(:journeylog) { described_class.new }
  let(:journey) {double :journey, entry_station: :old_street, pass_entry: :old_street, exit_station: :baker_street, pass_exit: :baker_street, fare: 1}
  let(:part_journey) {double :part_journey, entry_station: :old_street, pass_entry: :old_street, exit_station: nil, pass_exit: nil, fare: 1}
  let(:station) { double :station, name: :old_street, zone: 2}

  describe 'initialization' do
    it 'has a default journey of nil' do 
      expect(journeylog.current_journey).to be_nil
    end

    it 'the list of journeys is empty' do 
      expect(journeylog.journeys).to be_empty
    end
  end

  describe '#start_journey' do
    it 'updates @journey when journey started' do
      journeylog.start_journey(station, journey)
      expect(journeylog.current_journey).to eq journey
    end
  end

  describe '#exit_journey' do
    before(:each) do
      journeylog.start_journey(station, journey)
    end

    it 'adds multiple journeys to @journeys history' do
      journeylog.exit_journey(station)
      journeylog.start_journey(station, journey)
      journeylog.exit_journey(station)
      expect(journeylog.journeys.length).to eq 2
    end

    it 'updates @journeys when touched out' do
      expect { journeylog.exit_journey(station) }.to change{ journeylog.journeys }.to [journey]
    end
  end

  context '#outstanding_charges'do
    it "records the journey if user doesn't previously touch out" do #
      journeylog.start_journey(station, part_journey)
      journeylog.outstanding_charges
      expect(journeylog.journeys).to include part_journey
    end
    it 'it reassigns journey from a journey object back to nil' do
      journeylog.exit_journey(station)
      expect(journeylog.current_journey).to be nil
    end
    it 'is expected to return the fare' do 
      journeylog.start_journey(station, journey)
      expect(journeylog.outstanding_charges).to eq 1
    end
  end
end