//
//  ExampleViewController6.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/14.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ExampleViewController6.h"

@interface ExampleViewController6 (){

    UIImageView *imageView;
    NSInteger imageIndex;
    NSArray *images;
    
}

@end

@implementation ExampleViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutUI];
}

- (void)layoutUI
{
    UIImage *image1 = [UIImage imageNamed:@"fafan.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"gua.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"shuiren.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"yangmi.jpg"];
    
    imageIndex = 0;
    images = @[image1,image2,image3,image4];
    imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image1;
    [self.view addSubview:imageView];
    
    UISwipeGestureRecognizer* leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    [self.view addGestureRecognizer:leftSwipe];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer* rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
}

- (void)leftSwipe:(UISwipeGestureRecognizer *)swipe
{
    [self transitionToNext:YES];
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)swipe
{
    [self transitionToNext:NO];
}
- (void)transitionToNext:(BOOL)next
{
    UIViewAnimationOptions options;
    if (next) {
        options = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromRight;
    }else
        options = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromLeft;
    
    [UIView transitionWithView:imageView duration:1.0 options:options animations:^{
        imageView.image = [self nextImage:next];
    } completion:nil];
}

- (UIImage *)nextImage:(BOOL)isNext
{
    UIImage *image = [[UIImage alloc] init];
    if (isNext) {
        imageIndex = (imageIndex+1)%4;
    }else
        imageIndex = (imageIndex-1+4)%4;
    
    image = images[imageIndex];
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
