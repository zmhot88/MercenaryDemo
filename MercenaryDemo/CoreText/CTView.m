//
//  CTView.m
//  MercenaryDemo
//
//  Created by mingzhao on 15/8/7.
//  Copyright (c) 2015年 mingzhao. All rights reserved.
//

#import "CTView.h"

#import <CoreText/CoreText.h>

@implementation CTView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, rect.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
//    NSDictionary *attrDict = @{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"Hello, Soft Mercenary!"];
    
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, attString.length)];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path, nil);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGMutablePathRef path = CGPathCreateMutable(); //1
//    CGPathAddRect(path, NULL, self.bounds );
//    
//    NSAttributedString* attString = [[[NSAttributedString alloc]
//                                      initWithString:@"Hello core text world!"] autorelease]; //2
//    
//    CTFramesetterRef framesetter =
//    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
//    CTFrameRef frame =
//    CTFramesetterCreateFrame(framesetter,
//                             CFRangeMake(0, [attString length]), path, NULL);
//    
//    CTFrameDraw(frame, context); //4
//    
//    CFRelease(frame); //5
//    CFRelease(path);
//    CFRelease(framesetter);
}


@end
