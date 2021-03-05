require "yaml"

`git clone git@github.com:svenfuchs/rails-i18n.git /tmp/rails-i18n`

Dir.glob("/tmp/rails-i18n/rails/locale/*.yml").each do |path|
  locale = Path[path].stem

  yaml = File.open(path) { |file| YAML.parse(file) }

  if distance_in_words = yaml[locale]["datetime"]["distance_in_words"]
    hash = {locale => {"humanize_time" => distance_in_words}}

    output = "./src/locales/#{locale}.yml"

    File.open(output, "w") { |f| hash.to_yaml(f) }
  end
end

`rm -rf /tmp/rails-i18n`
