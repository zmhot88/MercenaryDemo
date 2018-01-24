//
//  ZMCALayerTestViewController.m
//  MercenaryDemo
//
//  Created by mingzhao on 15/9/14.
//  Copyright (c) 2015年 mingzhao. All rights reserved.
//

#import "ZMCALayerTestViewController.h"
#import "ZMView.h"

#define WIDTH 50
#define PHOTO_HEIGHT 150

@interface ZMCALayerTestViewController ()

@property (nonatomic, retain) CALayer *mLayer;

@end

@implementation ZMCALayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.
//    [self drawMyLayer];
    
    //2.
//    //自定义图层
//    CALayer *layer = [[CALayer alloc] init];
//    layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
//    layer.position = CGPointMake(160, 200);
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    layer.cornerRadius = PHOTO_HEIGHT/2;
//    layer.masksToBounds = YES;
//    layer.borderColor = [UIColor greenColor].CGColor;
//    layer.borderWidth = 2;
//    
//    layer.delegate = self;
//    [self.view.layer addSublayer:layer];
//    [layer setNeedsDisplay];
    
//    //3,双图层
//    CGPoint position= CGPointMake(160, 200);
//    CGRect bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
//    CGFloat cornerRadius = PHOTO_HEIGHT/2;
//    CGFloat borderWidth = 2;
//    
//    //阴影图层
//    CALayer *layerShadow = [[CALayer alloc] init];
//    layerShadow.bounds = bounds;
//    layerShadow.position = position;
//    layerShadow.cornerRadius = cornerRadius;
//    layerShadow.shadowColor = [UIColor grayColor].CGColor;
//    layerShadow.shadowOffset = CGSizeMake(2, 1);
//    layerShadow.shadowOpacity = 1;
//    layerShadow.borderColor = [UIColor greenColor].CGColor;
//    layerShadow.borderWidth = borderWidth;
//    [self.view.layer addSublayer:layerShadow];
//    
//    //容器图层
//    CALayer *layer = [[CALayer alloc] init];
//    layer.bounds = bounds;
//    layer.position = position;
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    layer.cornerRadius = cornerRadius;
//    layer.masksToBounds = YES;
//    layer.borderColor = [UIColor whiteColor].CGColor;
//    layer.borderWidth = borderWidth;
//    
//    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    
//    layer.delegate = self;
//    [self.view.layer addSublayer:layer];
//    [layer setNeedsDisplay];
    
    //4 自定义图层
    ZMView *view=[[ZMView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
    
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 绘制图层
-(void)drawMyLayer
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //获取根图层
    CALayer *layer = [[CALayer alloc] init];
    //设置背景颜色
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0f blue:1.0 alpha:1.0].CGColor;
    
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    
    layer.cornerRadius = WIDTH/2;
    
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
    
    
    self.mLayer = layer;
    [self.view.layer addSublayer:layer];
}

#pragma mark 点击放大
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CALayer *layer = self.view.layer.sublayers[0];
    
    NSLog(@"sublayer count: %d", self.view.layer.sublayers.count);
    CGFloat width = self.mLayer.bounds.size.width;
    
    if (width == WIDTH) {
        width = WIDTH*4;
    }
    else{
        width = WIDTH;
    }
    
    NSLog(@"sublayer count: %d", self.view.layer.sublayers.count);
    self.mLayer.bounds = CGRectMake(0, 0, width, width);
    self.mLayer.position = [touch locationInView:self.view];
//    self.mLayer.backgroundColor = [UIColor redColor].CGColor;
    self.mLayer.cornerRadius = width/2;
}


#pragma mark 绘制图行，图像到图层
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
//    CGContextSaveGState(ctx);
//    
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"photo"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
//    CGContextRestoreGState(ctx);
}

@end
