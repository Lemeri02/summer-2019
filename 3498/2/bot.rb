class Bot
  def initialize(token)
    @bot = Telegram::Bot::Client.new(token)
  end

  def run
    logger = Logger.new(STDOUT)
    poller = Telegram::Bot::UpdatesPoller.new(@bot, WebhooksController, logger: logger)
    poller.start
  end
end
