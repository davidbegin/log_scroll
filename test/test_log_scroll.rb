require_relative 'minitest_helper'

class TestLogScroll < Minitest::Test
  def setup
    create_test_file!
    @subject = LogScroll.new(file_name: "test_file.log")
  end

  def teardown
    if File.exists? "test_file.log"
      FileUtils.rm "test_file.log"
    end
  end

  def test_it_creates_the_log_file_if_does_not_exist
    refute File.exists? "tmp_test_file.log"
    LogScroll.new(file_name: "tmp_test_file.log")
    assert File.exists? "tmp_test_file.log"
    FileUtils.rm "tmp_test_file.log"
  end

  def test_it_loads_the_entries_from_the_file_on_initialize
    assert_equal @subject.entries.map(&:chomp), ["Entry 1", "Entry 2"]
  end

  def test_newest_entry_returns_the_newest
    assert_equal @subject.newest_entry.chomp, "Entry 2"
  end

  def test_oldest_entry_returns_the_oldest
    assert_equal @subject.oldest_entry.chomp, "Entry 1"
  end

  def test_enntry_count_is_a_real_thing
    assert_equal @subject.entry_count, 2
  end

  def test_log_adds_a_new_entry
    old_entry_count = @subject.entries.count
    @subject.log("Entry 3")
    assert_equal old_entry_count + 1, @subject.entries.count
    assert_equal @subject.newest_entry.chomp, "Entry 3"
  end

  def test_it_delete_the_last_entry_if_max_size_reached
    subject = LogScroll.new(file_name: "test_file.log", max_size: 2)
    subject.log("Entry 3")
    assert_equal subject.entries.count, 2
    assert_equal subject.entries.map(&:chomp), ["Entry 2", "Entry 3"]
  end

  def test_it_deletes_all_extra_lines_over_max
    subject = LogScroll.new(file_name: "test_file.log", max_size: 1)
    subject.log("Entry 3")
    assert_equal subject.entries.count, 1
    assert_equal subject.entries.map(&:chomp), ["Entry 3"]
  end

  def test_that_it_has_a_version_number
    refute_nil ::LogScroll::VERSION
  end

  private

  def create_test_file!
    File.open("test_file.log", "w+") do |file|
      file.write("Entry 1\n")
      file.write("Entry 2\n")
    end
  end
end
