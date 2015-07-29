//
//  DetailViewController.h
//  MercenaryDemo
//
//  Created by mingzhao on 15/7/29.
//  Copyright (c) 2015年 mingzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

