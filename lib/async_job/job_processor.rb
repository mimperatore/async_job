# frozen_string_literal: true

module AsyncJob
  class JobProcessor
    def initialize(jobstore)
      @jobstore = jobstore
    end

    def run(**options)
      loop do
        async_job = @jobstore.fetch(**options)
        async_job ? async_job.perform : break
      end
    end
  end
end
