require_relative 'connector'
require_relative 'database_connector'
require 'date'

class Coupne < Connector
  def initialize(discount, start_date, end_date)
    connector
    @discount = discount
    @start_date = start_date
    @end_date = end_date
  end

  def start_date
    DateTime.parse(@start_date)
  end

  def end_date
    DateTime.parse(@end_date)
  end

  def create
    @con.exec "insert into coupenes
               VALUES(#{Time.now.to_i},'#{@discount.to_f}','#{start_date}', '#{end_date}', '#{Time.now}', '#{Time.now}')"
  rescue StandardError
    something_went_wrong
  end

  def self.all
    @con = DatabaseConnector.new.connect
    rs = @con.exec 'select * from coupenes'

    list_coupnes(rs)
  end

  def self.list_coupnes(rs)
    puts "\n\n********** Coupnes ***************\n\n"

    rs.each do |row|
      puts format('%s | %s | %s | %s', row['id'], row['discount_percentage'].to_f, row['start_date'], row['end_date'])
    end

    rs
  end

  def self.find(id)
    @con = DatabaseConnector.new.connect

    rs = @con.prepare 'find_by_coupne_id', 'select * from coupenes where id = $1'
    rs = @con.exec_prepared 'find_by_coupne_id', [id]
  end

  def self.update_end_date_time(coupne)
    @con = DatabaseConnector.new.connect
    updated_time = DateTime.parse(coupne['end_date']) + (4 / 24.0)

    @con.exec "update coupenes SET end_date='#{updated_time}' where id=#{coupne['id'].to_i}"
  end
end

