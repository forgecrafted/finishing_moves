require 'spec_helper'

describe Array do

  let :sages do
    ['Rauru', 'Saria', 'Darunia', 'Princess Ruto', 'Nabooru', 'Impa', 'Zelda']
  end

  it '#to_indexed_hash' do
    expect { sages.to_indexed_hash("e") }.to raise_error(ArgumentError)
    sages_hash = sages.to_indexed_hash
    i = 0
    sages.each do |sage|
      expect(sages_hash[i]).to eq sage
      i += 1
    end

    sages_hash = sages.to_indexed_hash(22)
    i = 22
    sages.each do |sage|
      expect(sages_hash[i]).to eq sage
      i += 1
    end
  end

  it '#to_hash_values <#to_indexed_hash behaviour>' do
    sages_hash = sages.to_hash_values
    i = 0
    sages.each do |sage|
      expect(sages_hash[i]).to eq sage
      i += 1
    end

    block = proc { |key| key + 1 }
    sages_hash = sages.to_hash_values 0, &block
    i = 0
    sages.each do |sage|
      expect(sages_hash[i]).to eq sage
      i += 1
    end

    sages_hash = sages.to_hash_values(22)
    i = 22
    sages.each do |sage|
      expect(sages_hash[i]).to eq sage
      i += 1
    end
  end

  it '#to_hash_values' do
    block = proc { |key| key + 3 }
    sages_hash = sages.to_hash_values 0, &block
    i = 0
    sages.each do |sage|
      expect(sages_hash[i]).to eq sage
      i += 3
    end

    sages_hash = sages.to_hash_values 22, &block
    i = 22
    sages.each do |sage|
      expect(sages_hash[i]).to eq sage
      i += 3
    end

    # alias check
    expect(sages.to_hash_as_values(22, &block)).to eq sages_hash
  end

  it '#to_hash_keys' do
    sages_hash = sages.to_hash_keys
    # alias check
    expect(sages.to_hash_as_keys).to eq sages_hash

    sages.each do |sage|
      expect(sages_hash[sage]).to eq 0
    end

    sages_hash = sages.to_hash_keys('foobar')
    sages.each do |sage|
      expect(sages_hash[sage]).to eq 'foobar'
    end

    sages_hash = sages.to_hash_keys { |key| key + "1" }
    sages.each do |sage|
      expect(sages_hash[sage]).to eq sage + "1"
    end
  end

end
