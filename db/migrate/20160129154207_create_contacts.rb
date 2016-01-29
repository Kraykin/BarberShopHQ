class CreateContacts < ActiveRecord::Migration
  def change
  	
  	create_table :contacts do |t|
  		t.text :email
  		t.text :contact

  		t.timestamps
  	end
  	
  end
end
