require 'fileutils'
require 'haversine'
require 'time'
require_relative '../helpers/photo_helper.rb'
require_relative '../helpers/user_helper.rb'

# module with checkout command
module CheckoutCommand
  include PhotoHelper

  CAMP = [53.915205, 27.560094].freeze
  TIME = Time.now.strftime('%a, %d %b %Y %H:%M')

  def checkout!(*)
    if UserHelper.registered(from['id']) && User[from['id']].in_camp == 'true'
      checkout_photo
      User[from['id']].update in_camp: 'false'
    else
      respond_with :message, text: 'U\'re not in camp'
    end
  end

  def checkout_photo(*)
    if payload['photo']
      save_checkout_photo
      checkout_location
    else
      save_context :checkout_photo
      respond_with :message, text: 'Send yourself!'
    end
  end

  def checkout_location(*)
    if payload['location']
      checkout_valid_location(payload['location'].values)
    else
      save_context :checkout_location
      respond_with :message, text: 'Send ur location'
    end
  end

  def checkout_valid_location(location)
    if Haversine.distance(CAMP, location).to_km <= 0.5
      respond_with :message, text: 'Cool! Good luck!'
      save_checkout_location
    else
      respond_with :message, text: 'U\' so far from camp! Try later'
    end
  end

  def save_checkout_photo(*)
    path = photo_path
    create_checkout_directory(from['id'])
    File.open(checkout_path(from['id']) + '/photo.jpg', 'wb') do |file|
      file << URI.open(DOWNLOAD_API + path).read
    end
  end

  def save_checkout_location(*)
    path = checkout_path(from['id']) + '/location.txt'
    File.open(path, 'wb') do |file|
      file << payload['location'].values
    end
  end

  def create_checkout_directory(id)
    FileUtils.mkdir_p(checkout_path(id))
  end

  def checkout_path(id)
    "public/#{id}/checkout/#{TIME}"
  end
end
