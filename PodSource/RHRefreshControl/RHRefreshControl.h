//
//  RHRefreshControl.h
//  Example
//
//  Created by Ratha Hin on 2/1/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHRefreshControlView.h"
#import "RHRefreshControlConfiguration.h"

typedef NS_ENUM(NSInteger, RHRefreshState) {
  RHRefreshStatePulling,
  RHRefreshStateNormal,
  RHRefreshStateLoading
};

@class RHRefreshControlConfiguration;
@protocol RHRefreshControlDelegate;

@interface RHRefreshControl : NSObject

@property (nonatomic, weak) id<RHRefreshControlDelegate> delegate;

- (id)initWithConfiguration:(RHRefreshControlConfiguration *)configuration;
- (void)attachToScrollView:(UIScrollView *)scrollView;

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end


@protocol RHRefreshControlDelegate <NSObject>

- (void)refreshDidTriggerRefresh:(RHRefreshControl *)refreshControl;
- (BOOL)refreshDataSourceIsLoading:(RHRefreshControl *)refreshControl;

@end
