//
//  RHRefreshControlViewPinterest.m
//  Example
//
//  Created by Ratha Hin on 2/2/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "RHRefreshControlViewPinterest.h"
#import "RHAnimator.h"

@interface RHRefreshControlViewPinterest ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) CALayer *iconLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation RHRefreshControlViewPinterest

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self commonSetupOnInit];
    }
    return self;
}

- (void)commonSetupOnInit {
  CAShapeLayer *circle = [CAShapeLayer layer];
  circle.frame = CGRectMake(0, 0, 25.0f, 25.0f);
  circle.contentsGravity = kCAGravityCenter;
  
  UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:circle.position
                                                            radius:CGRectGetMidX(circle.bounds)
                                                        startAngle:0
                                                          endAngle:(360) / 180.0 * M_PI
                                                         clockwise:NO];
  circle.path = circlePath.CGPath;
  
  circle.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  circle.fillColor = [UIColor whiteColor].CGColor;
  circle.strokeColor = [UIColor colorWithRed:0.79 green:0.12 blue:0.15 alpha:1.0].CGColor;
  circle.lineWidth =2.0f;
  circle.strokeEnd = 0.0f;
  [[self layer] addSublayer:circle];
  self.circleLayer = circle;
  
  CALayer *layer = [CALayer layer];
  layer.frame = CGRectMake(0, 0, 24.0f, 24.0f);
  layer.contentsGravity = kCAGravityCenter;
  layer.contents = (id)[UIImage imageNamed:@"pinterest_pin"].CGImage;
  layer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  [[self layer] addSublayer:layer];
  self.iconLayer=layer;
  self.iconLayer.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
  
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
  if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
    layer.contentsScale = [[UIScreen mainScreen] scale];
  }
#endif
  
  UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  view.frame = CGRectMake(0, 0, 20.0f, 20.0f);
  view.hidesWhenStopped = YES;
  view.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  [self addSubview:view];
  self.activityView = view;
  
  self.backgroundColor = [UIColor colorWithWhite:0.88 alpha:1.0];
}

- (void)updateViewWithPercentage:(CGFloat)percentage state:(NSInteger)state {
  CGFloat deltaRotate = percentage * 180;
  CGFloat angelDegree = (180.0 - deltaRotate);
  
  [CATransaction begin];
  [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
  self.iconLayer.transform = CATransform3DMakeRotation((angelDegree) / 180.0 * M_PI, 0.0f, 0.0f, 1.0f);
  self.circleLayer.strokeEnd = percentage;
  if (state != RHRefreshStateLoading) {
    self.iconLayer.opacity = percentage;
    self.circleLayer.opacity = percentage;
  }
  [CATransaction commit];
}

- (void)updateViewOnNormalStatePreviousState:(NSInteger)state {
  if (state == RHRefreshStatePulling) {
    self.iconLayer.opacity = 0;
    self.circleLayer.opacity = 0;
  }
  
  [_activityView stopAnimating];
}

- (void)updateViewOnPullingStatePreviousState:(NSInteger)state {
  
}

- (void)updateViewOnLoadingStatePreviousState:(NSInteger)state {
  [self.activityView startAnimating];
  self.iconLayer.opacity = 0;
  self.circleLayer.opacity = 0;
  CATransform3D fromMatrix = CATransform3DMakeScale(0.0, 0.0, 0.0);
  CATransform3D toMatrix = CATransform3DMakeScale(1.0f, 1.0f, 1.0f);
  CAKeyframeAnimation *animation = [RHAnimator animationWithCATransform3DForKeyPath:@"transform"
                                                                     easingFunction:RHElasticEaseOut
                                                                         fromMatrix:fromMatrix
                                                                           toMatrix:toMatrix];
  animation.duration = 1.0f;
  animation.removedOnCompletion = NO;
  [self.activityView.layer addAnimation:animation forKey:@"transform"];
}

@end
