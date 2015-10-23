require 'journeylog'

describe JourneyLog do 

  subject(:journeylog) { described_class.new }
  let(:journey) {double :journey, entry_station: :old_street, pass_entry: :old_street, exit_station: :baker_street, pass_exit: :baker_street}
  let(:part_journey) {double :journey, entry_station: :old_street, pass_entry: :old_street, exit_station: nil, pass_exit: nil}
  let(:station) { double :station, name: :old_street, zone: 2}

  describe 'initialization' do
    it 'has a default journey of nil' do 
      expect(journeylog.journey).to be_nil
    end

    it 'the list of journeys is empty' do 
      expect(journeylog.journeys).to be_empty
    end
  end

  describe '#start_journey' do
    it 'updates @journey when journey started' do
      journeylog.start_journey(station, journey)
      expect(journeylog.journey).to eq journey
    end

    # it "records the journey if user doesn't previously touch out" do #
    #   journeylog.start_journey(station, part_journey)   
    #   journeylog.start_journey(station, part_journey)
    #   expect(journeylog.journeys).to include part_journey
    # end
  end

end