require 'spec_helper'

describe Commoner do

  describe '#search' do
    context 'on a term that is not listed' do
      it 'returns an empty array' do
        titles = Commoner.search("badger")
        expect(titles).to eq([])
      end
    end

    context 'on a known term' do
      it 'returns some titles' do
        titles = Commoner.search("Meles meles")
        expect(titles.size).to be > 0
      end
    end

    context 'humph' do
      it 'searches for stuff' do
        titles = Commoner.search("plaques")
        titles.each_with_index do |t, index|
#          puts index.to_s + ". " + t
        end
      end
    end
  end

  describe '#images' do

    it 'list images for a page' do
    	images = Commoner.images("Meles meles")
      first = images[0]
      expect(first[:url].start_with?("https:")).to be(true)
    end

    it 'copes when there are no images found' do
      images = Commoner.images("plaques")
    end

  end

  describe '#details' do

    context 'a non-file page name' do
      it 'gives details of a title' do
        images = Commoner.details("Meles meles")
      end
    end

    context 'an unknown page name' do
      it 'gives details of a title' do
        image = Commoner.details("File:xyz.jpg")
      end
    end

    context 'a Commons file page' do
      it 'gives details of a title' do
        image = Commoner.details("File:Badger 25-07-09.jpg")
      end
    end

    context 'a full Commons file page url' do
      it 'gives details of a title' do
        image = Commoner.details("https://commons.wikimedia.org/wiki/File:Badger 25-07-09.jpg")

        puts "  url: " + image[:url]
        puts "  description: " + image[:description]
        puts "  author: " + image[:author] 
       puts "  author_url: " + image[:author_url]
        puts "  licence: " + image[:licence]
        puts "  licence_url: " + image[:licence_url]
        puts " "
      end
    end

    context 'a Wikipedia image preview url' do
      it 'gives details of a title' do
        image = Commoner.details("https://en.wikipedia.org/wiki/Main_Page#mediaviewer/File:Suillus_pungens_123004.jpg")
 #    images.each_with_index do |image, index|
#      puts index.to_s + ". " 
        puts "  url: " + image[:url]
        puts "  description: " + image[:description]
        puts "  author: " + image[:author] 
       puts "  author_url: " + image[:author_url]
        puts "  licence: " + image[:licence]
        puts "  licence_url: " + image[:licence_url]
        puts " "
#     end
           end
    end
  end

  describe '#details' do

    context 'a base category' do
      it 'lists images categorised as this and within subcategories' do
        images = Commoner.categorised_images("Category:Stolperstein-Plagiate")
      end
    end

  end
end
