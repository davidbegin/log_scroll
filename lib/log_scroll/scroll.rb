require "fileutils"

module LogScroll
  class Scroll

    # @param file_name [String] the name of the file to save log entries to
    # @param max_size [Integer] the number of entries to save before deleting the oldest
    #
    # The name of the file_name passed in will be found or created in the directory
    # LogScroll is loaded in.
    def initialize(file_name:, max_size:)
      @file_name = file_name
      @max_size  = max_size
      find_or_create_history_file!
      load_entries!
    end

    # saves the string passed in to the file LogScroll is initialized with
    #
    # @param log_entry [String] a string of what you would like to save
    def log(log_entry)
      append_log_entry(log_entry)
    end

    # @return [Array] returns every log entry saved
    #
    # @example
    #   ["Created File", "Saved file"]
    def entries
      @entries ||= Array(log_file.each_line.to_a)
    end

    # @return [String] returns the newest/last entry logged with LogScroll
    def newest_entry
      @entries.last
    end

    # @return [String] returns the oldest entry logged with LogScroll
    def oldest_entry
      @entries.first
    end

    # @return [Integer] returns the total number of entries currently saved
    def entry_count
      entries.count
    end

    private

    attr_reader :file_name, :max_size

    alias_method :load_entries!, :entries

    def append_log_entry(log_entry)
      delete_entries_past_limit!
      @entries << "#{log_entry}\n"
      write_entries_to_file!
    end

    def write_entries_to_file!
      File.open(file_name, "w+") do |file|
        file.write(@entries.join(""))
      end
    end

    def delete_entries_past_limit!
      @entries.shift if entry_count == max_size

      if entry_count >= max_size
        ((entry_count + 1) - max_size).times { @entries.shift }
      end
    end

    def log_file
      File.open(file_name, "r+")
    end

    def find_or_create_history_file!
      unless File.exists? file_name
        FileUtils.touch file_name
      end
    end
  end
end
