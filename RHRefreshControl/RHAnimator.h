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

CGFloat ElasticEaseIn(CGFloat p);
CGFloat ElasticEaseOut(CGFloat p);
CGFloat ElasticEaseInOut(CGFloat p);
CGFloat BackEaseIn(CGFloat p);
CGFloat BackEaseOut(CGFloat p);

