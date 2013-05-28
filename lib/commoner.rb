require "commoner/version"
require "httparty"
require "json"

class Commoner

  def self.search(query)
    new.search(query)
  end

  def self.images(term)
    new.images(term)
  end

  def initialize(base_uri = nil)
    @uri = (base_uri) ? base_uri : default_uri
  end

  def search(query)
    json_get(search_uri(query))[1]
  end

  def images(term)
    # get a list of titles for the given term
    response = json_get(query_uri(term))
    images   = response['query']['pages'].map { |page_id, page| page['images'] }
    titles   = images.flatten.map { |image| image['title'] }

    # map each title to category and url info
    titles.map do |title|
      response   = json_get(info_uri(title))
      pages      = response['query']['pages'].map { |page_id, page| page }
      categories = pages.first['categories'].map { |category| category['title'] }.flatten

      {
        categories: categories.map { |category| category.gsub(/^Category:/, '') },
        url:        pages.first['imageinfo'].first['url']
      }
    end
  end

private

  def json_get(uri)
    response = HTTParty.get(uri)
    if response.code == 200
      JSON.parse(response.body)
    else
      raise Exception.new("bad status code from Wikimedia server (#{response.code}):\n#{response.body}")
    end
  end

  def uri_for(params)
    "#{@uri}?#{URI.encode_www_form(params)}"
  end

  def search_uri(query)
    uri_for action: 'opensearch', search: query, limit: 100
  end

  def query_uri(term)
    uri_for action: 'query', titles: term, prop: 'images', format: 'json'
  end

  def info_uri(image)
    uri_for action: 'query', titles: image, prop: 'imageinfo|categories', iiprop: 'url', format: 'json'
  end

  def default_uri
    @default_uri ||= "http://commons.wikimedia.org/w/api.php"
  end
end
