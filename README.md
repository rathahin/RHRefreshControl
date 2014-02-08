<p align="center" >
  <img src="https://raw.github.com/rathahin/RHRefreshControl/assets/title.png" alt="RHRefreshControl" title="RHRefreshControl">
</p>

<div style="background-image:url('https://raw.github.com/rathahin/RHRefreshControl/assets/title.png')">
RHRefreshControl is just another simple custom RefreshControl which allow you to customize the appearance and behavior of RefreshControl for your app. With this simple library, you would save few hours to write code to implement with UIScrollView.
</div>

## Getting Started

* Download Library
* Install with Cocoapods

## Classes Reference

* *RHRefreshControl*
* *RHRefreshConfiguration*
* *RHRefreshView Protocol*

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

* // TODO

## Special Thanks

* // TODO

## License

See [LICENSE](https://github.com/rathahin/RHRefreshControl/blob/master/LICENSE).