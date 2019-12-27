# frozen_string_literal: true

module AsyncJob
  class JobProcessor
    def initialize(jobstore)
      @jobstore = jobstore
    end

    def run(wait: false)
      loop do
        async_job = @jobstore.fetch(wait: wait)
        async_job ? async_job.perform : break
      end
    end
  end
end
