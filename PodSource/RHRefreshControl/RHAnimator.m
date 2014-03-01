//
//  Animator.m
//
//
//  Created by Ratha Hin on 1/31/14.
//  Copyright (c) 2014 Golden Gekko. All rights reserved.
//

#import "RHAnimator.h"

static const NSUInteger KeyframeCount = 60;

@implementation RHAnimator

//GGAnimationWithCATransform3D:NSString *keyPath, ViewEasingFunctionPointerType function, CATransform3D fromMatrix, CATransform3D toMatrix)

+(CAKeyframeAnimation *) animationWithCATransform3DForKeyPath:(NSString *)keyPath
                                                easingFunction:(ViewEasingFunctionPointerType)function
                                                    fromMatrix:(CATransform3D)fromMatrix
                                                      toMatrix:(CATransform3D)toMatrix {
  
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:KeyframeCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (KeyframeCount - 1);
  
	for(size_t frame = 0; frame < KeyframeCount; ++frame, t += dt) {
    
    CATransform3D value;
    
    value.m11 = fromMatrix.m11 + function(t) * (toMatrix.m11 - fromMatrix.m11);
    value.m12 = fromMatrix.m12 + function(t) * (toMatrix.m12 - fromMatrix.m12);
    value.m13 = fromMatrix.m13 + function(t) * (toMatrix.m13 - fromMatrix.m13);
    value.m14 = fromMatrix.m14 + function(t) * (toMatrix.m14 - fromMatrix.m14);
    
    value.m21 = fromMatrix.m21 + function(t) * (toMatrix.m21 - fromMatrix.m21);
    value.m22 = fromMatrix.m22 + function(t) * (toMatrix.m22 - fromMatrix.m22);
    value.m23 = fromMatrix.m23 + function(t) * (toMatrix.m23 - fromMatrix.m23);
    value.m24 = fromMatrix.m24 + function(t) * (toMatrix.m24 - fromMatrix.m24);
    
    value.m31 = fromMatrix.m31 + function(t) * (toMatrix.m31 - fromMatrix.m31);
    value.m32 = fromMatrix.m32 + function(t) * (toMatrix.m32 - fromMatrix.m32);
    value.m33 = fromMatrix.m33 + function(t) * (toMatrix.m33 - fromMatrix.m33);
    value.m34 = fromMatrix.m34 + function(t) * (toMatrix.m34 - fromMatrix.m34);
    
    value.m41 = fromMatrix.m41 + function(t) * (toMatrix.m41 - fromMatrix.m41);
    value.m42 = fromMatrix.m42 + function(t) * (toMatrix.m42 - fromMatrix.m42);
    value.m43 = fromMatrix.m43 + function(t) * (toMatrix.m43 - fromMatrix.m43);
    value.m44 = fromMatrix.m44 + function(t) * (toMatrix.m44 - fromMatrix.m44);
    
		[values addObject:[NSValue valueWithCATransform3D:value]];
    
	}
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
	[animation setValues:values];
  
	return animation;
  
}

// Modeled after the damped sine wave y = sin(13pi/2*x)*pow(2, 10 * (x - 1))
CGFloat RHElasticEaseIn(CGFloat p)
{
	return sin(13 * M_PI_2 * p) * pow(2, 10 * (p - 1));
}

// Modeled after the damped sine wave y = sin(-13pi/2*(x + 1))*pow(2, -10x) + 1
CGFloat RHElasticEaseOut(CGFloat p)
{
	return sin(-13 * M_PI_2 * (p + 1)) * pow(2, -10 * p) + 1;
}

// Modeled after the piecewise exponentially-damped sine wave:
// y = (1/2)*sin(13pi/2*(2*x))*pow(2, 10 * ((2*x) - 1))      ; [0,0.5)
// y = (1/2)*(sin(-13pi/2*((2x-1)+1))*pow(2,-10(2*x-1)) + 2) ; [0.5, 1]
CGFloat RHElasticEaseInOut(CGFloat p)
{
	if(p < 0.5)
	{
		return 0.5 * sin(13 * M_PI_2 * (2 * p)) * pow(2, 10 * ((2 * p) - 1));
	}
	else
	{
		return 0.5 * (sin(-13 * M_PI_2 * ((2 * p - 1) + 1)) * pow(2, -10 * (2 * p - 1)) + 2);
	}
}

// Modeled after the overshooting cubic y = x^3-x*sin(x*pi)
CGFloat RHBackEaseIn(CGFloat p)
{
	return p * p * p - p * sin(p * M_PI);
}

// Modeled after overshooting cubic y = 1-((1-x)^3-(1-x)*sin((1-x)*pi))
CGFloat RHBackEaseOut(CGFloat p)
{
	CGFloat f = (1 - p);
	return 1 - (f * f * f - f * sin(f * M_PI));
}


@end
