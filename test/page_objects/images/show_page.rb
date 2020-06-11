module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image
      element :flash_message, locator: '#notice'
      element :back_btn, locator: '.js-back'

      def image_url
        node.find('img')['src']
      end

      def tags
        node.all('.text-dark').map(&:text).join(', ').split(' ')
      end

      def delete
        node.click_on('Delete')
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        # TODO
        node.click_on('Delete')
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        back_btn.node.click
        window.change_to(IndexPage)
      end
    end
  end
end
