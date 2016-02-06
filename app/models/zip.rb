class Zip
  # convenience method to access client in console
  def self.mongo_client
    Mongoid::Clients.default
  end

  # convenience method for access to zips collection
  def self.collection
    self.mongo_client["zips"]
  end

  # implement a find that returns a collection of document as hashes.
  # Use initialize(hash) to express individual documents as a class
  # instance.
  #   * prototype - query example for value equality
  #   * sort - hash expressing multi-term sort order
  #   * offset - document to start results
  #   * limit - number of documents to include
  def self.all(prototype={}, sort={:population=>1}, offset=0, limit=100)
    #map internal :population term to :pop document term
    tmp = {} #hash needs to stay in stable order provided
    sort.each {|k,v|
      k = k.to_sym==:population ? :pop : k.to_sym
      tmp[k] = v  if [:city, :state, :pop].include?(k)
    }
    sort=tmp

    #convert to keys and then eliminate any properties not of interest
    prototype=prototype.symbolize_keys.slice(:city, :state) if !prototype.nil?

    Rails.logger.debug {"getting all zips, prototype=#{prototype}, sort=#{sort}, offset=#{offset}, limit=#{limit}"}

    result=collection.find(prototype)
          .projection({_id:true, city:true, state:true, pop:true})
          .sort(sort)
          .skip(offset)
    result=result.limit(limit) if !limit.nil?

    return result
  end
end
