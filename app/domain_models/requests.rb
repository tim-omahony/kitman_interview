class Requests
  attr_accessor :access_token

  def key_request
    response = Typhoeus.post(
      "https://dev-0erpan4x.us.auth0.com/oauth/token",
      body: {'client_id'=>'GQTrJq9NjukTYqcB7OO0w6PQac2LXbdS', 'client_secret'=>'txb3w4N0Q-18_nLzMfNZcpBSfg8TOGzIHPDcOjb-xR-yfUk7LRQE16o5GgrWN-RY', 'grant_type'=>'client_credentials', 'audience'=>'https://athletedataservice.thesportsoffice.com'},
      headers: {'Content-Type'=>'application/x-www-form-urlencoded'},
      )
      if response.success?
        @access_token = JSON.parse(response.body)['access_token']
      elsif response.timed_out?
        Rails.logger.info("response timed out")
      elsif response.code == 0
        Rails.logger.info(response.return_message)
      else
        Rails.logger.info("Request failed: #{response.code.to_s}")
      end
  end

  def api_request
    response = Typhoeus.get(
      "https://athletedataservice.azurewebsites.net/summary",
      headers: {'accept'=>'application/json', 'Authorization'=>"Bearer #{access_token}"}
    )
      if response.success?
        JSON.parse(response.body)
      elsif response.timed_out?
        Rails.logger.info("response timed out")
      elsif response.code == 0
        Rails.logger.info(response.return_message)
      else
        Rails.logger.info("Request failed: #{response.code.to_s}")
      end
  end
end