module Headings
  class Generator
    class InvalidData < ArgumentError; end

    def initialize(data)
      @data = data
    end

    def call
      return unless valid?

      @heading_counter = {}
      @data.each_with_index.inject('') do |memo, (element, i)|
        increment_heading_counter(element[:heading_level])
        memo << "\n" if i > 0
        memo << indentation(element[:heading_level])
        memo << index(element[:heading_level])
        memo << " #{element[:title].capitalize}"
      end
    end

    private

    def valid?
      raise InvalidData.new('Data is not an array') unless @data&.is_a?(Array)
      raise InvalidData.new('Data elements are not a hash') unless @data.all? { |element| element&.is_a?(Hash) }
      unless @data.all? { |element| element[:title]&.is_a?(String) }
        raise InvalidData.new('One of data elements does not have a title')
      end
      unless @data.all? { |element| element[:heading_level]&.is_a?(Integer) }
        raise InvalidData.new('One of data elements does not have a heading_level')
      end
      ids = @data.map{ |x| x[:id] }
      unless ids.uniq.length == ids.length
        raise InvalidData.new('Data elements ids are not unique')
      end

      true
    end

    def increment_heading_counter(heading_level)
      @heading_counter[heading_level] += 1 if @heading_counter[heading_level]
      (0..heading_level).each do |i|
        @heading_counter[i] ||= 1
      end
    end

    def indentation(heading_level)
      (0...heading_level).inject('') do |memo, _level|
        memo << "\t"
      end
    end

    def index(heading_level)
      (0..heading_level).inject('') do |memo, level|
        memo << "#{@heading_counter[level]}."
      end
    end
  end
end