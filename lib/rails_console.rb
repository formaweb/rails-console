# require 'rails_console/version'

module RailsConsole
  BASE_COMMAND = 'ssh -t USER@SERVER \'cd PATH/current && bundle exec rails c production\''

  @@deploy_file = './config/deploy.rb'

  def self.deploy_file
    @@deploy_file
  end

  def self.deploy_file= option
    @@deploy_file = option
  end

  def self.setup(&block)
    yield self
  end

  def self.connection
    connection_data = { user: nil, server: nil, path: nil }

    File.open(@@deploy_file, 'r') do |f|
      f.each_line do |line|
        if line =~ /deploy_to/
          connection_data[:path] = line.match(/"([^"]*)"/)[1]
        end

        if line =~ /user/
          connection_data[:user] = line.match(/"([^"]*)"/)[1]
        end

        if line =~ /role/ && line =~ /web/
          connection_data[:server] = line.match(/"([^"]*)"/)[1]
        end

      end
    end

    if connection_data.values.include?(nil)
      puts "ERROR to get data from deploy file."
    else
      command = BASE_COMMAND.gsub('USER', connection_data[:user]).gsub('PATH', connection_data[:path]).gsub('SERVER', connection_data[:server])
      puts "Connecting to #{connection_data[:server]} into #{connection_data[:path]}..."

      system(command)
    end

  end
end
