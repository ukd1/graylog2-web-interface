if defined?(MetricFu)
  MetricFu::Configuration.run do |config|
    # let's start from rcov only
    config.metrics = [:rcov]
    config.graphs = config.metrics

    config.rcov = { :environment => 'test',
                    :test_files  => ['test/unit/*_test.rb'],
                    :rcov_opts   => ["-Itest",
                                     "--sort coverage",
                                     "--text-coverage",
                                     "--no-html",
                                     "--no-color",
                                     "--rails",
                                     "--exclude /\/test\//,/\/gems\//"] }
    config.verbose = true
  end
end
