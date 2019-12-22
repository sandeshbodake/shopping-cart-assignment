class Connector
    def connector
		@con = DatabaseConnector.new.connect
	end
	
	def not_found_message
		puts "\n\n\t Product Not Found ;( \n\n"
	end

	def something_went_wrong
		puts "\n\n\t Something went wrong ;( \n\n"
	end
end