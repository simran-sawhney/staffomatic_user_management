class BaseSearches
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def self.call(*args)
    new(*args).call
  end

  def format_string(string)
    string.to_s.strip.gsub("'", "").gsub("\"", "")
  end

end
