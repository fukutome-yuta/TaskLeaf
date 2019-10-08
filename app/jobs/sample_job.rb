class SampleJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    logger.info "メールを送信しました"
  end
end
