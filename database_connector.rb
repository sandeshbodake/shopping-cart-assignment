#!/usr/bin/ruby

require 'pg'
DB_NAME = 'cart_app'
USER = 'postgres'

class DatabaseConnector
	def initialize(dbname = DB_NAME, user = USER)
		@dbname = dbname
		@user = user
	end

	def connect
		begin
		    con = PG.connect :dbname => @dbname, :user => @user
		rescue PG::Error => e
		    puts e.message 
		end

		con if con
	end
end