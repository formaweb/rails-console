require 'rails_console'

RailsConsole.setup do |options|
  options.strip_tags = true
end

loop do
  print 'Pergunta > '
  question = gets.strip
  break if ['sair', 'exit', 'q', 'quit'].include?(question.downcase)

  puts RailsConsole.ask(question)
end
