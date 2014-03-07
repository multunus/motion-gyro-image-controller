class ScrollingImageViewController < UIViewController
  attr_accessor :index, :x, :y, :width, :height

  def set_up_view(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    @scroll_view = set_up_scroll_view
    @image_view = set_up_image_view
    @scroll_view.addSubview(@image_view)
    self.view.addSubview(@scroll_view)
  end

  def set_up_scroll_view
    scroll_view = UIScrollView.alloc.initWithFrame(CGRectMake(self.x, self.y, self.width, self.height))
    scroll_view.showsHorizontalScrollIndicator = false
    scroll_view.showsVerticalScrollIndicator = false
    scroll_view.delegate = self
    scroll_view.scrollEnabled = false
    scroll_view
  end
  
  def set_up_image_view
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, self.width, self.height))
    image_view.contentMode = UIViewContentModeScaleToFill
    image_view
  end

  def set_image image
    @image_view.image = image
    fit_image_to_height
  end

  def fit_image_to_height
    final_height = self.height
    final_width = (@image_view.image.size.width / @image_view.image.size.height) * final_height
    scroll_offset =  ((final_width - self.width) / 2).abs
    @image_view.frame = CGRectMake(0, 0, final_width, final_height)
    @scroll_view.contentSize = CGSizeMake(final_width, final_height)
    @scroll_view.setContentOffset(CGPointMake(scroll_offset, 0), animated: false)
  end
end
