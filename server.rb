# server.rb
require 'bundler'
Bundler.require

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
  Octokit.readme "#{owner}/#{repo}", :accept => 'application/vnd.github.raw'
end
