class WelcomeController < ApplicationController
	def index
		url = "http://blog.ethansteiner.com"
		agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
		html = agent.get(url).body
		html_doc = Nokogiri::HTML(html)
		@post_one = html_doc.css('a')[10].children.text
		@post_three = html_doc.css('a')[7].children.text
		@post_two = html_doc.css('a')[13].children.text
		@projects = Project.all.limit(3).order("created_at desc")
	end
end
