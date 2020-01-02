# frozen_string_literal: true

module AsyncJob
  RSpec.describe InMemoryServer do
    let(:worker_class) do
      Class.new do
        include Worker

        def perform; end
      end
    end

    let(:now) { Time.now }
    let(:num_threads) { 1 }
    let(:num_jobs) { 1 }
    let(:jobstore) { InMemoryJobStore.new }
    let(:jobs) { num_jobs.times.map { MyWorker.perform_async } }

    subject do
      described_class.new(num_threads, jobstore)
    end

    before(:each) do
      Timecop.freeze(now)
    end

    before(:each) do
      MyWorker.jobstore = InMemoryJobStore.new
      jobs
    end

    around(:each) do |example|
      Object.const_set('MyWorker', worker_class)
      example.run
      Object.send(:remove_const, 'MyWorker')
    end

    EXPECTED_TIMES = {
      [10_000, 10] => 1,
      [100_000, 10] => 10
    }.freeze

    [10_000, 100_000].each do |j|
      describe "#{j} jobs", performance: true do
        [10].each do |t|
          context "number of threads: #{t}" do
            let(:num_threads) { t }
            let(:num_jobs) { j }

            it "processes everything in under #{EXPECTED_TIMES[[j, t]]} seconds" do
              subject.stop_at(now + 100)
              Timecop.travel(now + 100)
              starting_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
              subject.start.join
              ending_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
              expect(ending_time - starting_time).to be < EXPECTED_TIMES[[j, t]]
            end
          end
        end
      end
    end
  end
end
