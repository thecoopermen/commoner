require "commoner/version"
require "httparty"
require "json"
require "Nokogiri"
require "Sanitize"

class Commoner

  def self.search(query)
    new.search(query)
  end

  def self.images(term)
    new.images(term)
  end

  def self.categorised_images(term)
    new.categorised_images(term)
  end

  def self.details(title)
    new.details(title)
  end

  def initialize(base_uri = nil)
    @uri = (base_uri) ? base_uri : default_uri
  end

  def search(query)
    puts search_uri(query)
    json_get(search_uri(query))[1]
  end

  def images(term)
    # get a list of titles for the given term
    puts query_uri(term)
    response = json_get(query_uri(term))
    images   = response['query']['pages'].map { |page_id, page| page['images'] }

    if images!=[nil]
      titles   = images.flatten.map { |image| image['title'] }
      # map each title to category and url info
      titles.map do |title|
        details(title)
      end
    end
  end

  def categorised_images(category)
    # get a list of titles for the given term
    response = json_get(category_uri(category))
    images = response['query']['categorymembers']

    if images!=[nil]
      titles = images.flatten.map { |image| image['title'] }
      # map each title to category and url info
      titles.map do |title|
        puts title
        if title.start_with?('Category:')
          categorised_images(title)
        else
          details(title)
        end 
      end
    end
  end

  def details(title)
    return nil if (!title.start_with?('File:'))
    response   = json_get(info_uri(title))
    pages      = response['query']['pages'].map { |page_id, page| page }
    categories = pages.first['categories'].map { |category| category['title'] }.flatten
    descriptionurl = pages.first['imageinfo'].first['descriptionurl']

    # description and author details are not available through the API calls
    party = HTTParty.get(descriptionurl)
    doc = Nokogiri::HTML(party.to_s)

    author_url = ""
    au = doc.xpath('//tr[td/@id="fileinfotpl_aut"]/td/a/@href')
    author_url = au[0].content if au.size > 0
    author_url = "http://commons.wikimedia.org" + author_url if author_url.start_with?('/wiki/User:')
    {
      categories:  categories.map { |category| category.gsub(/^Category:/, '') },
      url:         pages.first['imageinfo'].first['url'],
      description: Sanitize.clean(doc.xpath('//td[@class="description"]')[0].content)[0,255].strip!,
      author:      Sanitize.clean(doc.xpath('//tr[td/@id="fileinfotpl_aut"]/td')[1].content),
      author_url:  author_url
    }
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

  def category_uri(term)
    uri_for action: 'query', cmtitle: term, list: 'categorymembers', format: 'json'
  end

  def default_uri
    @default_uri ||= "http://commons.wikimedia.org/w/api.php"
  end
end
