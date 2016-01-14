//
//  ExampleViewController3.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/12.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ExampleViewController3.h"

@interface ExampleViewController3 (){
    UIImage *heartImage;
    UIImage *bubbleImage;
    UIImageView *bubbleImageView;
    UIImageView *heartImageView;
    CATextLayer *textLayer;
    NSInteger count;
}

@end

@implementation ExampleViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1/255.0 green:51/255.0 blue:124/255.0 alpha:1.0];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}

- (void)layoutUI
{
    bubbleImage = [UIImage imageNamed:@"bubble.png"];
    
    bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    bubbleImageView.contentMode = UIViewContentModeScaleAspectFit;
    bubbleImageView.image = bubbleImage;;
    bubbleImageView.layer.anchorPoint = CGPointMake(0.2, 0.2);
    
    [self.view addSubview:bubbleImageView];
    [self.view.layer addSublayer:textLayer];
    [self scaleAnimationWithLayer:bubbleImageView];
    count = 1;
 
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    [UIView beginAnimations:@"bubble" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.0];
    bubbleImageView.center = location;
    [UIView commitAnimations];
    
    /*[UIView animateWithDuration:3.0 delay:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bubbleImageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    } completion:^(BOOL finished) {
        if (finished) {
            NSLog(@"finished");
        }
    }];*/
    
}

- (void)scaleAnimationWithLayer:(UIImageView *)imageView
{
    [UIView animateKeyframesWithDuration:10.0 delay:0 options:UIViewAnimationOptionRepeat|UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1/300;
            CATransform3D rotation = CATransform3DRotate(transform, M_PI, 0, 0, 1);
            CATransform3D scale = CATransform3DScale(rotation, 0.5, 0.5, 0.5);
            imageView.layer.transform = scale;
            
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            CATransform3D rotation = CATransform3DRotate(transform, 2*M_PI, 0, 0, 1);
            CATransform3D scale = CATransform3DScale(rotation, 1.0,1.0,1.0);
            imageView.layer.transform = scale;
        }];
    } completion:^(BOOL finished) {
        NSLog(@"finished");
    }];
}

@end










