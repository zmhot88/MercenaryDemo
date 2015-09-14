//
//  ZMCALayerTestViewController.m
//  MercenaryDemo
//
//  Created by mingzhao on 15/9/14.
//  Copyright (c) 2015年 mingzhao. All rights reserved.
//

#import "ZMCALayerTestViewController.h"

#define WIDTH 50

@interface ZMCALayerTestViewController ()

@property (nonatomic, retain) CALayer *mLayer;

@end

@implementation ZMCALayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawMyLayer];
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
    self.mLayer.backgroundColor = [UIColor redColor].CGColor;
    self.mLayer.cornerRadius = width/2;
}

@end
