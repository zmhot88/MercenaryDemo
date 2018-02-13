//
//  PushUpViewController.m
//  MercenaryDemo
//
//  Created by ross zhao on 2018/2/13.
//  Copyright © 2018年 mingzhao. All rights reserved.
//

#import "PushUpViewController.h"

@interface PushUpViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numLbl;
@property (weak, nonatomic) IBOutlet UIButton *controllBtn;

@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, assign) float  number;

@end

@implementation PushUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 打开距离传感器
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    // 通过通知监听有物品靠近还是离开
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)controllAction:(id)sender {
    if (_isRunning) {
        _isRunning = NO;
        [self.controllBtn setTitle:@"start" forState:UIControlStateNormal];
        
    }
    else {
        _isRunning = YES;
        [self.controllBtn setTitle:@"stop" forState:UIControlStateNormal];
        
        self.number = 0;
        self.numLbl.text = @"0";
    }
}


- (void)proximityStateDidChange:(NSNotification *)note
{
    if (!_isRunning) {
        return;
    }
    if ([UIDevice currentDevice].proximityState) {
        NSLog(@"有物品靠近");
        self.number += 0.5;
    } else {
        NSLog(@"有物品离开");
        self.number += 0.5;
        
        self.numLbl.text = [NSString stringWithFormat:@"%d", (int)self.number];
    }
}

@end
