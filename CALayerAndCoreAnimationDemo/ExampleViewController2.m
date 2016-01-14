//
//  ExampleViewController2.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/8.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ExampleViewController2.h"
#import "Layer1.h"

@interface ExampleViewController2 ()

@end

@implementation ExampleViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    Layer1 *layer = [[Layer1 alloc] init];
    layer.bounds = CGRectMake(0, 0, 300, 300);
    layer.position = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.delegate = self;
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
