module PersonName
  attr_reader :first_name, :middle_initial, :last_name

  def full_name(*options)
    return send(:full_name_first_name_first) if options.nil? || options.empty?
    options.map {|option| raise OptionError.new unless options_whitelist.include?(option) }
    method = "full_name_OPT"
    send(:"#{method.gsub("OPT", options[0].to_s)}")
  end

  class OptionError < StandardError
    def message
      "Invalid option! The only option as of now is :last_name_first"
    end
  end

private

  def options_whitelist
    [:last_name_first]
  end

  def full_name_first_name_first
    "#{first_name} #{middle_initial}. #{last_name}"
  end

  def full_name_last_name_first
    "#{last_name}, #{first_name} #{middle_initial}."
  end
end

class Person < Struct.new( :first_name, :middle_initial, :last_name )
  include PersonName

  def initialize(attributes)
    attributes.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
    
    if @first_name.nil? || @middle_initial.nil? || @last_name.nil?
      raise Exception.new("You must define :first_name, :middle_initial, and :last_name!")
    end
  end
end

