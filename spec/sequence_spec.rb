require 'rspec'
require_relative '../sequence'

describe Sequence do

  it "knows a valid sequence" do
    expect(Sequence.new(1, 1, 2, 3, 8)).to be_valid
  end

  it "marks out of order sequences as invalid" do
    expect(Sequence.new(1, 1, 3, 2, 8)).not_to be_valid
  end

  it "can tell if the sum is 15" do
    expect(Sequence.new(7, 8)).to be_correct_sum
  end

  it "can tell if the sum is 15" do
    expect(Sequence.new(7, 8, 1)).not_to be_correct_sum
  end

  it "has digit pair" do
    expect(Sequence.new(1, 1, 3)).to have_digit_pair
  end

  it "does not have digit pair" do
    expect(Sequence.new(1, 2, 3)).not_to have_digit_pair
  end

  it "has digit trio" do
    expect(Sequence.new(1, 1, 1, 3)).to have_digit_pair
  end

  it "does not have digit trio" do
    expect(Sequence.new(1, 2, 3)).not_to have_digit_pair
  end

  it "can tell if it is in order" do
    expect(Sequence.new(1, 2, 3)).to be_in_order
  end

  it "can tell if it is in order" do
    expect(Sequence.new(3, 2, 1)).not_to be_in_order
  end

  it "transitions at the start" do
    expect(Sequence.new.next.items).to eq([1])
  end

  it "transitions at the start" do
    expect(Sequence.new(1).next.items).to eq([1, 1])
  end

  it "transitions at the start again " do
    expect(Sequence.new(1, 1).next.items).to eq([1, 1, 1])
  end

  it "breaks if there is a trio" do
    expect(Sequence.new(1, 1, 1).next.items).to eq([1, 1, 2])
  end

  it "breaks if over 15 " do
    expect(Sequence.new(1, 1, 2, 2, 3, 3, 4).next.items).to eq([1, 1, 2, 2, 3, 4])
  end

  it "rolls over after 9" do
    expect(Sequence.new(1, 9, 5).next.items).to eq([2])
  end

  it "rolls over after 9" do
    expect(Sequence.new(9, 6).next).to eq(nil)
  end

  it "makes a canonical value" do
    expect(Sequence.new(1, 9, 5).canonical_items).to eq([1, 5, 9])
  end

  it "orders sequences" do
    expect(Sequence.sequences.first.items).to eq([1])
  end

  it "orders sequences" do
    expect(Sequence.sequences.next.next.items).to eq([1, 1])
  end

end
