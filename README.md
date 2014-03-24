<p align="center" >
  <img src="https://raw.github.com/rathahin/RHRefreshControl/assets/title.png" alt="RHRefreshControl" title="RHRefreshControl">
</p>

<div style="background-image:url('https://raw.github.com/rathahin/RHRefreshControl/assets/title.png')">
RHRefreshControl is just another simple custom RefreshControl which allow you to customize the appearance and behavior of RefreshControl for your app. With this simple library, you would save few hours to write code to implement with UIScrollView.
</div>

## Getting Started

* Install with Cocoapods

```
platform :ios, "6.0"

pod 'RHRefreshControl'

```

## Classes Reference

* Documentation will provice in the future

## Initiate

```objective-c

RHRefreshControl *refreshControl = [[RHRefreshControl alloc]
                                    initWithConfiguration:refreshConfiguration];

```

## Configuration

* `Preset Style` Configuration

```objective-c

RHRefreshControlConfiguration *refreshConfiguration = [[RHRefreshControlConfiguration alloc] init];

refreshConfiguration.refreshView = RHRefreshViewStylePinterest;

```

* `Your own view` Configuration

```objective-c

CutomRefreshView *customRefreshView = [[CutomRefreshView alloc]
                                       initWithFrame:CGRectMake(0, 0, 320, 60)];

RHRefreshControlConfiguration *refreshConfiguration = [[RHRefreshControlConfiguration alloc] init];

refreshConfiguration.refreshView = customRefreshView;

```

## Custom Refresh View

* Please check [tutorial](http://nsdesigner.mobi/2014/03/10/rhrefreshcontrol.html).

## Special Thanks

* I would like to thank [Erik S](https://github.com/eriksundin) for giving me alot ideas and development tips.

## License

See [LICENSE](https://github.com/rathahin/RHRefreshControl/blob/master/LICENSE).

## Todo
* Supporting UIScrollView