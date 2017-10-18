require_relative './entry'
require 'csv'
require 'pry'

CSV_PATH = "./bowling_data.csv"

def run
	load_entries()
	Entry.randomize_by_attribute("department", 15)
	Entry.all().each { |entry| puts entry.name }

	puts "Stats:\nTotal Entries: #{Entry.all().count}
	"
end

def load_entries()
	CSV.foreach(CSV_PATH, {:headers=>:first_row}) do |row|
	  Entry.new_from_csv_entry(row)
	end rescue handle_error()
end

def handle_error()
	puts "Oops! Looks like '#{CSV_PATH}' doesn't exist"
end

run()