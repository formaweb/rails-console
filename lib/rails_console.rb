# require 'rails_console/version'

module RailsConsole
  BASE_COMMAND = 'ssh -t USER@SERVER \'cd PATH/current && COMMAND\''

  @@deploy_file = './config/deploy.rb'
  @@command_mode = :console

  def self.deploy_file
    @@deploy_file
  end

  def self.deploy_file= option
    @@deploy_file = option
  end

  def self.command_mode
    @@command_mode
  end

  def self.command_mode= option
    @@command_mode = option
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

      case @@command_mode
      when :console
        command = command.gsub('COMMAND', 'bundle exec rails c production')
      when :log
        command = command.gsub('COMMAND', 'tail -f log/production.log')
      when :start_puma
        command = command.gsub('COMMAND', 'bundle exec puma -e production -C config/puma_production.rb -d')
      else
        puts "Invalid command mode '#{@@command_mode}', please try --mode with 'console', 'log' or 'start_puma'."
        return
      end

      system(command)
    end

  end
end
