//
//  CutomRefreshView.m
//  Example
//
//  Created by Ratha Hin on 2/3/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "CutomRefreshView.h"
#import "RHAnimator.h"

const CGFloat deRedius = 12;
NSString * const kRotationAnimation = @"keyRotationAnimation";

@interface CutomRefreshView ()

@property (nonatomic, assign) CGPoint pointTop;
@property (nonatomic, assign) CGPoint pointLeft;
@property (nonatomic, assign) CGPoint pointRight;
@property (nonatomic, assign) CGPoint pointBottom;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayerLoading;
@property (nonatomic, strong) CAShapeLayer *animateLoading;
@property (nonatomic, assign, getter = isPulling) BOOL pulling;
@property (nonatomic, strong) CABasicAnimation* rotationAnimation;

@end

@implementation CutomRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self commonSetupOnInit];
    }
    return self;
}

- (void)commonSetupOnInit {
  CGPoint middlePoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  
  self.circleLayer = [CAShapeLayer layer];
  self.circleLayer.fillColor = [UIColor cyanColor].CGColor;
  self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;
  self.circleLayer.lineWidth = 2.0f;
  
  [self.layer addSublayer:self.circleLayer];
  
  self.circleLayerLoading = [CAShapeLayer layer];
  self.circleLayerLoading.frame = CGRectMake(0, 0, deRedius*2, deRedius*2);
  self.circleLayerLoading.position = middlePoint;
  self.circleLayerLoading.fillColor = [UIColor cyanColor].CGColor;
  self.circleLayerLoading.strokeColor = [UIColor whiteColor].CGColor;
  self.circleLayerLoading.lineWidth = 2.0f;
  self.circleLayerLoading.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(deRedius, deRedius)
                                                                radius:deRedius - 2
                                                            startAngle:0
                                                              endAngle:360 / 180 * M_PI
                                                             clockwise:YES].CGPath;
  [self.layer addSublayer:self.circleLayerLoading];
  self.circleLayerLoading.opacity = 0;
  
  self.animateLoading = [CAShapeLayer layer];
  self.animateLoading.frame = CGRectMake(0, 0, deRedius*2, deRedius*2);
  self.animateLoading.position = middlePoint;
  self.animateLoading.contentsGravity = kCAGravityCenter;
  self.animateLoading.contents = (id)[UIImage imageNamed:@"loading"].CGImage;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
  if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
    self.animateLoading.contentsScale = [[UIScreen mainScreen] scale];
  }
#endif
  
  [self.layer addSublayer:self.animateLoading];
  self.animateLoading.opacity = 0;
  
  CABasicAnimation* rotationAnimation;
  rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1.0 * 3.0 ];
  rotationAnimation.duration = 3.0;
  rotationAnimation.cumulative = YES;
  rotationAnimation.repeatCount = HUGE_VAL;
  
  self.rotationAnimation = rotationAnimation;
}

- (void)updateViewOnNormalStatePreviousState:(NSInteger)state {
  
}

- (void)updateViewOnPullingStatePreviousState:(NSInteger)state {
  self.pulling = YES;
  self.circleLayerLoading.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  CATransform3D fromMatrix = CATransform3DMakeScale(0.75, 2.5, 1.0);
  CATransform3D toMatrix = CATransform3DMakeScale(1.0f, 1.0f, 1.0f);
  CAKeyframeAnimation *animation = [RHAnimator animationWithCATransform3DForKeyPath:@"transform"
                                                                     easingFunction:RHElasticEaseOut
                                                                         fromMatrix:fromMatrix
                                                                           toMatrix:toMatrix];
  animation.duration = 1.0f;
  animation.removedOnCompletion = NO;
  [self.circleLayerLoading addAnimation:animation forKey:@"transform"];
}

- (void)updateViewOnLoadingStatePreviousState:(NSInteger)state {
  [self.animateLoading addAnimation:self.rotationAnimation forKey:kRotationAnimation];
  
  self.animateLoading.opacity = 1.0;
}

- (void)updateViewOnComplete {
  self.pulling = NO;
  [self.animateLoading removeAnimationForKey:kRotationAnimation];
  self.animateLoading.opacity = 0;
}

- (void)updateViewWithPercentage:(CGFloat)percentage state:(NSInteger)state {
  CGFloat f = (1 - percentage);
  CGFloat backOutP = 1 - (f * f * f * f);
  if (backOutP >= 1) backOutP = 1;
  
  CGPoint middlePoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  CGFloat radius = deRedius * backOutP;
  
  self.pointTop = [self pointFromCenter:middlePoint radius:radius degree:-90];
  
  if (!self.isPulling) {
    CGPoint modifyPoint = self.pointTop;
    modifyPoint.y = 0;
    self.pointTop = modifyPoint;
    
    self.pointRight = [self pointFromCenter:middlePoint radius:radius degree:0];
    self.pointBottom = [self pointFromCenter:middlePoint radius:radius degree:90];
    self.pointLeft = [self pointFromCenter:middlePoint radius:radius degree:180];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:self.pointTop];
    //  [bezierPath addLineToPoint:self.pointRight];
    //  [bezierPath addLineToPoint:self.pointBottom];
    //  [bezierPath addLineToPoint:self.pointLeft];
    
    // add midpoint
    CGPoint midTopRight = [self midPoint:self.pointTop pointB:self.pointRight];
    CGPoint midRightBottom = [self midPoint:self.pointRight pointB:self.pointBottom];
    CGPoint midBottomLeft = [self midPoint:self.pointBottom pointB:self.pointLeft];
    CGPoint midLeftTop = [self midPoint:self.pointLeft pointB:self.pointTop];
    
    [bezierPath addQuadCurveToPoint:midTopRight controlPoint:self.pointTop];
    [bezierPath addQuadCurveToPoint:midRightBottom controlPoint:self.pointRight];
    [bezierPath addQuadCurveToPoint:midBottomLeft controlPoint:self.pointBottom];
    [bezierPath addQuadCurveToPoint:midLeftTop controlPoint:self.pointLeft];
    [bezierPath addLineToPoint:self.pointTop];
    
    self.circleLayer.path = bezierPath.CGPath;
    self.circleLayer.opacity = 1;
    self.circleLayerLoading.opacity = 0;
  } else {
    self.circleLayer.opacity = 0;
    self.circleLayerLoading.opacity = 1;
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.circleLayerLoading.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [CATransaction commit];
  }
  
}

- (CGPoint)pointFromCenter:(CGPoint)center
                    radius:(CGFloat)radius
                    degree:(CGFloat)degree {
  CGFloat rads = degree * (M_PI / 180.0);
  CGFloat x = center.x + radius * cos(rads);
  CGFloat y = center.y + radius * sin(rads);
  return CGPointMake(x, y);
}

- (CGPoint)midPoint:(CGPoint)p0 pointB:(CGPoint)p1 {
  return CGPointMake((p0.x + p1.x) / 2.0, (p0.y + p1.y) / 2.0);
}

@end
