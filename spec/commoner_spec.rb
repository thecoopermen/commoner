require 'spec_helper'

describe Commoner do

  describe '#search' do
    context 'on an unknown term' do
      it 'finds nothing' do
        titles = Commoner.search("badger")
        expect(titles).to eq([])
      end
    end

    context 'on a known term' do
      it 'finds some titles' do
        titles = Commoner.search("Meles meles")
        expect(titles.size).to be > 0
      end
    end
  end

  describe '#images' do

    context 'on a known term' do
      it 'finds at least one image' do
      	images = Commoner.images("Meles meles")
        first = images[0]
        expect(first[:url].start_with?("https:")).to be(true)
      end
    end

    context 'on an unknown term' do
      it 'copes when there are no images found' do
        images = Commoner.images("plaques")
      end
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

  describe '#licence' do

    context 'of a Delhi portrait of a man' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        image = Commoner.details("https://commons.wikimedia.org/wiki/File:India_-_Delhi_portrait_of_a_man_-_4780.jpg")
        expect(image[:licence]).to eq("CC BY-SA 3.0")
      end
    end

    context 'of Nahal Zaror, south 11' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        image = Commoner.details("File:Nahal_Zaror,_south_11.jpg")
        expect(image[:licence]).to eq("CC BY-SA 3.0")
      end
    end

    context 'of The mohave desert near the fossil beds' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        image = Commoner.details("File:PSM_V86_D252_The_mohave_desert_near_the_fossil_beds.jpg")
        expect(image[:licence]).to eq("CC BY-SA 3.0")
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
