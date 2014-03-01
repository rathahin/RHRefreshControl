//
//  RHRefreshControlConfiguration.m
//  Example
//
//  Created by Ratha Hin on 2/2/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "RHRefreshControlConfiguration.h"
#import "RHRefreshControlViewPinterest.h"

static const CGFloat MIN_PULL = 24;
static const CGFloat MAX_PULL = 60;

@implementation RHRefreshControlConfiguration

- (void)setRefreshView:(id)refreshView {
  if ([refreshView isKindOfClass:[UIView class]]) {
    _refreshView = refreshView;
  } else {
    NSInteger refreshViewStyle = [refreshView intValue];
    switch (refreshViewStyle) {
      case RHRefreshViewStylePinterest:
      {
        _refreshView = [[RHRefreshControlViewPinterest alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
      }
        break;
        
      default:
        break;
    }
  }
}

- (NSNumber *)maximumForPull {
  if (!_maximumForPull) {
    return [NSNumber numberWithFloat:MAX_PULL];
  }
  
  return _maximumForPull;
}

- (NSNumber *)minimumForStart {
  if (!_minimumForStart) {
    return [NSNumber numberWithFloat:MIN_PULL];
  }
  
  return _minimumForStart;
}

@end
