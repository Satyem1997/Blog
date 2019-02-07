class Product < ApplicationRecord

	before_save :calculate_volume

	attr_accessor :file
	

	VALID_ITEM_REGEX = /[A-Z]{1}[a-z]+/
	VALID_SKU_REGEX = /[A-Z]{3}[0-9]{4}/
	VALID_SERIAL_REGEX = /[0-9]{15}/
	validates :item_type, presence: true, format: { with: VALID_ITEM_REGEX }
	validates :sku, presence: true, format: {with: VALID_SKU_REGEX }
	validates :Title, presence: true
	validates :serial_number, presence: true, uniqueness: true, format: {with: VALID_SERIAL_REGEX }
	validates :quantity, presence: true
	validates :price, presence: true
	validates :organization, presence: true
	validates :Length, presence: true
	validates :Breadth, presence: true
	validates :Height, presence: true
	validates :Weight, presence: true
	validates :description, presence: true
	validates :short_description, presence: true
	validates :asset_code, presence: true
	validates :grade, presence: true
	validates :category, presence: true
	validates :brand, presence: true

	require 'csv'

	# def self.import(file)
	# 	products = Product.order(:id)
	# 	CSV.foreach( file.path,headers: true) do |r|
	# 		product = Product.find_by(id: r["id"]) || Product.new
	# 		product.attributes = r.to_hash
	# 		product.save
	# 		# puts r.errors.full_messages
	# 		# puts"------------------------hello"
	# 		# puts r.inspect
	# 		# puts r["id"]
	# 		# products.each do |product|
	# 		#  product.volume = r["Length"].to_f * r["Breadth"].to_f * r["Height"].to_f

	# 		# p= Product.create(r.to_hash) 
	# 		# puts p.errors.full_messages
	# 	end
	# end


	# def save
 #    if imported_products.map(&:valid?).all?
 #      imported_products.each(&:save!)
 #      true
 #    else
 #      imported_products.each_with_index do |product, index|
 #        product.errors.full_messages.each do |message|
 #          errors.add :base, "Row #{index+2}: #{message}"
 #        end
 #      end
 #      false
 #    end
  # end



 #  def load_imported_products
 #    spreadsheet = Roo::Spreadsheet.open(file.path)
 #    header = spreadsheet.row(1)
 #    (2..spreadsheet.last_row).each do |i|
 #      row = Hash[[header, spreadsheet.row(i)].transpose]
 #      product = Product.find_by(id: row["id"]) || Product.new
 #      product.attributes = row.to_hash
 #      product
 #    end    
 #  end


	# def imported_products
 #    @imported_products ||= load_imported_products
 #  end

	# def calculate_volume

	# 	self.volume = self.Length * self.Breadth * self.Height

	# end

	# file = "/home/blubirch/assign/blogg/prodd.csv"
	# products = Product.order(:id)
	# column_headers = ["serial_number", "volume"]
	# CSV.open(file, 'w', write_headers: true, headers: column_headers) do |writer|
 #  	products.each do |product|
 #    writer << [product.serial_number, product.volume]
 #  	end
	# end

	def self.import(file)
		if File.extname(file.original_filename) == '.csv'
			puts "----------------------------inside csv"
			CSV.foreach(file.path, headers: true) do |row|
				puts row.inspect
				inventory = find_by_id(row["id"]) || new
				inventory.volume = row["Length"].to_f*row["Breadth"].to_f*row["Height"].to_f
				#inventory.volume = self.Length*self.Breadth*self.Height
				inventory.attributes = row.to_hash#.slice(*column_names)
				inventory.save
			end
		elsif File.extname(file.original_filename) == '.xls'
			spreadsheet = open_spreadsheet(file)
			header = spreadsheet.row(1)
			header.push("volume")
			import_errors = []
			(2..spreadsheet.last_row).each do |i|
				r = spreadsheet.row(i)
				volume = r[7]*r[8]*r[9]
				r.push(volume)
				puts [header, r].transpose.inspect
				# row = Hash[[header, r].transpose]
				puts row
				inventory = find_by_id(row["id"]) || new
				#inventory.volume = row["Length"]*row["Breadth"]*row["Height"]
				inventory.attributes = row.to_hash
				inventory.save
				# row_error = {i => inventory.errors.full_messages}
				import_errors.push(row_error)
			end
		end
	end

	# require 'csv'    

# csv_text = File.read('/home/blubirch/assign/blogg/inventory.xls')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Product.create!(row.to_hash)
# end


end




