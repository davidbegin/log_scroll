require_relative "../lib/log_scroll"

scroll = LogScroll.new(file_name: "test.log", max_size: 4)
scroll.log("hello1")
puts "Oldest Entry: " + scroll.oldest_entry
puts "Newest Entry: " + scroll.newest_entry
