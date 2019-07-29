require 'net/http'
require 'open-uri'
require 'fileutils'

module SaveData
  TOKEN = ENV['BOT_TOKEN']
  API = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze
  DOWNLOAD_API = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  TIME = Time.now.strftime('%a, %d %b %Y %H:%M')

  def save_photo(*)
    FileUtils.mkdir_p("public/#{Guest[from['id']].number}/#{Guest[from['id']].in_camp}/#{TIME}")
    File.open("public/#{Guest[from['id']].number}/#{Guest[from['id']].in_camp}/#{TIME}" + '/photo.jpg', 'wb') do |file|
      file << URI.open(DOWNLOAD_API + photo_path).read
    end
  end

  def save_location(*)
    File.open("public/#{Guest[from['id']].number}/#{Guest[from['id']].in_camp}/#{TIME}" + '/location.txt', 'wb') do |file|
      file << payload['location'].values
    end
  end

  private

  def photo_path
    JSON.parse(URI.open(API + payload['photo'].last['file_id'])
                 .read, symbolize_names: true)[:result][:file_path]
  end
end
