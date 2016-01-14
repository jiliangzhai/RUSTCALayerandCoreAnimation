//
//  View1.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/7.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "View1.h"
#import "Layer1.h"

@implementation View1

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"this is drawRect");
    
    [super drawRect:rect];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"this is drawLayerInContext");
    
    [super drawLayer:layer inContext:ctx];
    
}
@end
