//
//  ZM_ProgressiveRingViewController.m
//  MercenaryDemo
//
//  Created by ross zhao on 2018/4/11.
//  Copyright © 2018年 mingzhao. All rights reserved.
//

#import "ZM_ProgressiveRingViewController.h"
#import "ZM_ProgressiveRingView.h"

@interface ZM_ProgressiveRingViewController ()
{
    ZM_ProgressiveRingView *ring;
}
@end

@implementation ZM_ProgressiveRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ring = [[ZM_ProgressiveRingView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];
    [self.view addSubview:ring];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [ring setPercent:100 animated:YES];
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

@end
