# Problem:
#   There is a set of xml that needs to be translated to a structure
# that another library understands. That structure is defined first.
#
# Objective:
#   Implement the solution in a THREAD SAFE concurrent fashion. In
# order to accomplish this we have a goal that 90% of the functions
# we implement will be idempotent. The last 10% will be structural
# and state management (writes).


require File.expand_path('../person.rb', __FILE__)

xml_return = File.read(File.expand_path('../sample.xml', __FILE__))

# todo: write a service object that takes xml, and returns a filled
#   ruby object based on what you sent in.


# ie...

class String
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end

class XmlParser
  def self.parse_object_from_xml(xml, klass)
    method = "parse_#{klass.to_s.underscore}_from_xml"
    raise klass.respond_to?(method).inspect
    unless klass.respond_to?(method.to_sym)
      raise "Class (#{klass.to_s}) not supported at this time!"
    end
    klass.send(method.to_sym, xml)
  end

private

  def self.parse_person_from_xml(xml)
    
  end
end

XmlParser.parse_object_from_xml(xml_return, Person)

