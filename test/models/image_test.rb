require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should not save image without name' do
    image = Image.new(url: 'https://images.unsplash.com/photo-1591087381452-23e3b9351fe1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
    refute_predicate image, :valid?
  end

  test 'should not save image without url' do
    image = Image.new(name: 'test')
    refute_predicate image, :valid?
  end

  test 'should save image' do
    image = Image.new(name: 'test', url: 'https://images.unsplash.com/photo-1591087381452-23e3b9351fe1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
    assert_predicate image, :valid?
  end

  test 'should not save image with invalid https url' do
    image = Image.create(name: 'test', url: 'https://getbootstrap.com/')
    assert_equal ['invalid image url'], image.errors[:url]
  end

  test 'should not save image with invalid http url' do
    image = Image.create(name: 'test', url: 'http://tineye.com/images/widge2ts/mona.jpg')
    assert_equal ['invalid image url'], image.errors[:url]
  end
end
