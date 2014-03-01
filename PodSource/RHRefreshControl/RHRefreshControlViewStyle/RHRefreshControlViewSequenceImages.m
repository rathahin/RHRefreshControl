//
//  RHRefreshControlViewSequenceImages.m
//  Example
//
//  Created by Ratha Hin on 2/11/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "RHRefreshControlViewSequenceImages.h"

@interface RHRefreshControlViewSequenceImages ()

@property (strong, nonatomic) UIImageView *animationView;
@property (strong, nonatomic) NSArray *imagesForDrag;
@property (strong, nonatomic) NSArray *imagesForLoading;

@end

@implementation RHRefreshControlViewSequenceImages

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      [self commonSetupOnInit];
    }
    return self;
}

- (void)didMoveToSuperview {
  [self addSubview:self.animationView];
}

- (void)commonSetupOnInit {

}

- (void)updateViewOnComplete {
  
}

- (void)updateViewOnLoadingStatePreviousState:(NSInteger)state {
  UIImageView *animationView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320, 460)];
  animationView.animationImages=self.imagesForLoading;
  animationView.animationDuration=1.5;
  animationView.animationRepeatCount=0;
  [animationView startAnimating];
  self.animationView = animationView;
}

- (void)updateViewOnNormalStatePreviousState:(NSInteger)state {
  
}

- (void)updateViewOnPullingStatePreviousState:(NSInteger)state {
  
}

- (void)updateViewWithPercentage:(CGFloat)percentage state:(NSInteger)state {
  NSUInteger absIndex = abs(([self.imagesForDrag count]-1)*percentage);
  self.animationView.image = self.imagesForDrag[absIndex];
}

- (void)sequenceImagesForDrag:(NSArray *)images {
  _imagesForDrag = images;
}

- (void)sequenceImagesForLoading:(NSArray *)images {
  _imagesForLoading = images;
}

- (UIImageView *)animationView {
  if (!_animationView) {
    _animationView = [[UIImageView alloc] initWithFrame:self.bounds];
    _animationView.contentMode = UIViewContentModeScaleAspectFit;
  }
  
  return _animationView;
}

@end
