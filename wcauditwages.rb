#Script to update master file (WCPremium.csv) with amounts in (auditwages.csv)
#Authored by: Jason Holder
#Authored on: 01/11/2016
#Updated on: 01/11/2015
#Save files as CSV and place in directory with this script.

#csv library
require 'csv'
require 'date'
time = DateTime.now.strftime("%m-%d-%Y_%H-%M-%S")
#input file names and output file name below. These can be adjusted as needed.
master_file = '/home/jason/Projects/csv-scripts/WCPremium.csv'
auditwages_file = '/home/jason/Projects/csv-scripts/auditwages.csv'
output_file = "WCPremiumUpdate-#{time}.csv"

#Bring files into Array.
#0 - clientid, 3-state, 4-wc cdoe, 5 wages
auditwages_array = CSV.read(auditwages_file, headers:true)
#0- clientid, 5 - state, 6 - WC Code, 20 total
master_array = CSV.read(master_file, headers:true)

#Grab only the data I need from the audit wages Array
#0 - clientid, 1-state, 2-wc cdoe, 3 wages
auditwages_array = auditwages_array.map { |row| [row[0],row[3],row[4],row[5]].flatten }

# combine_array = master_array.map do |m_row|
# 	auditwages_array.map do |a_row|
# 		if m_row[0] == a_row[0] && m_row[5] == a_row[1] && m_row[6] == a_row[3]
# 			value = m_row[20] + a_row[3]
# 			value
# 		else
# 			m_row[20]
#
#
#
# 		end
# 	end
# end
# p combine_array


#auditwages_array = auditwages_array.each_with_object({}) { |(id,st,wc,w),h|
#	h.update([name,date] => {  time: [time.to_i] }) { |k, h1, h2| { time: h1[:time] + h2[:time] }}}
#sort_array.each_with_object({}) { |(name,date,time),h|
# 	h.update([name,date] => {  time: [time.to_i] }) { |k, h1, h2| { time: h1[:time] + h2[:time] }}}








# #Clean name
# def find_name(name)
#   re_name = Regexp.new(/'(.*?)'/)
#   name.match(re_name)[1]
# end
# #split time and date
# def split_dtime (dtime)
#   date = dtime.strftime("%m-%d-%Y")
#   time = dtime.strftime("%H%M")
#   [date,time]
# 	end
# #Pretty formatting for time
# 	def cleantime (time)
# 	  clean_time = DateTime.strptime(time, "%H%M")
# 		testtime = clean_time.strftime("%H:%M %P")
# 		end
#
# #read csv and put it into an array of arrays
# csv_array = CSV.read(input_file)
#
# #Create a new array with the date and time we need
# edit_array = csv_array.map { |row| rowp = [row[3], row[4]] }
#
# #Pull just the name out,  convert date to date time, split into [name, date,time].
# date_array = edit_array.map do |row_name,row_dtime|
#   punchtime = find_date(row_dtime)
#   punchtime = split_dtime(punchtime)
#   eename = find_name(row_name)
#   [eename,punchtime].flatten
# end
#
# #Sort by name, date, time
# sort_array = date_array.sort_by { |n,d,t| [n,d,t] }
#
#
# #Thank you very much to Cary Swoveland from stackoverflow.
# #Convert to a hash using the name and date as the key, & convert the values to an int, gather them up.
# group_arrpretty1ay = sort_array.each_with_object({}) { |(name,date,time),h|
# 	h.update([name,date] => {  time: [time.to_i] }) { |k, h1, h2| { time: h1[:time] + h2[:time] }}}
#
# #Take the new group array, create a new array with only the min and max times, format them back to string.
# calc_array = group_array.map { |k,value| [k, value[:time].minmax.map { |n| "%04d" % n }].flatten}
#
# #make the dates pretty1
# final_array = calc_array.map { |n,d,t1,t2| [n,d,cleantime(t1),cleantime(t2)] }
#group_arrpretty1ay
# #Output to csv file
# CSV.open(output_file, "wb") do |csvfile|
# 	final_array.each do |row|
# 		csvfile << row
# 		end
# 		end
