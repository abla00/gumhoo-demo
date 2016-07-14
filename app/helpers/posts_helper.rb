module PostsHelper
  
  def post_url
    return (params[:link].present?) ? params[:link] : params[:post][:link]
  end
  
  # Get document title.
  def post_title(doc)
    return doc.css('div.main_wrap h1').text if doc.css('div.main_wrap h1').present?
    return meta_content(doc, 'og:title')
  end
  
  # Get document price
  def post_price(doc)
    return doc.css('b[itemprop="price"]').text if doc.css('b[itemprop="price"]').present?
    return doc.css('.price01 b').text if doc.css('.price01 b').present?
    return 0
  end
  
  # Get meta image
  def post_image(doc)
    meta_content(doc, 'og:image')
  end
  
  private
  
    def meta_content(doc, property)
      node = doc.css("meta[property='#{property}']")
      node.attr("content") if node.present?
    end
end
