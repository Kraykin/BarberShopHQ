#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3 }
	validates :phone, presence: true, length: { in: 6..12 }
	validates :barber, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true   
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
	validates :email, presence: true, length: { minimum: 4 }
	validates :contact, presence: true, length: { in: 2..5000 }
end

before do
	@barbers = Barber.all
	#@clients = Client.all
	#@contacts = Contact.all
end

get '/' do
	erb :index
end

get '/visit' do
	@booking = Client.new
	erb :visit
end

post '/visit' do
	@booking = Client.new params[:client]
	
	# @client_name = params[:client_name]
	# @client_phone = params[:client_phone]
	# ...
	
	# Client.create :name => @client_name, :phone => @client_phone, :datestamp => @datetime, :barber => @barber, :color => @color
	
	# OR
	
	# c = Client.new
	# c.name = @client_name
	# ...
	# c.save
	if @booking.save
		erb "Спасибо! #{@booking[:name].capitalize}, мы будем ждать Вас #{@booking[:datestamp]}"
	else
		@error = @booking.errors.full_messages.first
		erb :visit
	end
end

get '/contacts' do
	@contact = { :email => '', :contact => '' }
	erb :contacts
end

post '/contacts' do
	@contact = Contact.new params[:client]
	if @contact.save
		erb "Спасибо! Мы напишем Вам ответ на адрес #{@contact[:email]}"
	else
		@error = @contact.errors.full_messages.first
		erb :contacts
	end
	
end

get '/about' do
	erb :about
end

get '/barber/:id' do
	@barber = Barber.find params[:id]
	erb :barber
end

get '/bookings' do
	@clients = Client.order 'created_at DESC'
	erb :bookings
end

get '/client/:id' do
	@client = Client.find params[:id]
	erb :client
end