//
//  ZMTableViewController.m
//  MercenaryDemo
//
//  Created by ross zhao on 2017/12/26.
//  Copyright © 2017年 mingzhao. All rights reserved.
//

#import "ZMTableViewController.h"
#import "UITableView+Placeholder.h"
#import "MJRefresh.h"

@interface ZMTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
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

- (void)loadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

#pragma mark - TableView 占位图

- (NSString *)xy_noDataViewMessage {
    return @"刷新空图";
}

- (UIColor *)xy_noDataViewMessageColor {
    return [UIColor blackColor];
}

@end
