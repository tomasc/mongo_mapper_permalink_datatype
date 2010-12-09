# ============================================================
# PERMALINK DATATYPE

# this class implements permalink data type

class Permalink < String
	
	def self.to_mongo(value)
		ActiveSupport::Inflector.transliterate(value).		# remove accents
		gsub(/[^a-zA-Z0-9\s]/, '').												# remove non-alphanumerical characters
		gsub(/\b\w/){$&.upcase}.													# titlecase
		gsub(/\s+/, '')	unless value.nil?									# remove space
	end
	
	def self.from_mongo(value)
		value
	end
	
end
