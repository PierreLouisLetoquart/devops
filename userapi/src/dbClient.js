var redis = require("redis");
const configure = require('./configure');

const config = configure();
var client = redis.createClient({
  host: process.env.REDIS_HOST || "127.0.0.1",
  port: process.env.REDIS_PORT || 6379,
  retry_strategy: (options) => {
    if (options.attempt > 50) {
        // End reconnecting with built in error
        return undefined;
    }
    if (options.total_retry_time > 1000 * 60 * 60) {
        // End reconnecting after a specific timeout and flush all commands with an individual error
        return new Error('Retry time exhausted');
    }
    // reconnect after
    return Math.min(options.attempt * 100, 3000);
  }
});

process.on('SIGINT', function() {
  client.quit();
});

module.exports = client;
