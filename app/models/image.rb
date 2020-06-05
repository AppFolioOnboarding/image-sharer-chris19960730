class Image < ApplicationRecord
  acts_as_taggable_on :tags
  # Validation for image columns.
  validates :name, presence: true
  validates :url, presence: true
  validate :image_url_valid?

  private

  # Define method to check if the Image URL is valid.
  def check_with_http(url)
    url = URI.parse(url)
    Net::HTTP.start(url.host, url.port) do |http|
      return http.head(url.request_uri)['Content-Type'].start_with? 'image'
    end
  rescue StandardError
    nil
  end

  def check_with_https(url)
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')

    http.start do |https|
      return https.head(url.request_uri)['Content-Type'].start_with? 'image'
    end
  rescue StandardError
    nil
  end

  def image_url_valid?
    return false if url.blank?

    if url =~ /^https/
      errors.add(:url, 'invalid image url') unless check_with_https(url)
    else
      errors.add(:url, 'invalid image url') unless check_with_http(url)
    end
  end
end
