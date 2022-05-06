# README

  Ruby Version: 2.7.0

  Rails Version: 7.0.2

## Setup

  Install `ruby 2.7.0`

  To install dependencies run command `bundle install`

## Run application

  To run application run command `rails s`

  To check output run command `curl localhost:3000`
## Test

  To run test cases run command `bundle exec rspec`

## Details

  API fetches data from  https://takehome.io/ site and parse it and gives the response.

  We have three social media platforms `facebook`, `twitter` and `instagram`.

  All have unpredictable outputs, success case respond with json data and error case response with a error string.

  In case of success we return the parsed output required. and for the error case we return empty array.
