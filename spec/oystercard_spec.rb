require 'oystercard'

describe OysterCard do

  subject(:oystercard) { described_class.new }

  let(:journey) {double :journey, entry_station: :old_street, pass_entry: :old_street, exit_station: :baker_street, pass_exit: :baker_street}
  let(:part_journey) {double :journey, entry_station: :old_street, pass_entry: :old_street, exit_station: nil, pass_exit: nil}
  let(:station) { double :station, name: :old_street, zone: 2}


  describe 'initialization' do
    it 'has a default balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'has a default journey of nil' do
      expect(oystercard.journey).to be_nil
    end

    it 'the list of journeys is empty' do
      expect(oystercard.journeys).to be_empty
    end
  end

  describe '#top_up' do
    it 'the balance can be topped up' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end

    it 'has a maximum balance' do
      expect{ oystercard.top_up(OysterCard::MAX_BALANCE) }.to raise_error("The maximum balance is #{OysterCard::MAX_BALANCE}")
    end
  end

  describe '#touch_in' do

    it 'raises an error if min funds not available' do
      expect { oystercard.touch_in(station, journey) }.to raise_error "min funds not available"
    end

    it 'updates @journey when touched in' do
      oystercard.top_up 10
      expect { oystercard.touch_in(station, journey) }.to change{ oystercard.journey }.to journey
    end

    it "deducts penalty fare when user doesn't previously touch out" do
      allow(journey).to receive(:fare).and_return(6)
      oystercard.top_up 10
      oystercard.touch_in(station, journey)
      expect{ oystercard.touch_in(station, journey) }.to change { oystercard.balance }.by -6
    end

    it "reccords teh journey if user doesn't previously touch out" do
      allow(part_journey).to receive(:fare).and_return(6)
      oystercard.top_up 10
      oystercard.touch_in(station, part_journey)
      oystercard.touch_in(station, part_journey)
      expect(oystercard.journeys).to include part_journey
    end
  end

  describe '#touch_out' do

    before(:each) do
      allow(journey).to receive(:fare).and_return(OysterCard::MIN_BALANCE)
      oystercard.top_up(10)
      oystercard.touch_in(station, journey)
    end

    it 'deducts the fare on touch out' do
      expect{ oystercard.touch_out(station) }.to change { oystercard.balance }.by -OysterCard::MIN_BALANCE
    end

    it 'adds multiple journeys to @journeys history' do
      oystercard.touch_out(station)
      oystercard.touch_in(station, journey)
      oystercard.touch_out(station)
      expect(oystercard.journeys.length).to eq 2
    end

    it 'updates @journeys when touched out' do
      expect { oystercard.touch_out(station) }.to change{ oystercard.journeys }.to [journey]
    end

    it 'it reassigns journey from a journey object back to nil' do
      oystercard.touch_out(station)
      expect(oystercard.journey).to be nil
    end
  end
end











