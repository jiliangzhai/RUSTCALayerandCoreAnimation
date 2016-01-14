//
//  Layer1.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/7.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "Layer1.h"
#import <UIKit/UIKit.h>

@implementation Layer1

- (void)drawInContext:(CGContextRef)ctx
{
    UIImage *image = [UIImage imageNamed:@"panda.jpg"];
    CGContextSaveGState(ctx);
    
    self.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    CGContextDrawImage(ctx, CGRectMake(CGRectGetWidth(self.bounds)/2-image.size.width/2, CGRectGetHeight(self.bounds)/2-image.size.height/2, image.size.width, image.size.height), image.CGImage);
    
    CGContextRestoreGState(ctx);
}

@end
