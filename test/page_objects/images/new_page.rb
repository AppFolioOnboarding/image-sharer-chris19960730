module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images

      form_for :image do
        element :name, locator: '.name'
        element :url, locator: '.url'
        element :tag_list, locator: '.tag_list'
      end
      element :url_error, locator: '.url_error'

      def create_image!(name: nil, url: nil, tags: nil)
        
        self.name.set(name) if name.present?
        self.url.set(url) if url.present?
        tag_list.set(tags) if tags.present?
        node.click_on('Save')
        window.change_to(ShowPage, NewPage)
      end
    end
  end
end
