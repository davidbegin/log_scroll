require "log_scroll/version"
require "log_scroll/scroll"

module LogScroll
  def self.new(file_name:, max_size: 100)
    Scroll.new(file_name: file_name, max_size: max_size)
  end
end
