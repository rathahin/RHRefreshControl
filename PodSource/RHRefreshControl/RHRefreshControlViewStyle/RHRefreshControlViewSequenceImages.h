//
//  RHRefreshControlViewSequenceImages.h
//  Example
//
//  Created by Ratha Hin on 2/11/14.
//  Copyright (c) 2014 Ratha Hin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHRefreshControlView.h"

@interface RHRefreshControlViewSequenceImages : UIView <RHRefreshControlView>

- (void)sequenceImagesForDrag:(NSArray *)images;
- (void)sequenceImagesForLoading:(NSArray *)images;

@end
