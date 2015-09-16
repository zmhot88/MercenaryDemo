//
//  ZMLayer.m
//  MercenaryDemo
//
//  Created by mingzhao on 15/9/15.
//  Copyright (c) 2015年 mingzhao. All rights reserved.
//

#import "ZMLayer.h"

@implementation ZMLayer

-(void)drawInContext:(CGContextRef)ctx
{
    
    NSLog(@"3-drawInContext:");
    NSLog(@"CGContext:%@",ctx);
    NSLog(@"%@, %s", NSStringFromClass([self class]), __FUNCTION__);
    
    CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
//    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    
    CGContextMoveToPoint(ctx, 94.5, 33.5);
    
    CGContextAddLineToPoint(ctx, 104.02, 47.39);
    CGContextAddLineToPoint(ctx,120.18, 52.16);
    CGContextAddLineToPoint(ctx,109.91, 65.51);
    CGContextAddLineToPoint(ctx,110.37, 82.34);
    CGContextAddLineToPoint(ctx,94.5, 76.7);
    CGContextAddLineToPoint(ctx,78.63, 82.34);
    CGContextAddLineToPoint(ctx,79.09, 65.51);
    CGContextAddLineToPoint(ctx,68.82, 52.16);
    CGContextAddLineToPoint(ctx,84.98, 47.39);
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
