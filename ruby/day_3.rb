# Modify the CSV application to support an "each" method to return a 
# CsvRow object. Use "method_missing" on that CsvRow to return the value 
# for the column for a given heading

# For example, for the file:
# one, two
# lions, tigers

# allow an API that works like this:
# csv = RubyCsv.new
# csv.each{|row| puts row.one}

# this should print "lions"

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    attr_accessor :headers, :csv_contents

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(__dir__ + "/" + filename)
      
      @headers = file.gets.chomp.split(', ')
      
      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    def each(&block)
      csv_contents.each do |row|
        yield CsvRow.new(headers, row)
      end 
    end

    def initialize
      read
    end
  end

  class CsvRow
    attr_reader :row

    def initialize(headers, values)
      @row = Hash[headers.map.with_index{|h,i| [h, values[i]]}]
    end

    def method_missing(name, *args)
      get_col(name.to_s) || "No such column"
    end

    def get_col(name)
      row[name]
    end
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new
m.each{|row| puts row.one}
m.each{|row| puts row.two}
m.each{|row| puts row.four}
