# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'watir'
require 'nokogiri'
browser = Watir::Browser.new :chrome, headless: true

before do
  content_type :json

  # Input text
  @text = params['text']

  # Input language
  @sl = params['sl'] || 'en'

  # Translation language
  @tl = params['tl'] || 'pt-BR'

  # User navigator language (default browser language or preference)
  @hl = params['hl'] || @tl

  # Initialize response object
  @op_response = {
    text: @text,
    translations: []
  }

  @url = "https://translate.google.com/?sl=#{@sl}&tl=#{@tl}&hl=#{@hl}&text=#{@text}&op=translate"
end

get '/translate' do
  browser.goto @url
  sleep 1

  doc = Nokogiri::HTML.parse(browser.html)

  results = doc.css('[data-result-index]')

  results.each do |result|
    basic_result = result.at_css('[jsname="W297wb"]')&.text
    complex_result = result.at_css('.VIiyi')&.text

    variation_description = result.at_css('.NlvNvf')&.text

    @op_response[:translations].push({
      data: basic_result || complex_result,
      variationDescription: variation_description
    }.compact)
  end

  @op_response.to_json
end
