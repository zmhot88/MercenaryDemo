//
//  ZM_ProgressiveRingView.m
//  MercenaryDemo
//
//  Created by ross zhao on 2018/4/11.
//  Copyright © 2018年 mingzhao. All rights reserved.
//

#import "ZM_ProgressiveRingView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 10 //弧线的宽度
#define PROCESS_COLOR
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ZM_ProgressiveRingView ()
{
    CAShapeLayer *_progressLayer;
    NSInteger _percent;
}
@end

@implementation ZM_ProgressiveRingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:(PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(-210) endAngle:degreesToRadians(30) clockwise:YES];
        
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        CGFloat radius = self.bounds.size.width/2-PROGRESS_LINE_WIDTH;
        CGFloat startA =  -M_PI_2 + 0.05;//+ M_PI/180;  //设置进度条起点位置
        CGFloat endA =  -M_PI_2 + M_PI*2;  //设置进度条终点位置
//        CGFloat startA =  0;  //设置进度条起点位置
//        CGFloat endA =  M_PI*2;  //设置进度条终点位置
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
        _progressLayer.path = [path CGPath];
        _progressLayer.strokeEnd = 0;
        
        
        CALayer *gradientLayer = [CALayer layer];
        CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
        gradientLayer1.frame = CGRectMake(0, 0, frame.size.width/2, frame.size.height);
        [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[UIColorFromRGB(0x00FF00) CGColor],(id)[UIColorFromRGB(0xFF0000)  CGColor], nil]];
        [gradientLayer1 setLocations:@[@0,@1.0]];
        [gradientLayer1 setStartPoint:CGPointMake(0.5,1)];
        [gradientLayer1 setEndPoint:CGPointMake(0.5,0)];
        [gradientLayer addSublayer:gradientLayer1];
        
        CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
        [gradientLayer2 setLocations:@[@0,@1.0]];
        gradientLayer2.frame = CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height);
        [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[UIColorFromRGB(0x0000FF) CGColor],(id)[ UIColorFromRGB(0x00FF00) CGColor], nil]];
        [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
        [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
        [gradientLayer addSublayer:gradientLayer2];
        
        
        
        [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
        [self.layer addSublayer:gradientLayer];
    }
    return self;
}

-(void)setPercent:(NSInteger)percent animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:3.0];
    [CATransaction setCompletionBlock:^{
        if (percent >=100) {
            CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
            CGFloat radius = self.bounds.size.width/2-PROGRESS_LINE_WIDTH;
            CGFloat startA =  -M_PI_2;//+ M_PI/180;  //设置进度条起点位置
            CGFloat endA =  -M_PI_2 + M_PI*2;  //设置进度条终点位置
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
            _progressLayer.path = [path CGPath];
        }
    }];
    _progressLayer.strokeEnd = percent/100.0;
    [CATransaction commit];
    
    _percent = percent;
}

@end
