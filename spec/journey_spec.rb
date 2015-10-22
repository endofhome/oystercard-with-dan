require 'journey'

describe Journey do

  it 'in_journey defaults to false' do
    expect(subject.in_journey?).to be false
  end

  it 'stores entry station as variable' do
    subject.pass_entry(:entry_station)
    expect(subject.entry_station).to eq :entry_station
  end

  it 'after passing entry station it will be in journey' do
    subject.pass_entry(:entry_station)
    expect(subject).to be_in_journey
  end

  it 'after passing exit station it will not be in journey' do
    subject.pass_exit(:exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'stores an exit station as a variable' do
    subject.pass_exit(:exit_station)
    expect(subject.exit_station).to eq :exit_station
  end
end