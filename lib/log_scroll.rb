require "log_scroll/version"

module LogScroll
  def self.new(file_name:, max_size: 100)
    Scroll.new(file_name: file_name, max_size: max_size)
  end

  class Scroll
    def initialize(file_name:, max_size:)
      @file_name = file_name
      @max_size  = max_size
    end

    def log(log_entry)
      File.open(file_name, "a+") do |file|
        file.write(log_entry)
        file.write("\n")
      end

      delete_oldest_entry!
    end

    private

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
      @lines ||= log_file.each_line.to_a
    end

    def line_count
      @line_count ||= lines.count
    end

    attr_reader :file_name, :max_size
  end
end

# scroll = LogScroll.new(file_name: "test.log", max_size: 4)
# scroll.log("hello4")
# p scroll
