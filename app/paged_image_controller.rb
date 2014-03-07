class PagedImageController < UIPageViewController
  attr_accessor :items_list, :index
  
  def viewDidLoad
    super
    set_page_controller_attributes
    set_up_sample_data
    self.index = 0
    @image_controller = set_up_image_controller
    self.setViewControllers([@image_controller], direction: UIPageViewControllerNavigationDirectionForward, animated: true, completion: nil)
  end

  def set_page_controller_attributes
    self.dataSource = self
    self.delegate = self
    self.doubleSided = false
  end

  def set_up_sample_data
    self.items_list = []
    5.times do |n|
      self.items_list << "http://lorempixel.com/620/568/transport/#{n}"
    end
  end

  def pageViewController(page_view_controller, viewControllerBeforeViewController: view_controller)
    self.index = view_controller.index - 1
    if self.index < 0
      self.index = 0
      return nil
    end
    @prev_image_controller = set_up_image_controller
  end
  
  def pageViewController(page_view_controller, viewControllerAfterViewController: view_controller)
    self.index = view_controller.index + 1
    if self.index >= self.items_list.count
      self.index = self.items_list.count - 1
      return nil
    end
    @next_image_controller = set_up_image_controller
  end

  def set_up_image_controller
    image_controller = GyroDrivenImageViewController.new
    screen_size = get_screen_size
    image_controller.set_up_view(20, 20, screen_size.width - 40, screen_size.height - 40)
    set_control_variables image_controller
    image_controller.index = self.index
    set_image_with_url image_controller, self.items_list[self.index], "placeholder.jpeg"
    image_controller
  end

  def set_control_variables image_controller
    image_controller.update_interval = 1.0/120.0
    image_controller.motion_rate = 3.1415926/180.0
    image_controller.shake_threshold = 0.1
  end

  def set_image_with_url controller, image_url, placeholder
    image_view = UIImageView.alloc.initWithFrame(CGRectZero)
    completed_block = Proc.new do |request, response, image|
      controller.set_image image
    end
    placeholder = UIImage.imageNamed placeholder
    controller.set_image placeholder
    image_view.setImageWithURLRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(image_url)), placeholderImage: placeholder, success: completed_block, failure: nil)
  end

  def get_screen_size
    UIScreen.mainScreen.bounds.size
  end
end
