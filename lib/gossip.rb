# frozen_string_literal: true
require 'pry'
# Class
class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    all_gossips
  end

  def self.find(id)
    # todo
    gossips = all
    gossips[id - 1]
  end

  def self.update(author, content, id)
    # I need id as a parameter
    # access id-1
    @author = author
    @content = content
    csv = CSV.open('./db/gossip.csv')
    array_csv = csv.to_a
    array_csv[id - 1][0] = author
    array_csv[id - 1][1] = content

    CSV.open('./db/gossip.csv', 'wb') do |item|
      array_csv.each { |line| item << line }
    end

  end
end

# Gossip.new('','').update('new','new_contend')