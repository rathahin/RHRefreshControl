//
//  RHRefreshControl.m
//  Example
//
//  Created by Ratha Hin on 2/1/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import "RHRefreshControl.h"
#import "RHRefreshControlConfiguration.h"


@interface RHRefreshControl ()

@property (nonatomic, strong) UIView<RHRefreshControlView> *refreshView;
@property (nonatomic, assign) CGFloat minimumForStart;
@property (nonatomic, assign) CGFloat maximumForPull;

@property (nonatomic, assign) RHRefreshState state;

@end

@implementation RHRefreshControl

- (id)initWithConfiguration:(RHRefreshControlConfiguration *)configuration {
  self = [super init];
  if (self) {
    self.minimumForStart = [configuration.minimumForStart floatValue];
    self.maximumForPull = [configuration.maximumForPull floatValue];
    self.refreshView = configuration.refreshView;
  }
  
  return self;
}

- (void)attachToScrollView:(UIScrollView *)scrollView {
  
  self.refreshView.center = CGPointMake(CGRectGetMidX(scrollView.bounds), -1*(self.maximumForPull - self.minimumForStart) / 2);
  [scrollView insertSubview:self.refreshView atIndex:0];
}

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView {
  [self updateRefreshViewWithScrollView:scrollView];
  if (self.state == RHRefreshStateLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(refreshDataSourceIsLoading:)]) {
			_loading = [_delegate refreshDataSourceIsLoading:self];
		}
		
		if (self.state == RHRefreshStatePulling && scrollView.contentOffset.y > -(self.maximumForPull + self.minimumForStart) && scrollView.contentOffset.y < 0.0f && !_loading) {
			[self setState:RHRefreshStateNormal];
		} else if (self.state == RHRefreshStateNormal && scrollView.contentOffset.y < -(self.maximumForPull + self.minimumForStart) && !_loading) {
			[self setState:RHRefreshStatePulling];
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}
}

- (void)updateRefreshViewWithScrollView:(UIScrollView *)scrollView {
  if (scrollView.contentOffset.y + self.minimumForStart > 0) return;
  
  // float refreshView on middle of pull disctance...
  
  CGFloat deltaOffsetY = MIN(fabsf(scrollView.contentOffset.y + self.minimumForStart ), self.maximumForPull);
  CGFloat percentage = deltaOffsetY/ self.maximumForPull;
  
  CGRect refreshViewFrame = self.refreshView.frame;
  refreshViewFrame.size.height = deltaOffsetY;
  self.refreshView.frame = refreshViewFrame;
  self.refreshView.center = CGPointMake(CGRectGetMidX(scrollView.bounds), scrollView.contentOffset.y / 2);
  
  [self.refreshView updateViewWithPercentage:percentage state:self.state];
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
  BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(refreshDataSourceIsLoading:)]) {
		_loading = [_delegate refreshDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= -(self.maximumForPull + self.minimumForStart) && !_loading) {
		
		if ([_delegate respondsToSelector:@selector(refreshDidTriggerRefresh:)]) {
			[_delegate refreshDidTriggerRefresh:self];
		}
    
		
		[self setState:RHRefreshStateLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.2];
		scrollView.contentInset = UIEdgeInsetsMake((self.maximumForPull + self.minimumForStart), 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
		
	}
}

- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
  [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:RHRefreshStateNormal];
  if ([self.refreshView respondsToSelector:@selector(updateViewOnComplete)]) {
    [self.refreshView updateViewOnComplete];
  }
}

- (void)setState:(RHRefreshState)newState {
  
  
  switch (newState) {
    case RHRefreshStateNormal: {
      [self.refreshView updateViewOnNormalStatePreviousState:_state];
    }
      break;
      
    case RHRefreshStateLoading: {
      [self.refreshView updateViewOnLoadingStatePreviousState:_state];
    }
      break;
      
    case RHRefreshStatePulling: {
      [self.refreshView updateViewOnPullingStatePreviousState:_state];
    }
      break;
      
    default:
      break;
  }
  
  _state = newState;
  
}

@end
