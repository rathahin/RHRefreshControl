//
//  Animator.h
//  
//
//  Created by Ratha Hin on 1/31/14.
//  Copyright (c) 2014 Golden Gekko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef CGFloat (*ViewEasingFunctionPointerType)(CGFloat);

@interface RHAnimator : NSObject

+(CAKeyframeAnimation *) animationWithCATransform3DForKeyPath:(NSString *)keyPath
                                               easingFunction:(ViewEasingFunctionPointerType)function
                                                   fromMatrix:(CATransform3D)fromMatrix
                                                     toMatrix:(CATransform3D)toMatrix;

@end

CGFloat RHElasticEaseIn(CGFloat p);
CGFloat RHElasticEaseOut(CGFloat p);
CGFloat RHElasticEaseInOut(CGFloat p);
CGFloat RHBackEaseIn(CGFloat p);
CGFloat RHBackEaseOut(CGFloat p);

