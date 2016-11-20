class UpdateItemsJob < ActiveJob::Base
  def perform(item_id)
    # Find the item in db
    item = Item.find(item_id)
    puts "-> Updating item info with ID: #{item.id} and SKU: #{item.sku} ..."
    # Start Watir Browser with Phantom JS (headless browser)
    browser = Watir::Browser.new(:phantomjs)
    browser.goto("http://www.asos.com/prd/#{item.sku}")
    # Get the item name
    item.full_name = browser.div(class: 'product-hero').h1.text if browser.div(class: 'product-hero').h1.present?
    #  Get the item brand
    item.brand = browser.div(class: 'brand-description').strong.text if browser.div(class: 'brand-description').strong.present?
    # Get the item category
    item.category_1 = browser.div(class: 'product-description').strong.text if browser.div(class: 'product-description').strong.present?
    # Get the item product code
    item.product_code = browser.div(class: 'product-code').span.text if browser.div(class: 'product-code').present?
    # Check if the item is in stock/is continued
    item.in_stock = browser.div(class: 'out-of-stock').text.empty? if browser.div(class: 'out-of-stock').present?
    # Get the item details
    new_details = []
    browser.div(class: 'product-description').ul.lis.each { |i| new_details.push(i.text) unless i.text.empty? } if browser.div(class: 'product-description').ul.present?
    item.details = new_details
    # Get the item sizes with marked if size is not available
    new_sizes = {}
    if browser.div(class: 'size-section').select.present?
      browser.div(class: 'size-section').select.options.each do |o|
        (o.text.include?('Not available') ? new_sizes[o.text.chomp(' - Not available')] = false : new_sizes[o.text] = true) unless o.text == 'Please select'
      end
    end
    item.sizes = new_sizes
    # Get the item color
    item.color = browser.span(class: 'product-colour').text if browser.span(class: 'product-colour').present?
    # Get the item price
    item.price = browser.span(class: 'current-price').text.delete('£').to_f if browser.span(class: 'current-price').present?
    # Get the item washing instuctions
    item.washing_instructions = browser.div(class: 'care-info').p.text if browser.div(class: 'care-info').p.present?
    # Get the item materials
    new_materials = {}
    if browser.div(class: 'about-me').span.present?
      mat_arr = browser.div(class: 'about-me').span.text.delete(' ').chomp('.').split(/,|:/)
      mat_arr.each do |elem|
        elem.exclude?('%') ? new_materials[elem.downcase] = {} : new_materials[new_materials.keys.last][elem.split('%')[1].downcase] = elem.split('%')[0].to_i
      end
    end
    item.materials = new_materials
    # Get the item list of photos
    new_photos = []
    if browser.div(class: 'product-gallery').div(class: 'thumbnails').ul.present?
      browser.div(class: 'product-gallery').div(class: 'thumbnails').ul.lis(class: 'image-thumbnail').each do |photo|
        new_photos.push(photo.a.img.src.split('?')[0])
      end
    end
    item.photo_urls = new_photos
    # Get the item url
    item.product_url = browser.url
    # Capture a screenshot of the item page
    # browser.screenshot.save("product_photos/#{item.brand}_#{item.sku}_#{item.product_code}")
    # Close the Watir browser
    browser.close
    # Save the item
    item.save!
    puts "-> Done for item with ID: #{item.id} and SKU: #{item.sku} !"

  rescue Watir::Exception::UnknownObjectException => e
    puts "*** ! Error on item: id: #{item.id}, sku: #{item.sku}, error: #{e} ! ***"
    item.save!
    puts '*** ! Emegency save - Item is incomplete ! ***'
  rescue Net::ReadTimeout => e
    puts "*** ! Error on item: id: #{item.id}, sku: #{item.sku}, error: #{e} ! ***"
    item.save!
    puts '*** ! Emegency save - Item is incomplete ! ***'
  end
end
