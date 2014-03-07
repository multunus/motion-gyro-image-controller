class GyroDrivenImageViewController < ScrollingImageViewController
  attr_accessor :update_interval, :shake_threshold, :motion_rate

  def viewDidLoad
    super
    @motion_manager = CMMotionManager.alloc.init
  end

  def viewDidAppear animated
    super
    set_up_gyro if gyro_available
  end
  
  def viewWillDisappear(animated)
    super
    tear_down_gyro if gyro_available
  end
  
  def gyro_available
    @motion_manager.isGyroAvailable
  end
  
  def significant_tilt
    @motion_manager.deviceMotion.rotationRate.y.abs >= self.shake_threshold
  end

  def device_motion_available
    @motion_manager.deviceMotion
  end

  def set_up_gyro
    initialize_gyro_setup
    activate_timer_control
  end

  def initialize_gyro_setup
    @motion_manager.showsDeviceMovementDisplay = true
    @motion_manager.deviceMotionUpdateInterval = self.update_interval
    @motion_manager.startDeviceMotionUpdates
  end

  def tear_down_gyro
    @timer.cancel!
    @motion_manager.stopDeviceMotionUpdates
  end

  def activate_timer_control
    queue  = Dispatch::Queue.current
    @timer = Dispatch::Source.timer(self.update_interval, self.update_interval, 0.0, queue) do |source|
      begin
        periodic_timer
      ensure
        # source.cancel!
      end
    end 
  end
  
  def periodic_timer
    if gyro_requirements_met? && content_exceeds_available_space?
      roll = @motion_manager.deviceMotion.rotationRate.y * self.motion_rate
      if roll > 0
        new_offset = get_scroll_offset_towards_left roll
      elsif roll < 0
        new_offset = get_scroll_offset_towards_right roll
      end
      @scroll_view.setContentOffset([new_offset, @scroll_view.contentOffset.y], animated: false)
    end
  end

  def get_scroll_offset_towards_left roll
    current_offset = @scroll_view.contentOffset.x
    new_offset = current_offset - (current_offset * roll)
    new_offset = 0 if new_offset < 0
    new_offset
  end

  def get_scroll_offset_towards_right roll
    current_offset = @scroll_view.contentOffset.x
    width = @scroll_view.contentSize.width - self.width
    new_offset = current_offset - ((width - current_offset) * roll)
    new_offset = width if new_offset > width
    new_offset
  end

  def gyro_requirements_met?
    device_motion_available && significant_tilt && @scroll_view
  end

  def content_exceeds_available_space?
    @scroll_view.contentSize.width > self.width
  end

  def fit_image_to_height
    super
    set_up_gyro if gyro_available
  end
end
