require 'spec_helper'

describe Commoner do
  it 'searches for stuff' do
  	titles = Commoner.search("Meles meles")
#    titles.each_with_index do |t, index|
#      puts index.to_s + ". " + t
#    end
    expect(titles[1].to_s).to eq("Meles anakuma")
  end

  it 'list images for a page' do
  	images = Commoner.images("Meles meles")
#  	images.each_with_index do |image, index|
#  	  puts index.to_s + ". " 
#      puts "  url: " + image[:url]
#      puts "  description: " + image[:description]
#      puts "  author: " + image[:author] 
#      puts "  author_url: " + image[:author_url]
#      puts " "
#  	end
    first = images[0]
    expect(first[:url].start_with?("http:")).to be(true)
  end

end
