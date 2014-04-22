Lita.configure do |config|
  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  config.robot.adapter   = :shell
  config.robot.log_level = :debug

  ## Example: Set options for the Redis connection.
  # config.redis.host = "127.0.0.1"
  # config.redis.port = 1234
end
