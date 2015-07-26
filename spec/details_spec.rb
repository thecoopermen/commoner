require 'spec_helper'

describe Commoner do

  describe '#details' do
    context 'of a non-file page name' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          images = Commoner.details 'Meles meles'
        end
      end
    end
    context 'of an unknown page name' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:xyz.jpg'
        end
      end
    end
    context 'of a Commons file page' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'File:Badger 25-07-09.jpg'
        end
      end
    end
    context 'of a full Commons file page url' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'https://commons.wikimedia.org/wiki/File:Badger 25-07-09.jpg'
        end
      end
    end
    context 'of a Wikipedia image preview url' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'https://en.wikipedia.org/wiki/Main_Page#mediaviewer/File:Suillus_pungens_123004.jpg'
        end
      end
    end
    context 'of url with a strange character in' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'https://commons.wikimedia.org/wiki/File:Jacobäerschild_in_Bautzen.JPG'
        end
      end
    end
    context 'of url for Jacob with unicode in' do
      it 'gives details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'https://commons.wikimedia.org/wiki/File:Jacob%C3%A4erschild_in_Bautzen.JPG'
        end
      end
    end
    context 'of a deleted photo' do
      it 'gives a description of "missing"' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Commoner.details 'https://commons.wikimedia.org/wiki/File:Vancouver_-_Gastown_Steam_Clock_plaque.jpg'
          expect(image[:description]).to eq 'missing'
        end
      end
    end
  end

end
