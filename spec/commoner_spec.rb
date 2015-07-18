require 'spec_helper'

describe Commoner do

  describe '#searching' do
    context 'on an unknown term' do
      it 'finds nothing' do
        VCR.use_cassette ('searching/' + self.class.description).gsub(" ","-") do
          titles = Commoner.search("badger")
          expect(titles).to eq([])
        end
      end
    end
    context 'on a known term' do
      it 'finds some titles' do
        VCR.use_cassette ('searching/' + self.class.description).gsub(" ","-") do
          titles = Commoner.search("Meles meles")
          expect(titles.size).to be > 0
        end
      end
    end
  end

  describe '#images' do
    context 'on a known term' do
      it 'finds at least one image' do
        VCR.use_cassette ('images/' + self.class.description).gsub(" ","-") do
        	images = Commoner.images("Meles meles")
          first = images[0]
          expect(first[:url].start_with?("https:")).to be(true)
        end
      end
    end
    context 'on an unknown term' do
      it 'finds nothing' do
        VCR.use_cassette ('images/' + self.class.description).gsub(" ","-") do
          images = Commoner.images("plaques")
          expect(images).to eq(nil)
        end
      end
    end
  end

  describe '#details' do
    context 'of a non-file page name' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          images = Commoner.details("Meles meles")
        end
      end
    end
    context 'of an unknown page name' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details("File:xyz.jpg")
        end
      end
    end
    context 'of a Commons file page' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details("File:Badger 25-07-09.jpg")
        end
      end
    end
    context 'of a full Commons file page url' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details("https://commons.wikimedia.org/wiki/File:Badger 25-07-09.jpg")
        end
      end
    end
    context 'of a Wikipedia image preview url' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
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
  end

  describe '#licence' do
    context 'of a Delhi portrait of a man' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('licence/' + self.class.description).gsub(" ","-") do
          image = Commoner.details("https://commons.wikimedia.org/wiki/File:India_-_Delhi_portrait_of_a_man_-_4780.jpg")
          expect(image[:licence]).to eq("CC BY-SA 3.0")
        end
      end
    end
    context 'of Nahal Zaror, south 11' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('licence/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:licence]).to eq 'CC BY-SA 3.0'
        end
      end
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('licence/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:licence_url]).to eq 'http://creativecommons.org/licenses/by-sa/3.0'
        end
      end
    end
    context 'of The mohave desert near the fossil beds' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('licence/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:PSM_V86_D252_The_mohave_desert_near_the_fossil_beds.jpg'
          expect(image[:licence]).to eq('Public domain')
        end
      end
    end
    context 'of a Spanish Civil War mass grave' do
      it 'is Creative Commons Attribution-Share Alike 4.0 International' do
        VCR.use_cassette ('licence/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:Spanish_Civil_War_-_Mass_grave_-_Estépar,_Burgos.jpg'
          expect(image[:licence]).to eq('CC BY-SA 4.0')
        end
      end
    end
    context 'of August Wilhelm von Hofmann' do
      it 'is public domain' do
        VCR.use_cassette ('licence/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:licence]).to eq('Public domain')
        end
      end
    end
    context 'of August Wilhelm von Hofmann' do
      it 'is public domain' do
        VCR.use_cassette ('licence/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:licence_url]).to eq('https://en.wikipedia.org/wiki/Public_domain')
        end
      end
    end
  end

  describe '#categorised_images' do
    context 'a base category' do
      it 'lists images categorised as this and within subcategories' do
        VCR.use_cassette ('categorised_images/' + self.class.description).gsub(" ","-") do
          images = Commoner.categorised_images("Category:Stolperstein-Plagiate")
        end
      end
    end
  end
end
