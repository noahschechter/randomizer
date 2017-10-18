class Entry

	attr_accessor :name, :email, :department

	@@all = []
	@@teams = {}

	def initialize(name:, email:, department:)
		self.name = name
		self.email = email
		self.department = department

		@@all << self
	end

	def self.new_from_csv_entry(entry)
		return if entry[0].nil?
		Entry.new(name: "#{entry[0]} #{entry[1]}", email: entry[2], department: entry[4])				
	end

	def self.randomize_by_department(num_of_teams)
		amt_per_team = self.all().count / num_of_teams

		entries_by_department = {}

		# Seperating out the entries by department

		Entry.all().each do |entry|
			dept = entry.department
			if entries_by_department[dept]
				entries_by_department[dept].push(entry)
			else
				entries_by_department[dept] = [entry]
			end
		end

		# Sorting the departments by size

		sorted_entries_by_department = entries_by_department.sort_by { |k, v| v.count }.to_h

		# Shuffling those new tables

		sorted_entries_by_department.each do |key, value|
			value.shuffle!
		end

		# Creating the teams

		for i in 1..num_of_teams do
			@@teams["team#{i}"] = []			
		end
		
		# Assembling the teams

		copy_of_entries = Marshal.load(Marshal.dump(sorted_entries_by_department))

		i = 1

		while !self.get_active_departments(copy_of_entries).empty?
			active_departments = self.get_active_departments(copy_of_entries)

			random_department = active_departments.keys.sample

			while copy_of_entries[random_department].size > 0 do
				i = 1 if i === 16

				random_entry = copy_of_entries[random_department].sample
				@@teams["team#{i}"].push(random_entry)
				copy_of_entries[random_department].delete(random_entry)

				i += 1
			end
		end

	end

	def self.get_active_departments(departments)
		active_departments = departments.select { |k, v| v.count > 0}
		active_departments
	end
	
	def self.teams
		@@teams
	end

	def self.all
		@@all
	end

	def to_s
		puts "Name: #{self.name} - Email: #{self.email} - Department: #{self.department}"
	end

end