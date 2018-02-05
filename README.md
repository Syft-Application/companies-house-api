# CompaniesHouse::Search

## Description

This is a basic implementation of the companies search from the [Companies House API](https://developer.companieshouse.gov.uk/api/docs/)

## Installation

Add this line to your Gemfile:

```ruby
gem 'companies-house-api'
```

And then install:

    $ bundle

You can install the gem manually as follows:

    $ gem install companies-house-api


## Authentication

In order to use the Companies House API you are required to register and create an API key, instructions for this can be found in the [Companies House API Authorisation](https://developer.companieshouse.gov.uk/api/docs/index/gettingStarted/apikey_authorisation.html) page

Special attention should also paid to the following pages

[Comapnies House API Developer Guidelines](https://developer.companieshouse.gov.uk/api/docs/index/gettingStarted/developerGuidelines.html)

[Companies House API Rate Limiting](https://developer.companieshouse.gov.uk/api/docs/index/gettingStarted/rateLimiting.html)

## Setup

Set your api key in an environment variable

``` shell
    export COMPANIES_HOUSE_API_KEY=YOUR_API_KEY_HERE

```

Add your api key to the configuration

``` ruby
    CompaniesHouse.configure do |config|
      config.api_key = ENV['COMPANIES_HOUSE_API_KEY']
    end
``` 

## Example


You can make company searches as follows

``` ruby
    CompaniesHouse::Search.companies(q: 'Company Name', start_index: 0, items_per_page: 20)
```

The `start_index` and `items_per_page` are optional and will be set to defaults of '0' and '10' respectively.
