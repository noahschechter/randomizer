class Entry

	attr_accessor :name, :email, :department

	@@all = []

	def initialize(name:, email:, department:)
		self.name = name
		self.email = email
		self.department = department

		@@all << self
	end

	def self.new_from_csv_entry(entry)
		Entry.new(name: "#{entry[0]} #{entry[1]}", email: entry[2], department: entry[4])				
	end

	def self.randomize_by_attribute(attribute, num_of_teams)
		amt_per_team = self.all().count / num_of_teams

		puts amt_per_team
	end

	def self.all
		@@all
	end

end