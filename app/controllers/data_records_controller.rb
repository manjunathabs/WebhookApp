  class DataRecordsController < ApplicationController
  	require 'net/http'
          require 'json'
  	require 'yaml'
          protect_from_forgery with: :null_session




    def create
  	   
      data_record = DataRecord.new(data_record_params)
       
      if data_record.save
  #      notify_third_party_apis(data_record)
        WebhookWorker.perform_async(data_record.id)
        render json: data_record, status: :created
      else
        render json: data_record.errors, status: :unprocessable_entity
      end
    end



    def update
      data_record = DataRecord.find(params[:id])
      if data_record.update(data_record_params)
     #   notify_third_party_apis(data_record)
        WebhookWorker.perform_async(data_record.id)
        render json: data_record
      else
        render json: data_record.errors, status: :unprocessable_entity
      end
    end

    private

    def data_record_params
      params.require(:data_record).permit(:name, :data)
    end


  /*
  def notify_third_party_apis(data_record)
    third_party_endpoints = YAML.load_file(Rails.root.join('config', 'third_party_apis.yml'))
      current_env_endpoints = third_party_endpoints[Rails.env]
   
      current_env_endpoints.values.each do |endpoint|
  	  
      uri = URI.parse(endpoint) 
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      request.body = { data: data_record.data }.to_json 
      response = http.request(request)
      
      Rails.logger.info("Webhook response: #{response.body}")
    end
  end  */

  end
