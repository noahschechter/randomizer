require_relative './entry'
require 'csv'

CSV_PATH = "./entries.csv"

def run
	load_entries()
	Entry.randomize_by_attribute("department", 15)
	Entry.all().each { |entry| puts entry.name }
end

def load_entries()
	CSV.foreach(CSV_PATH) do |row|
	  Entry.new_from_csv_entry(row)
	end rescue handle_error()

	test = Entry.new(name: "Yo", email: "yo@email.com", department: "Engineering")
	test2 = Entry.new(name: "Hey", email: "hey@email.com", department: "Engineering")
end

def handle_error()
	puts "Oops! Looks like '#{CSV_PATH}' doesn't exist"
end

run()