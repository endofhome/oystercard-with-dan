require 'journey'

describe Journey do

  it '#complete? defaults to false' do
    expect(subject.complete?).to be false
  end

  it 'stores entry station as variable' do
    subject.pass_entry(:entry_station)
    expect(subject.entry_station).to eq :entry_station
  end

  it 'after passing entry station only it will not be complete' do
    subject.pass_entry(:entry_station)
    expect(subject).not_to be_complete
  end

  it 'after passing exit station only it will not be complete' do
    subject.pass_exit(:exit_station)
    expect(subject).not_to be_complete
  end

  it 'after passing entry and exit station it will be complete' do
    subject.pass_entry(:entry_station)
    subject.pass_exit(:exit_station)
    expect(subject).to be_complete
  end

  it 'stores an exit station as a variable' do
    subject.pass_exit(:exit_station)
    expect(subject.exit_station).to eq :exit_station
  end

  it 'a minimum fare is calculated if a full journey is completed' do
    subject.pass_entry(:entry_station)
    subject.pass_exit(:exit_station)
    expect(subject.fare).to eq Journey::MIN_FARE
  end

  it 'a penalty fare is calculated if touched in but not touched out' do
    subject.pass_entry(:entry_station)
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'a penalty fare is calculated if touched out but not touched in' do
    subject.pass_exit(:exit_station)
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
end