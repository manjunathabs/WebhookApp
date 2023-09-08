  # app/workers/webhook_worker.rb
  class WebhookWorker
    include Sidekiq::Worker





    def perform(data_record_id)
      data_record = DataRecord.find(data_record_id)
          auth_token = Rails.application.config.webhook_auth_token
   
      # Authentication headers (adjust as needed)
      headers = {
        'Authorization' => 'Bearer #{auth_token}',
        'Content-Type' => 'application/json'
      }
      
      # Your webhook payload
      payload = {
        key: 'value'
      }
    
       third_party_endpoints = YAML.load_file(Rails.root.join('config', 'third_party_apis.yml'))
      current_env_endpoints = third_party_endpoints[Rails.env]
       
      current_env_endpoints.values.each do |endpoint|
  	    


  	   

      # Make the authenticated webhook call
  	   # response = HTTParty.post(endpoint, body: payload.to_json, headers: headers)
  	        response = HTTParty.post('https://example.com/webhook', body: payload.to_json, headers: headers)
   
      end

      
      # Handle the response as needed
      if response.success?
        Rails.logger.info("Webhook call succeeded: #{response.body}")
      else
        Rails.logger.error("Webhook call failed: #{response.code} - #{response.body}")
      end
    end




  end

