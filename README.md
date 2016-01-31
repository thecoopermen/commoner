# Commoner

Simple gem for searching the Wikimedia Commons for media. What more is there to say?

## Installation

Add this line to your application's Gemfile:

    gem 'commoner', :github => 'jnicho02/commoner', :branch => 'licence-details'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install commoner

## Usage

    require 'commoner'

    wikimedia = Commoner.details("File:"+wikimedia_filename)
    wikimedia[:categories]
    wikimedia[:url]
    wikimedia[:page_url]
    wikimedia[:description]
    wikimedia[:author] 
    wikimedia[:author_url]
    wikimedia[:licence]
    wikimedia[:licence_url])

    Commoner.search 'term'

    Commoner.images 'term'

    Commoner.categorised_images 'category'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
