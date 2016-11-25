require 'sinatra'
require 'active_record'
require 'securerandom'

set :environment, :production

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection :development

class Post < ActiveRecord::Base
end

def get_wday_str(wday)
  case wday
  when 0 then "日"
  when 1 then "月"
  when 2 then "火"
  when 3 then "水"
  when 4 then "木"
  when 5 then "金"
  when 6 then "土"
  end
end

get '/' do
    @posts = Post.all
    erb :index
end

post '/' do
  user_name = Rack::Utils.escape_html(params[:name])
  msg = Rack::Utils.escape_html(params[:message])
  t = Time.now
  date = "#{t.year}/#{t.month}/#{t.day}(#{get_wday_str(t.wday)}) #{t.hour}:#{t.min}:#{t.sec}"
  Post.create(id_str: SecureRandom.base64(8), message: msg, posted_at: date, name: user_name)
  redirect '/'
end

delete '/' do
  s = Post.find(params[:id])
  s.destroy
  redirect '/'
end

