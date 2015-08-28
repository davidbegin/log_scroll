require_relative "log_scroll/version"
require "fileutils"

module LogScroll
  def self.new(file_name:, max_size: 100)
    Scroll.new(file_name: file_name, max_size: max_size)
  end

  class Scroll

    def initialize(file_name:, max_size:)
      @file_name = file_name
      @max_size  = max_size
      find_create_history_file!
      entries
    end

    def log(log_entry)
      append_log_entry(log_entry)
    end

    def entries
      @entries ||= Array(log_file.each_line.to_a)
    end

    def newest_entry
      @entries.last
    end

    def oldest_entry
      @entries.first
    end

    def entry_count
      entries.count
    end

    private

    attr_reader :file_name, :max_size

    def append_log_entry(log_entry)
      @entries.shift if entry_count == max_size
      if entry_count >= max_size
        ((entry_count + 1) - max_size).times { @entries.shift }
      end

      @entries << "#{log_entry}\n"

      File.open(file_name, "w+") do |file|
        file.write(@entries.join(""))
      end
    end

    def log_file
      File.open(file_name, "r+")
    end

    def find_create_history_file!
      unless File.exists? file_name
        FileUtils.touch file_name
      end
    end
  end
end
