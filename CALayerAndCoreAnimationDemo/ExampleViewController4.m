//
//  ExampleViewController4.m
//  CALayerAndCoreAnimationDemo
//
//  Created by rust_33 on 16/1/13.
//  Copyright © 2016年 rust_33. All rights reserved.
//

#import "ExampleViewController4.h"

@interface ExampleViewController4 (){
    CALayer *bubbleLayer;
}

@end

@implementation ExampleViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor colorWithRed:1/255.0 green:51/255.0 blue:124/255.0 alpha:1.0];
    
    [self layoutUI];
}

- (void)layoutUI
{
    bubbleLayer = [[CALayer alloc] init];
    UIImage *image = [self thumbnailMakerWithImage:[UIImage imageNamed:@"bubble.png"] size:CGSizeMake(100, 100)];
    bubbleLayer.bounds = CGRectMake(0, 0, 100, 100);
    bubbleLayer.anchorPoint = CGPointMake(0.4, 0.4);
    bubbleLayer.position = CGPointMake(200, 200);
    [bubbleLayer setContents:(id)image.CGImage];
    
    [self.view.layer addSublayer:bubbleLayer];
}

- (UIImage *)thumbnailMakerWithImage:(UIImage *)image size:(CGSize)size
{
    if (!image) {
        return nil;
    }
    
    CGSize imageSize = image.size;
    float ratioX = size.width/imageSize.width;
    float ratioY = size.height/imageSize.height;
    float ratio = MAX(ratioX, ratioY);
    
    float targetWidth = ratio*imageSize.width;
    float targetHeight = ratio*imageSize.height;
    
    float originX = (size.width-targetWidth)/2.0;
    float originY = (size.height-targetHeight)/2.0;
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(originX, originY, targetWidth, targetHeight)];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return thumbnail;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    CABasicAnimation *rotation = [self rotation];
    CABasicAnimation *translation = [self translationToLocation:location];
    CAKeyframeAnimation *translation2 = [self keyFrameTranslationWithPosition:bubbleLayer.position ToLocation:location];
    CAKeyframeAnimation *translation3 = [self keyFramePathTranslationWithPosition:bubbleLayer.position Location:location];
    CAAnimationGroup *group = [self animationGroupWithAnimations:@[translation,rotation]];
    [group setValue:[NSValue valueWithCGPoint:location] forKey:@"location"];
    //添加动画至图层，根据key值可以对动画进行区分。
    //[bubbleLayer addAnimation:rotation forKey:@"rotation"];
    //[bubbleLayer addAnimation:translation forKey:@"translation"];
    //[bubbleLayer addAnimation:translation2 forKey:@"keyFrameTranslation"];
    //[bubbleLayer addAnimation:translation3 forKey:@"keyFramePathTranslation"];
    
    CAAnimation *animation = [bubbleLayer animationForKey:@"animationGroup"];
    if (animation) {
        if (bubbleLayer.speed==0) {
            
            [self animationResume];
        }else
            [self animationPause];
    }else
    [bubbleLayer addAnimation:group forKey:@"animationGroup"];
}

- (CABasicAnimation *)rotation
{
    //创建基本动画
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //动画时间
    rotate.duration = 3.0;
    //初始值，也可以不设置，那么默认为该属性的当前值为初始值
    rotate.fromValue = @0;
    //终值
    rotate.toValue = @(2*M_PI);
    //重复次数
    rotate.repeatCount = 0;
    //是否在动画完成后移除动画
    rotate.removedOnCompletion = NO;

    return rotate;
}

- (CABasicAnimation *)translationToLocation:(CGPoint)location
{
    CABasicAnimation *translate = [CABasicAnimation animationWithKeyPath:@"position"];
    translate.duration = 3.0;
    translate.toValue = [NSValue valueWithCGPoint:location];
    //translate.delegate = self;
    [translate setValue:[NSValue valueWithCGPoint:location] forKey:@"location"];
    
    return translate;
}

- (CAKeyframeAnimation *)keyFrameTranslationWithPosition:(CGPoint)position ToLocation:(CGPoint)loation
{
    //创建关键帧动画
    CAKeyframeAnimation* keyframeTranslation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue* value1 = [NSValue valueWithCGPoint:position];
    NSValue* value2 = [NSValue valueWithCGPoint:CGPointMake(150, 260)];
    NSValue* value3 = [NSValue valueWithCGPoint:CGPointMake(250, 340)];
    NSValue* value4 = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    NSArray* values = @[value1,value2,value3,value4];
    //设置每帧的初始值也就是前一帧的终值
    keyframeTranslation.values = values;
    keyframeTranslation.duration = 8.0;
    //设置开始时间，cacurrentmediatime()是现在的时间，可以实现延时效果
    //keyframeTranslation.beginTime = CACurrentMediaTime()+2;
    //keyTimes可以控制每一帧的时间，用0-1的值进行表示。
    keyframeTranslation.keyTimes = @[@0.0,@0.25,@0.75,@1.0];
    //动画计算模式
    keyframeTranslation.calculationMode = kCAAnimationCubic;
    [keyframeTranslation setValue:[NSValue valueWithCGPoint:loation] forKey:@"location"];
    
    return keyframeTranslation;
}

- (CAKeyframeAnimation *)keyFramePathTranslationWithPosition:(CGPoint)position Location:(CGPoint)location
{
    CAKeyframeAnimation* keyframePathTranslation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil,position.x,position.y);
    CGPathAddCurveToPoint(path, nil, 100, 250, 300, 350, 200, 400);
    
    keyframePathTranslation.path = path;
    keyframePathTranslation.duration = 5.0;
    [keyframePathTranslation setValue:[NSValue valueWithCGPoint:location] forKey:@"location"];
    
    return keyframePathTranslation;
}

- (CAAnimationGroup *)animationGroupWithAnimations:(NSArray *)animations
{
    CAAnimationGroup* group = [CAAnimationGroup animation];
    
    group.animations = animations;
    group.duration = 3.0;
    group.delegate = self;
    //group.beginTime = CACurrentMediaTime()+3;
    
    return group;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CGPoint location = [[anim valueForKey:@"location"] CGPointValue];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    bubbleLayer.position = location;
    [CATransaction commit];
}

-(void) animationResume
{
    CFTimeInterval begintime= CACurrentMediaTime()-bubbleLayer.timeOffset;
    
    bubbleLayer.timeOffset=0;
    bubbleLayer.beginTime=begintime;
    bubbleLayer.speed=1;
    
}

-(void) animationPause
{
    CFTimeInterval interval=[bubbleLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    [bubbleLayer setTimeOffset:interval];
    bubbleLayer.speed=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
