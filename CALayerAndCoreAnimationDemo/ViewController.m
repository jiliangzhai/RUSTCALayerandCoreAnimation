//
//  ViewController.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/7.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ViewController.h"
#import "ExamplesTableViewController.h"


@interface ViewController ()
    
 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ExamplesTableViewController *tc = [[ExamplesTableViewController alloc] init];
    [self pushViewController:tc animated:YES];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end








