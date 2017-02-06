require 'ruby_cleverbot'

if ARGV[0] != nil
  bot1 = RubyCleverbot.new('helloBot')
  bot2 = RubyCleverbot.new('helloBot')
  seed = ARGV[0]
  message1 = bot1.send_message(seed)
  8.times{
    puts "bot1 : #{message1}"
    message2 = bot2.send_message(message1)
    puts "bot2 : #{message2}"
    message1 = bot1.send_message(message2)
  }
else
  puts "a initial word is required"
end
