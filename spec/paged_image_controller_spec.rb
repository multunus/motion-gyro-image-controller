describe PagedImageController do
  extend Facon::SpecHelpers

  before do
    @paged_image_controller = PagedImageController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal, options: {
"UIPageViewControllerOptionInterPageSpacingKey" => 5.0
})
    @paged_image_controller.index = 0
    @paged_image_controller.items_list = ["http://sample.image.url"]
  end
  
  it "should setup the image controller" do
    @paged_image_controller.should.receive(:set_image_with_url)
    image_controller = @paged_image_controller.set_up_image_controller
    image_controller.class.should == GyroDrivenImageViewController
  end

  it "should set the right control variables" do
    image_controller = GyroDrivenImageViewController.new
    @paged_image_controller.set_control_variables image_controller
    image_controller.shake_threshold.should == 0.1
  end

  it "should set up sample data" do
    @paged_image_controller.set_up_sample_data
    @paged_image_controller.items_list.count.should == 5
  end
end
