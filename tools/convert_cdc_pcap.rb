#!/usr/bin/ruby

require 'csv'

FILE = '/Users/rickmark/Dropbox Dropbox/Rick Mark/iOS Rootkit/iPhone_USBHostChannel.csv'

COMMAND_TYPE_DATA_PAIRED = 6

CSV.foreach(FILE, quote_char: "\0") do |row|
	data = (row[10] || "").gsub(/\s+/, "")
	raw_data = [ data ].pack('H*')

	next if raw_data.empty?
	
	if row[9] =~ /IN/
		command_type, length, command = raw_data.unpack("L>L>a*")
		puts "Length mismatch Actual -> #{raw_data.length}, Expected -> #{length}" if length != raw_data.length
	
		puts command_type
	else
		puts data
	end
end