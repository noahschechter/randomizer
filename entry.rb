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
		
	end

	def self.all
		@@all
	end

	def self.randomize_by_attribute(attribute, num_of_teams)
		@@all
	end

end