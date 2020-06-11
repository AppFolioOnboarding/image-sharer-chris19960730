module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images
      element :flash_message, locator: '#notice'
      element :view_btn, locator: '.image-view'
      collection :images, locator: '.image-container', item_locator: '.card', contains: ImageCard do
        def view!
          node.click_on('View')
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('Save an image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        images.any? do |image|
          result = image.url == url
          tags.present? ? (result && image.tags == tags) : result
        end
      end

      def clear_tag_filter!
        # TODO
        node.click_on('remove filter')
        window.change_to(IndexPage)
      end
    end
  end
end
