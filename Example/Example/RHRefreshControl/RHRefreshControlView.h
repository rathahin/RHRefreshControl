//
//  RHRefreshControlView.h
//  Example
//
//  Created by Ratha Hin on 2/2/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHRefreshControl.h"

@protocol RHRefreshControlView <NSObject>

- (void)commonSetupOnInit;
- (void)updateViewWithPercentage:(CGFloat)percentage state:(NSInteger)state;
- (void)updateViewOnNormalStatePreviousState:(NSInteger)state;
- (void)updateViewOnLoadingStatePreviousState:(NSInteger)state;
- (void)updateViewOnPullingStatePreviousState:(NSInteger)state;

@optional
- (void)updateViewOnComplete;

@end
