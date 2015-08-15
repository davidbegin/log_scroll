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
      lines
    end

    def log(log_entry)
      File.open(file_name, "a+") do |file|
        file.write(log_entry)
        file.write("\n")
      end

      delete_oldest_entry!
    end

    def entries
      @lines
    end

    def newest_entry
      @lines.last
    end

    def oldest_entry
      @lines.first
    end

    private

    attr_reader :file_name, :max_size

    def delete_oldest_entry!
      if line_count > max_size
        File.open(file_name, "w+") do |file|
          @lines.shift
          file.write(@lines.join(""))
        end
      end
    end

    def log_file
      @log_file ||= File.open(file_name, "r+")
    end

    def lines
      @lines ||= Array(log_file.each_line.to_a)
    end

    def line_count
      @line_count ||= lines.count
    end

    def find_create_history_file!
      unless File.exists? file_name
        FileUtils.touch file_name
      end
    end
  end
end
