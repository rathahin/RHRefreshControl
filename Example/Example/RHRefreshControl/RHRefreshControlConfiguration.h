//
//  RHRefreshControlConfiguration.h
//  Example
//
//  Created by Ratha Hin on 2/2/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RHRefreshViewStyle) {
  RHRefreshViewStylePinterest
};

@interface RHRefreshControlConfiguration : NSObject

@property (nonatomic, strong) id refreshView;
@property (nonatomic, strong) NSNumber *minimumForStart;
@property (nonatomic, strong) NSNumber *maximumForPull;

@end
