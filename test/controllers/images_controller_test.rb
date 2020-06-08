require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_image_path
    assert_response :success
    assert_select 'h1', text: 'Save an Image'
  end

  test 'create__success' do
    assert_difference('Image.count', 1) do
      post images_path, params: {
        image: {
          name: 'Rails is awesome!',
          url: 'https://images.unsplash.com/photo-1524704796725-9fc3044a58b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
        }
      }
    end
    assert_redirected_to image_path(Image.last)
  end

  test 'create__failure' do
    assert_no_difference('Image.count') do
      post images_path, params: {
        image: {
          name: 'Rails is awesome!',
          url: 'https://api.rubyonrails.org/v6.0.3.1/classes/ActiveSupport/Testing/Assertions.html#method-i-assert_no_difference'
        }
      }
    end
    assert_response :unprocessable_entity
    assert_select 'h1', text: 'Save an Image'
  end

  test 'should get show' do
    image = Image.create!(name: 'test', url: 'https://images.unsplash.com/photo-1591192617272-64be39d91882?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
    get image_path(image)
    assert_select 'h1', text: 'Image detail'
    assert_select 'h5', text: 'test'
  end

  test 'should get index' do
    image_url_list = [
      'https://images.unsplash.com/photo-1588739309531-ae0773a4967a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
      'https://images.unsplash.com/photo-1544568100-847a948585b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
      'https://images.unsplash.com/photo-1501879779179-4576bae71d8d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
      'https://images.unsplash.com/photo-1501879779179-4576bae71d8d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1496497243327-9dccd845c35f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
    ]
    image_url_list.each_with_index do |url, index|
      Image.create(name: "Image#{index}", url: url)
    end
    get root_path
    assert_select 'h1.title', text: 'Image Gallery'
    assert_select 'p.card-text', 5
  end

  test 'should get tag element' do
    image = Image.new(name: 'test', url: 'https://images.unsplash.com/photo-1591192617272-64be39d91882?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
    image.tag_list = 'test'
    image.save!
    get image_path(image)
    assert_select 'span.badge', text: 'test'
  end

  test 'filter__success' do
    image = Image.new(name: 'test', url: 'https://images.unsplash.com/photo-1591192617272-64be39d91882?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
    image.tag_list = 'test'
    image.save!
    get images_path(tag: image.tag_list[0])
    assert_response :success
    assert_select 'h1.title', text: 'Images of test'
  end

  test 'filter__failure' do
    image = Image.new(name: 'test', url: 'https://images.unsplash.com/photo-1591192617272-64be39d91882?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
    image.tag_list = 'test'
    image.save!
    get images_path(tag: 'new_tag')
    assert_response 404
    assert_select 'body', text: 'You are being redirected.'
  end
end
