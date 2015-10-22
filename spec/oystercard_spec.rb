require 'oystercard'

describe OysterCard do

  subject(:oystercard) { described_class.new }

  # let(:entry_station) {double :entry_station, name: :old_street, zone: 1 }
  # let(:exit_station) {double :exit_station, name: :baker_street, zone: 2 }

  # let(:journey_entry) { double :journey_entry, entry_station: :old_street, pass_entry: entry_station, pass_exit: exit_station}
  # let(:journey_exit) {double :journey_exit, entry_station: :old_street, pass_entry: entry_station, exit_station: :baker_street, pass_exit: exit_station}

  let(:journey) {double :journey, entry_station: :old_street, pass_entry: :old_street, exit_station: :baker_street, pass_exit: :baker_street}

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

  end

  describe '#touch_out' do

    it 'deducts the fare on touch out' do
      oystercard.top_up(10)
      oystercard.touch_in(station, journey)
      expect{ oystercard.touch_out(station) }.to change { oystercard.balance }.by -OysterCard::MIN_FARE
    end

    it 'adds a journey to @journeys history' do
      oystercard.top_up(10)
      oystercard.touch_in(station, journey)
      expect{ oystercard.touch_out(station) }.to change { oystercard.journeys.length }.by 1
    end

    it 'updates @journeys when touched out' do
      oystercard.top_up(10)
      oystercard.touch_in(station, journey)
      expect { oystercard.touch_out(station) }.to change{ oystercard.journeys }.to [journey]
    end
  end
end











