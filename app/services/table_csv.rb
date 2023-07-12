require "csv"

class TableCsv
  def initialize(dir_name,file_name)
    @dir_name = dir_name
    @file_name = file_name
    @table_name = File.basename(@file_name, '.csv')
    @model = @table_name.classify.constantize
  end

  def file_path
    "#{@dir_name}#{@file_name}"
  end

  def truncate_table
    ActiveRecord::Base.connection.execute("TRUNCATE #{@table_name}")
  end

  def load_csv
    @text = File.read(file_path)
  end

  def load_escape_csv
    @text = File.read(file_path).gsub(/(?<!\\)\\"/,'""')
  end

  def create_model
    CSV.parse(@text, headers: true, header_converters: :symbol) do |row|
      @model.create(row.to_hash)
    end
  end
end