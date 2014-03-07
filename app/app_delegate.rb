class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = PagedImageController.alloc.initWithTransitionStyle(UIPageViewControllerTransitionStyleScroll, navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal, options: {
"UIPageViewControllerOptionInterPageSpacingKey" => 5.0
})
    true
  end
end
