# server.rb
require 'yaml'
require 'bundler'
Bundler.require

def search_for_lang_color(lang)
  yaml = YAML.load_file('languages.yml')
  return yaml[lang]["color"]
end

before do
  content_type 'application/json'
end

get '/languages' do
  response = {
    color: search_for_lang_color("API Blueprint")
  }
  response.to_json
end

get '/repos/' do
  lang = params[:language] if params[:language]
  since = params[:since] if params[:language]
  repos = GitTrend.get(lang, since)
  repos.map { |repo|
    repo.to_h }.to_json
end

get '/repos/:owner/:repo/readme' do

end
