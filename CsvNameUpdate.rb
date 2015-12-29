#Script to parse csv files and help clean up names in import for. 
#Authored on: 10/23/2015


#csv library
require 'csv'

#Source File:
input_file = 'contactsname.csv'
#output File:
output_file = 'contactsnameupdated.csv'

names_array = Array.new
edit_array = Array.new


#read csv and put it into an array of arrays 
names_array = CSV.read(input_file) 

#here we go

#create new mapped array and indexes
edit_array = names_array.map.with_index do |row,index|
	#declare some variables for later use
	holdme1 = "" #string
	holdme2 = "" #string
	holdme3 = "" #string
	holdme4 = "" #string
	holdme5 = "" #string


	if row[0] == nil && row[1] == nil #if nils, put the nils
		row
		
	
#if first name is an initial and last name is an initial, join them as one. Example : A,J,Test AJ,TEST
		elsif row[0].length == 1 && row[1].length == 1 
			holdme1 = row[0] + row[1]
			holdme2 = row[2]
			[holdme1,holdme2]
			
		elsif row[1].upcase == "MC" #For all the people with Mc_Names. Example Joe,mc,Arthur == Joe,McArthur
			holdme1 = "Mc"
			holdme2 = row[2]
			holdme3 = holdme1 + holdme2
			holdme4 = row[0]
			holdme5 = row[3]
			[holdme4, holdme3, holdme5]

		elsif row[1].upcase == "DE" #For all the people with Mc_Names. Example Joe,De,JESUS == Joe,DE JESUS
			holdme1 = "De "
			holdme2 = row[2]
			holdme3 = holdme1 + holdme2
			holdme4 = row[0]
			holdme5 = row[3]
			[holdme4, holdme3, holdme5]

		elsif row[1].upcase == "LE" #For all the people with Mc_Names. Example Joe,LE,JESUS == Joe,LE JESUS
			holdme1 = "LE "
			holdme2 = row[2]
			holdme3 = holdme1 + holdme2
			holdme4 = row[0]
			holdme5 = row[3]
			[holdme4, holdme3, holdme5]

		elsif row[1].length == 1 #Middle initial in last row cloumn, put last name middle init. Example: Jason,M,Holder == Jason,Holder,M 
			holdme1 = row[1]
			holdme2 = row[2]
			holdme3 = row[0]
			[holdme3,holdme2,holdme1]

		else
			row
	end

end
puts "this should be our output:"
puts edit_array


#out put to csv file
CSV.open(output_file, "wb") do |csvfile|
	edit_array.each do |row|
		csvfile << row
	end
end
