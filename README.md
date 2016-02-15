# iOS (RubyMotion) Image Controller with Tilt Control

[![Code Climate](https://codeclimate.com/github/multunus/motion-gyro-image-controller.png)](https://codeclimate.com/github/multunus/motion-gyro-image-controller)

This library facilitates the use of tilt to preview images. So for images that
extend beyond the space allocated to them, a simple tilt of the device will let
you preview the rest of the sections of the image. Special thanks to team
[lorempixel](http://lorempixel.com/) for their super awesome service of providing
great placeholder images.

![Animated GIF of Sample Implementation](http://dl.dropboxusercontent.com/s/1a1vcisjmi81ctz/gyro-image-sample.gif)

## Usage

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'motion-gyro-image-controller'
```

And then execute:
```ruby
bundle
```

### Sample App

A sample app is included for reference. To get it up and running, simply clone the
repository and run ```rake``` or ```rake device``` depending on whether you want
to preview it in the simulator or device.

### Using in your app

But here is how you can go about using this library:

1.  Initialize the image controller as follows:

    ```ruby
image_controller = GyroDrivenImageViewController.new
    ```

2. Set up the origin and size of the view using the following method:

    ```ruby
image_controller.set_up_view(x_origin, y_origin, width, height)
    ```

3. Set the control variables for sensitivity, update frequency and image motion rate:

    ```ruby
image_controller.update_interval = update_interval    # sample value: 1.0/120.0
image_controller.motion_rate = image_motion_rate      # sample value: PI/180.0
image_controller.shake_threshold = shake_sensitivity  # sample value: 0.1
    ```

4. In case you intend to use this in an image gallery, you may need to assign each
image an index. We have provided an index value for each controller:

    ```ruby
image_controller.index = index
    ```

5. To set the actual image, there is a method that accepts an instance of ```UIImage```.
The sample app provides an example of how to use the ```setImageWithURL``` method
to pull images from a server and use them. The syntax for the method to set the
image is:

    ```ruby
image_controller.set_image image
    ```

## Contributing

See the [CONTRIBUTING] document.
Thank you, [contributors]!

  [CONTRIBUTING]: CONTRIBUTING.md
  [contributors]: https://github.com/multunus/motion-gyro-image-controller/graphs/contributors

## License

iOS (RubyMotion) Image Controller with Tilt Control is Copyright (c) 2016 Multunus
Software Pvt. Ltd. It is free software, and may be redistributed under the terms
specified in the [LICENSE] file.

  [LICENSE]: /LICENSE

## About

![multunus](https://s3.amazonaws.com/multunus-images/Multunus_Logo_Vector_resized.png)

iOS (RubyMotion) Image Controller with Tilt Control is maintained and funded by
Multunus Software Pvt. Ltd. The names and logos for Multunus are trademarks of
Multunus Software Pvt. Ltd.

We love open source software!
See [our other projects][community]
or [hire us][hire] to help build your product.

  [community]: http://www.multunus.com/community?utm_source=github
  [hire]: http://www.multunus.com/contact?utm_source=github
