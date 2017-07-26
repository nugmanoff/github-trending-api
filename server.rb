# server.rb
require 'net/http'
require 'bundler'
Bundler.require

def get_readme(owner, repo)
  url = URI("https://api.github.com/repos/#{owner}/#{repo}/readme")
  res = Net::HTTP.get_response(url) # => String
  res.body
end

before do
  content_type 'application/json'
end

get '/languages' do
  json = File.read('languages.json')
end

get '/repos/' do
  lang = params[:language] if params[:language]
  since = params[:since] if params[:since]
  repos = GitTrend.get(lang, since)
  repos.map { |repo|
    repo.to_h }.to_json
end

get '/repos/:owner/:repo/readme' do
  owner = params[:owner] if params[:owner]
  repo = params[:repo] if params[:repo]
  get_readme(owner, repo)
end
