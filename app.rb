require 'rubygems'
require 'sinatra'
require './idea'
require './idea_store'

get '/' do
  erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new}
end

not_found do
  erb :error
end

post '/' do
  idea = Idea.new(params[:idea])
  idea.save
  redirect '/'
end

put '/:id' do |id|
  IdeaStore.update(id.to_i, params[:idea])
  redirect '/'
end

delete '/:id' do |id|
  IdeaStore.delete(id.to_i)
  redirect '/'
end

get '/:id/edit' do |id|
  idea = IdeaStore.find(id.to_i)
  erb :edit, locals: {idea: idea}
end

post '/:id/like' do |id|
  idea = IdeaStore.find(id.to_i)
  idea.like!
  IdeaStore.update(id.to_i, idea.to_h)
  redirect '/'
end

post '/:id/hate' do |id|
  idea = IdeaStore.find(id.to_i)
  idea.hate!
  IdeaStore.update(id.to_i, idea.to_h)
  redirect '/'
end
