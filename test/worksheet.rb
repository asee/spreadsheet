#!/usr/bin/env ruby
# TestWorksheet -- Spreadsheet -- 30.09.2008 -- hwyss@ywesee.com

$: << File.expand_path('../lib', File.dirname(__FILE__))

require 'test/unit'
require 'spreadsheet'


module Spreadsheet
  class TestWorksheet < Test::Unit::TestCase
    def setup
      @book = Workbook.new
      @sheet = @book.create_worksheet
    end
    def test_cell_writer
      assert_nil @sheet[0,0]
      assert_equal 0, @sheet.column_count
      assert_equal 0, @sheet.row_count
      @sheet[0,0] = 'foo'
      assert_equal 'foo', @sheet[0,0]
      assert_equal 1, @sheet.column_count
      assert_equal 1, @sheet.row_count
      @sheet[1,0] = 'bar'
      assert_equal 1, @sheet.column_count
      assert_equal 2, @sheet.row_count
      @sheet[0,1] = 'bar'
      assert_equal 2, @sheet.column_count
      assert_equal 2, @sheet.row_count
      @sheet[1,0] = nil
      assert_equal 2, @sheet.column_count
      assert_equal 2, @sheet.row_count
      @sheet[0,1] = nil
      assert_equal 2, @sheet.column_count
      assert_equal 2, @sheet.row_count
    end
    def test_column_count
      assert_equal 0, @sheet.column_count
      @sheet.replace_row 3, nil, nil, 1, 2, 'foo, bar'
      assert_equal 3, @sheet.column_count
      @sheet.replace_row 8, nil, 'something', 4, 7, nil
      assert_equal 4, @sheet.column_count
      @sheet.replace_row 5, 4, 'something', 4, 7, nil
      assert_equal 5, @sheet.column_count
      @sheet.replace_row 5, nil, 'something', 4, 7, nil
      assert_equal 4, @sheet.column_count
      @sheet.replace_row 3
      assert_equal 4, @sheet.column_count
    end
    def test_row_count
      assert_equal 0, @sheet.row_count
      @sheet.replace_row 3, nil, nil, 1, 2, 'foo, bar'
      assert_equal 1, @sheet.row_count
      @sheet.replace_row 8, nil, 'something', 4, 7, nil
      assert_equal 6, @sheet.row_count
      @sheet.replace_row 5, 4, 'something', 4, 7, nil
      assert_equal 6, @sheet.row_count
      @sheet.replace_row 5, nil, 'something', 4, 7, nil
      assert_equal 6, @sheet.row_count
      @sheet.replace_row 3
      assert_equal 6, @sheet.row_count
      @sheet.delete_row 3
      assert_equal 5, @sheet.row_count
      @sheet.delete_row 3
      assert_equal 4, @sheet.row_count
      @sheet.delete_row 2
      assert_equal 4, @sheet.row_count
      @sheet.delete_row 2
      assert_equal 3, @sheet.row_count
    end
    def test_modify_column
      assert_equal 10, @sheet.column(0).width
      @sheet.column(1).width = 20
      assert_equal 10, @sheet.column(0).width
      assert_equal 20, @sheet.column(1).width
      @sheet.column(0).width = 30
      assert_equal 30, @sheet.column(0).width
      assert_equal 20, @sheet.column(1).width
    end

    def test_should_get_and_set_protect
      assert_nil @sheet.protect
      @sheet.protect = true
      assert @sheet.protect
    end

    def test_should_set_and_encrypt_password
      #abcdefghij == 0xFEF1 is the example at http://www.openoffice.org/sc/excelfileformat.pdf
      assert_nil @sheet.password
      @sheet.password = "abcdefghij"
      assert_equal 0xFEF1, @sheet.password
    end

  end
end
