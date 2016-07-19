module PostsHelper
  
  def post_url
    params[:link].presence || params[:post][:link]
  end
  
  # Get document title.
  def post_title(doc)
    doc.css('div.main_wrap h1').text.presence || meta_content(doc, 'og:title')
  end
  
  # Get document price
  def post_price(doc)
    price = doc.css('b[itemprop="price"]').text.presence || doc.css('.price01 b').text
    price.presence || 0
  end
  
  # Get meta image
  def post_image(doc)
    meta_content(doc, 'og:image')
  end
  
  private
  
    def meta_content(doc, property)
      doc.css("meta[property='#{property}']").attr("content").presence || nil
    end
end
