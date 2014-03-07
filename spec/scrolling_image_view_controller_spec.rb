describe ScrollingImageViewController do
  before do
    @scrolling_image_view_controller = ScrollingImageViewController.new
  end

  it "should set up the main view" do
    @scrolling_image_view_controller.set_up_view(0, 0, 20, 30)
    @scrolling_image_view_controller.width.should == 20
    @scrolling_image_view_controller.height.should == 30
    @scrolling_image_view_controller.view.subviews.count.should == 1
  end

  it "should set up the scroll view" do
    @scrolling_image_view_controller.width = 20
    @scrolling_image_view_controller.height = 20
    @scrolling_image_view_controller.x = 20
    @scrolling_image_view_controller.y = 20
    scroll_view = @scrolling_image_view_controller.set_up_scroll_view
    scroll_view.class.should == UIScrollView
    scroll_view.isScrollEnabled.should == false
  end

  it "should set up the image view" do
    @scrolling_image_view_controller.width = 20
    @scrolling_image_view_controller.height = 20
    image_view = @scrolling_image_view_controller.set_up_image_view
    image_view.class.should == UIImageView
  end

  it "should set an image to the image view" do
    image = UIImage.new
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, 20, 20))
    @scrolling_image_view_controller.instance_variable_set(:@image_view, image_view)
    @scrolling_image_view_controller.should.receive(:fit_image_to_height)
    @scrolling_image_view_controller.set_image image
    @scrolling_image_view_controller.instance_variable_get(:@image_view).image.should == image
  end


  describe "image and scroll view adjustments" do
    before do
      image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed('sample_spec_image.jpeg'))
      @scrolling_image_view_controller.instance_variable_set(:@image_view, image_view)
      scroll_view = UIScrollView.new
      @scrolling_image_view_controller.instance_variable_set(:@scroll_view, scroll_view)
      @scrolling_image_view_controller.width = 20
      @scrolling_image_view_controller.height = 20
      @final_width = (20.0/30.0 * 20)
      @scrolling_image_view_controller.fit_image_to_height
    end

    it "should fit an image to the available height" do
      scroll_view = @scrolling_image_view_controller.instance_variable_get(:@scroll_view)
      scroll_view.contentSize.height.should == 20
      scroll_view.contentSize.width.should == @final_width
    end

    it "should set the content offset" do
      scroll_offset = ((@final_width - 20) / 2).abs.round
      @scrolling_image_view_controller.instance_variable_get(:@scroll_view).contentOffset.x.should == scroll_offset
    end
  end
end
