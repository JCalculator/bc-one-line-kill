class TitleFetchJob < ApplicationJob
  queue_as :default

  def perform(id, url)
    html = URI.open(url)
    html.css('title').each do |title|
      link = Link.find(id)
      link.title = title.text
      link.save
      break
    end
  end
end
