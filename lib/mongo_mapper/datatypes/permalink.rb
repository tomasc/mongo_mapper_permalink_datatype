# ============================================================
# PERMALINK DATATYPE

# this class implements permalink data type

module MongoMapper
  module Datatypes

    class Permalink < String
	
    	def self.to_mongo(value)
    		ActiveSupport::Inflector.transliterate(value).		# remove accents
    		gsub(/[^a-zA-Z0-9_\s]/, '').											# remove non-alphanumerical characters (except _)
    		gsub(/\b\w/){$&.upcase}.													# titlecase
    		gsub(/\s+/, '')	unless value.nil?									# remove space
    	end
	
    	def self.from_mongo(value)
    		value
    	end
	
    end

  end
end