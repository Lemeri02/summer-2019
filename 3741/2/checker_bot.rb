require 'telegram/bot'
require 'logger'
require 'time'
require 'redis-activesupport'
require 'active_support/all'
require_relative 'webhook'
require 'dotenv'

Dotenv.load
TOKEN = ENV['TOKEN']
bot = Telegram::Bot::Client.new(TOKEN)
webhook = WebhooksController
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, webhook, logger: logger)
poller.start
