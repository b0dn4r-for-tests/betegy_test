Config.setup do |config|
  config.const_name = 'Settings'

  # config.knockout_prefix = nil
  # config.merge_nil_values = true
  # config.overwrite_arrays = true
  # config.use_env = false

  config.env_prefix = 'SETTINGS'

  # config.env_separator = '.'
  # config.env_converter = :downcase
  # config.env_parse_values = true
  # config.schema do
  #   required(:name).filled
  #   required(:age).maybe(:int?)
  #   required(:email).filled(format?: EMAIL_REGEX)
  # end
  # config.evaluate_erb_yaml = true
end
