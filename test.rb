#csv library
require 'csv'
require 'date'
require "time"
#Source File:
input_file = 'testdata.csv'
#output File:
output_file = 'JournalRaw_updated.csv'



csv_array = Array.new
edit_array = Array.new
date_array = Array.new
final_array = Array.new
sort_array = Array.new
group_array = Array.new
value_array = Array.new

test_array = Array.new
test_array2 = Array.new
test_array3 = Array.new
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

#Group all times for each day

#Thank you very much to Cary Swoveland from stackoverflow.
group_array = sort_array.each_with_object({}) { |(name,date,val),h|
  h.update(name => { date: date, val: [val.to_i] }) { |_,h1,h2|
    { date: h1[:date], val: h1[:val] + h2[:val] } } }.
      map { |name, h| [name, h[:date], *h[:val].minmax.map(&:to_s) ] }
