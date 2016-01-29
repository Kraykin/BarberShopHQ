#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
	@clients = Client.all
	@contacts = Contact.all
end

get '/' do
	erb :index
end

get '/visit' do
	@appointment = { :name => '', :phone => '', :datestamp => '', :barber => '', :color => '' }
	erb :visit
end

post '/visit' do
	@appointment = Client.new params[:client]
	@appointment.save

	# @client_name = params[:client_name]
	# @client_phone = params[:client_phone]
	# @datetime = params[:datetime]
	# @barber = params[:barber]
	# @color = params[:color]

	# Client.create :name => @client_name, :phone => @client_phone, :datestamp => @datetime, :barber => @barber, :color => @color

	erb "Спасибо! #{@appointment[:name].capitalize}, мы будем ждать Вас #{@appointment[:datestamp]}"
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@client_email = params[:client_email]
	@client_text = params[:client_text]

	Contact.create :email => @client_email, :contact => @client_text

	erb "Спасибо! Мы напишем Вам ответ на адрес #{@client_email}"
end