//
//  ExampleViewController1.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/8.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ExampleViewController1.h"

@interface ExampleViewController1 (){
    CGRect targetRect;
    CALayer *shadowLayer;
    CALayer *layer;
}

@end

@implementation ExampleViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    shadowLayer= [[CALayer alloc]init];
    shadowLayer.bounds = CGRectMake(0, 0, 200, 200);;
    shadowLayer.position = CGPointMake(self.view.frame.size.width/2, 200);
    shadowLayer.cornerRadius = 100;
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(2, 1);
    shadowLayer.shadowOpacity=1;
    shadowLayer.borderColor = [UIColor whiteColor].CGColor;
    shadowLayer.borderWidth = 2.0;//没有边框就看不见阴影
    [self.view.layer addSublayer:shadowLayer];
    
    layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 200, 200);
    layer.position = CGPointMake(self.view.frame.size.width/2, 200);
    layer.backgroundColor = [UIColor purpleColor].CGColor;
    layer.cornerRadius = 100;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2.0;
    layer.delegate = self;
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
    targetRect = layer.frame;//calayer有一个name属性可以用以区分layer
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(targetRect, location)) {
        [layer setValue:@0.6 forKeyPath:@"transform.scale"];
        [shadowLayer setValue:@0.6 forKeyPath:@"transform.scale"];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(targetRect, location)) {
        
        [layer setValue:@1.0 forKeyPath:@"transform.scale"];
        [shadowLayer setValue:@1.0 forKeyPath:@"transform.scale"];
    }
    
}

- (void)drawLayer:(CALayer *)myLayer inContext:(CGContextRef)ctx
{
    UIImage *image = [self thumbnailMakerWithImage:[UIImage imageNamed:@"panda.jpg"]];
    CGContextSaveGState(ctx);
    
    myLayer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    CGContextDrawImage(ctx, CGRectMake(CGRectGetWidth(myLayer.bounds)/2-image.size.width/2, CGRectGetHeight(myLayer.bounds)/2-image.size.height/2, image.size.width, image.size.height), image.CGImage);
    
    CGContextRestoreGState(ctx);
}

- (UIImage *)thumbnailMakerWithImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    
    CGSize imageSize = image.size;
    float ratioX = 200/imageSize.width;
    float ratioY = 200/imageSize.height;
    float ratio = MAX(ratioX, ratioY);
    
    float targetWidth = ratio*imageSize.width;
    float targetHeight = ratio*imageSize.height;
    
    float originX = (200-targetWidth)/2.0;
    float originY = (200-targetHeight)/2.0;
    
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    [image drawInRect:CGRectMake(originX, originY, targetWidth, targetHeight)];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return thumbnail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
