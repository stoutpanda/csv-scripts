#Script to clean up & help prepare csv export from CCURE 9000 for access.
#Authored on: 12/28/2015
#Export journal entries for CCURE 9000 (not a report), and then point this to the CSV file.


#csv library
require 'csv'
#date
require 'date'

#Source File:
input_file = 'JournalRaw.csv'
#output File:
output_file = 'JournalRaw_updated.csv'

csv_array = Array.new
edit_array = Array.new
date_array = Array.new
final_array = Array.new

#format dates
def bad_date(date)
	DateTime.strptime(date.gsub(/ /, '_'), "%d/%m/%Y_%I:%M:%S_%P").strftime("%m-%d-%Y")
end


#read csv and put it into an array of arrays
csv_array = CSV.read(input_file)

#create new mapped array and indexes
edit_array = csv_array.map { |row| row[4] }
date_array = edit_array.map { |row2| bad_date row2 }
final_array = date_array.uniq


#out put to csv file
CSV.open(output_file, "wb") do |csvfile|
	final_array.each do |row|
		csvfile << [row]
	end
end
