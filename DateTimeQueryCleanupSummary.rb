#Script to clean up & help prepare csv export from CCURE 9000 for access.
#Authored on: 12/28/2015
#Updated on: 12/29/2015
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


test_array = Array.new
test_array2 = Array.new
test_array3 = Array.new
#format dates
def find_date(date)
	DateTime.strptime(date.gsub(/ /, '_'), "%d/%m/%Y_%I:%M:%S_%P").strftime("%m-%d-%Y_%I:%M_%P")
end



#Clean name
def find_name(name)
  re_name = Regexp.new(/'(.*?)'/)
  name.match(re_name)[1]
end

#name = "Admitted 'Driscoll, John' (Card: 5330)   at 'Trend HR 6th Floor Open Office 6004' (IN)."
#puts name

#re_name = Regexp.new(/'(.*?)'/)
#m = name.match(re_name)
#p m


#read csv and put it into an array of arrays
csv_array = CSV.read(input_file)
test_array = csv_array.map { |row| rowp = [row[3], row[4]] }
test_array2 = test_array.map do |row_name,row_date|
  punchtime = find_date(row_date)
  eename = find_name(row_name)
   [eename,punchtime]
end

p test_array2[0]

#test_array2 = test_array.map { |row| bad_date row[1] }

#test_array3 = test_array2.map { |row| find_name row}
#p test_array3[0][0]

#create new mapped array and indexes
#edit_array = csv_array.map { |row| rowp = [row[3],row[4]] }
#date_array = edit_array.map { |row2| bad_date row2 }

#final_array = date_array.uniq
