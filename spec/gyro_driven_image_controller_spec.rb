describe GyroDrivenImageViewController do

  before do
    @gyro_image_controller = GyroDrivenImageViewController.new
    @gyro_image_controller.set_up_view(0,0,640,568)
    @gyro_image_controller.shake_threshold = 0.1
    @gyro_image_controller.viewDidLoad
  end

  it "should initialize the motion manager" do
    @gyro_image_controller.instance_variable_get(:@motion_manager).class.should == CMMotionManager
  end
  
  it "should set up the gyro on screen appear" do
    @gyro_image_controller.should.receive(:set_up_gyro)
    @gyro_image_controller.viewDidAppear nil
  end
  
  it "should tear down the gyro on screen disappear" do
    @gyro_image_controller.should.receive(:tear_down_gyro)
    @gyro_image_controller.viewWillDisappear nil
  end

  describe "new scroll offset on tilt" do
    before do
      @gyro_image_controller.set_up_view(0,0,320,568)
      @gyro_image_controller.set_image UIImage.imageNamed("sample_640_spec_image.jpeg")
    end

    it "should return the scroll offset when shifting to the left" do
      new_offset = @gyro_image_controller.get_scroll_offset_towards_left 0.5
      new_offset.should == 80
    end

    it "should return the scroll offset when shifting to the right" do
      new_offset = @gyro_image_controller.get_scroll_offset_towards_right -0.5
      new_offset.round.should == 240
    end
  end
end
