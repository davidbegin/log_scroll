require_relative "../lib/log_scroll"

p scroll = LogScroll.new(file_name: "test.log", max_size: 4)
scroll.log("hello my new friend")
scroll.log("hello my old friend")
puts "Oldest Entry: " + scroll.oldest_entry.to_s
puts "Newest Entry: " + scroll.newest_entry.to_s
