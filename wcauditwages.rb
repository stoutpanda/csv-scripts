#Script to update master file (WCPremium.csv) with amounts in (auditwages.csv)
#Authored by: Jason Holder
#Authored on: 01/11/2016
#Updated on: 01/11/2015
#Requires ruby version 2.1 or later for to_h function.
#Save files as CSV and place in directory with this script.
#Started running out of memory so having to add SQLite. User will have to have SQLite3, and sqlite3-ruby gem installed.

#csv library
require 'csv'
require 'date'
require 'sqlite3'
time = DateTime.now.strftime("%m-%d-%Y_%H-%M-%S")
#input file names and output file name below. These can be adjusted as needed.
 master_file = 'WCPremium.csv'
 auditwages_file = 'auditwages.csv'
 output_file = "WCPremiumUpdate-#{time}.csv"
 aw_h = ["clientid","location","clientname", "state","class","wages","from","to"] #auditwages columns
 ma_h = ["clientid","clientst","clientclass","state","class","wages","manualrates","charged","dpfr","ctfr","scfr","expenseconstant","notes","premium","percentofcharged","surcharge","total"] #masterwages columns

puts "Checking if DB exist:"
File.delete("WCPremium.sqlite") if File.exists?("WCPremium.sqlite")


puts "Creating SQLite3 DB"
db = SQLite3::Database.new "WCPremium.sqlite"
puts "Creating tables"
db.execute <<SQL
CREATE TABLE master (
id INTEGER PRIMARY KEY,
clientid TEXT(255),
clientst TEXT(255),
clientclass TEXT(255),
state TEXT(255),
class TEXT(255),
wages TEXT(255),
manualrates TEXT(255),
charged TEXT(255),
dpfr TEXT(255),
ctfr TEXT(255),
scfr TEXT(255),
expenseconstant TEXT(255),
notes TEXT,
premium TEXT(255),
percentofcharged TEXT(255),
surcharge TEXT(255),
total TEXT(255) );
CREATE TABLE auditwages (
id INTEGER PRRIMARY KEY,
clientid TEXT(255),
location TEXT(255),
clientname TEXT(255),
state TEXT(255),
class TEXT(255),
wages TEXT(255),
from TEXT(255),
to  TEXT(255) );
SQL

rows = db.execute( "SELECT * FROM master")
 p  rows
