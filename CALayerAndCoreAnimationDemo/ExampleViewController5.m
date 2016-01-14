//
//  ExampleViewController5.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/13.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ExampleViewController5.h"

@interface ExampleViewController5 (){
    NSArray *images;
    UIImageView *imageView;
    NSInteger imageIndex;
}

@end

@implementation ExampleViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1/255.0 green:51/255.0 blue:124/255.0 alpha:1.0];
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
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.image = image1;
    [self.view addSubview:imageView];
    
    UISwipeGestureRecognizer* leftSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    [self.view addGestureRecognizer:leftSwipe];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer* rightSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
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
    //初始化转场动画
    CATransition *transition = [[CATransition alloc] init];
    //transition.type=@"cube";//立方体效果
    //transition.type=@"oglFlip";//翻转效果
    transition.type=@"suckEffect";//抽纸效果
    //效果类型
    //transition.type=@"rippleEffect";//波纹效果
    //transition.type=@"cameraIrisHollowOpen";//摄像头打开效果
    //以上是私有api，公开api有fade movein push reveal
    
    if (next) {
        //确定转场方向
        transition.subtype = kCATransitionFromRight;
    }else
        transition.subtype = kCATransitionFromLeft;
    //设置动画时间
    transition.duration = 1.0;
    //设定下一视图
    imageView.image = [self nextImage:next];
    //将动画加入图层
    [imageView.layer addAnimation:transition forKey:@"transition"];
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
