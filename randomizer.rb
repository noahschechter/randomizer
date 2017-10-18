require_relative './entry'
require 'csv'
require 'pry'

CSV_PATH = "./bowling_data.csv"

def run
	load_entries()
	Entry.randomize_by_department(15)
	write_results()

	puts "Stats:\nTotal Entries: #{Entry.all().count}"
end

def write_results()
	CSV.open("results.csv", "w") do |csv|
		csv << ["Name", "Email", "Department"]

		Entry.teams.each do |team|
			csv << [team[0].capitalize]
			csv << [""]
			team[1].each do |entry|
				csv << [entry.name, entry.email, entry.department]
			end
			csv << [""]
		end
	end
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