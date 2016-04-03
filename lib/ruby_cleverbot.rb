require 'rest-client'
require 'open-uri'
require 'digest'
require 'htmlentities'

# for debug -> mitmproxy
# PROXY = 'http://127.0.0.1:8080'
# RestClient.proxy = PROXY

# cleverbot api
class RubyCleverbot

  HOST = 'http://www.cleverbot.com'.freeze
  RESOURCE = '/webservicemin'.freeze
  API_URL = HOST + RESOURCE

  HEADERS = {
      'user_agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.7',
      'Accept-Language': 'en-us,en;q=0.8,en-us;q=0.5,en;q=0.3',
      'Cache-Control': 'no-cache',
      'Pragma': 'no-cache'
  }

  attr_reader :cookies
  attr_reader :data
  attr_reader :conversation
  attr_reader :coder

  def initialize
    @coder = HTMLEntities.new
    @data = {
        'stimulus': '',
        'start': 'y',
        'sessionid': '',
        'vText8': '',
        'vText7': '',
        'vText6': '',
        'vText5': '',
        'vText4': '',
        'vText3': '',
        'vText2': '',
        'icognoid': 'wsf',
        'icognocheck': '',
        'fno': 0,
        'prevref': '',
        'cb_settings_language': 'es',
        'emotionaloutput': '',
        'emotionalhistory': '',
        'asbotname': '',
        'ttsvoice': '',
        'typing': '',
        'lineref': '',
        'sub': 'Say',
        'islearning': 1,
        'cleanslate': 'False',
    }
    #get the cookies
    response = make_get(HOST)
    @cookies = response.cookies
    @conversation = []
  end

  # call a get method
  def make_get(url)
    RestClient::Request.execute method: :get, url: url, headers: HEADERS, cookies: cookies
  end

  # call a post method
  def make_post(url, json)
    # RestClient.post url, json, headers
    RestClient::Request.execute method: :post, url: url,payload: URI.encode_www_form(json), headers: HEADERS, cookies: cookies
  end

  def send_message(question)
    # the current question
    data[:stimulus] = question

    # set data, for the conversation
    set_conversation

    # we need the token
    enc_data = URI.encode_www_form(data)
    token = Digest::MD5.hexdigest enc_data[9..34]
    data[:icognocheck] = token
    # puts "the token is #{data[:icognocheck]}"

    response = make_post(API_URL, data)

    clever_response = response.to_str.split(/[\r]+/)

    # see HTML encoding of foreign language characters
    clever_response[0] = coder.decode(clever_response[0])

    # add the log
    conversation << question
    # add response from cleverbot to conversation
    conversation << clever_response[0]

    # return the response
    clever_response[0]
  end

  def set_conversation
    unless conversation.empty?
      count = 1
      conversation.first(8).reverse_each do |line|
        count += 1
        data[('vText' + count.to_s).to_sym] = line
      end
    end
  end

end
