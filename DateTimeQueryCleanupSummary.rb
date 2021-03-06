#Script to clean up & help prepare csv export from CCURE 9000 for access.
#Authored on: 12/28/2015
#Updated on: 12/31/2015
#Export journal entries for CCURE 9000 (not a report), and then point this to the CSV file.
#Log on to the security server, open CCURE9000, go to Data Views > Query and hit the green arrow.
#Run the SWHrep13 - Personnel Admitted at Doors in Time Range Query
#Enter your specific paramters, then perform the search. Select all results, right click > export to csv file.
#Delete the header row in a text editor (Notepad, Notepad++, Atom... don't use excel)
#Change input_file to the name of your  file, place in the same directory as this script and run this script.


#csv library
require 'csv'
require 'date'
#Source File:
input_file = 'JournalRaw_orig.csv'
#output File:
output_file = 'JournalRaw_updated.csv'

csv_array = Array.new
edit_array = Array.new
date_array = Array.new
sort_array = Array.new
group_array = Array.new
groupme_array = Array.new
calc_array = Array.new
final_array = Array.new

#find date / time.
def find_date(dtime)
	dtime = DateTime.strptime(dtime.gsub(/ /, '_'), "%d/%m/%Y_%I:%M:%S_%P")
  return dtime
end

#Clean name
def find_name(name)
  re_name = Regexp.new(/'(.*?)'/)
  name.match(re_name)[1]
end
#split time and date
def split_dtime (dtime)
  date = dtime.strftime("%m-%d-%Y")
  time = dtime.strftime("%H%M")
  [date,time]
	end
#Pretty formatting for time
	def cleantime (time)
	  clean_time = DateTime.strptime(time, "%H%M")
		testtime = clean_time.strftime("%H:%M %P")
		end

#read csv and put it into an array of arrays
csv_array = CSV.read(input_file)

#Create a new array with the date and time we need
edit_array = csv_array.map { |row| rowp = [row[3], row[4]] }

#Pull just the name out,  convert date to date time, split into [name, date,time].
date_array = edit_array.map do |row_name,row_dtime|
  punchtime = find_date(row_dtime)
  punchtime = split_dtime(punchtime)
  eename = find_name(row_name)
  [eename,punchtime].flatten
end

#Sort by name, date, time
sort_array = date_array.sort_by { |n,d,t| [n,d,t] }


#Thank you very much to Cary Swoveland from stackoverflow.
#Convert to a hash using the name and date as the key, & convert the values to an int, gather them up.
group_array = sort_array.each_with_object({}) { |(name,date,time),h|
	h.update([name,date] => {  time: [time.to_i] }) { |k, h1, h2| { time: h1[:time] + h2[:time] }}}

#Take the new group array, create a new array with only the min and max times, format them back to string.
calc_array = group_array.map { |k,value| [k, value[:time].minmax.map { |n| "%04d" % n }].flatten}

#make the dates pretty
final_array = calc_array.map { |n,d,t1,t2| [n,d,cleantime(t1),cleantime(t2)] }

#Output to csv file
CSV.open(output_file, "wb") do |csvfile|
	final_array.each do |row|
		csvfile << row
		end
		end
