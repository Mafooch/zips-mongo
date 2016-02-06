module ZipsHelper
  def to_zip value
    # change value to a Zip if not already a Zip
    # unlike with AR we may never create a Zip instance everytime we have a zip
    # document. this lets us make the instance which gives other object oriented
    # functionality
    value.is_a?(Zip) ? value : Zip.new(value)
  end
end
