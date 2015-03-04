class Sequence

  attr_accessor :items

  def initialize(*items)
    @items = items.flatten
  end

  def valid?
    has_digit_pair? && correct_sum? && !has_digit_trio? && in_order?
  end

  def sum
    return 0 if items.empty?
    items.inject(:+)
  end

  def empty?
    items.empty?
  end

  def correct_sum?
    sum == 15
  end

  def canonical_items
    items.dup.sort
  end

  def has_digit_pair?
    value = Set.new
    items.each do |item|
      return true if value.include?(item)
      value << item
    end
    false
  end

  def has_digit_trio?
    singles = Set.new
    doubles = Set.new
    items.each do |item|
      return true if doubles.include?(item)
      doubles << item if singles.include?(item)
      singles << item
    end
    false
  end

  def in_order?
    canonical_items == items
  end

  def next
    new_items = items.dup
    if has_digit_trio?
      new_items[-1] += 1
    elsif sum >= 15
      new_items = new_items[0 ... -1]
      if new_items[-1] == 9
        return nil if new_items.size == 1
        new_items = new_items[0 ... -1]
      end
      new_items[-1] += 1
    else
      new_items << 1
    end
    Sequence.new(new_items)
  end

  def self.sequences
    Enumerator.new do |y|
      sequence = Sequence.new
      while sequence
        sequence = sequence.next
        break unless sequence
        y << sequence
      end
    end
  end

  def self.answer
    results = sequences.select(&:valid?)
    results.each { |s| p s.items }
    results.count
  end
end
