//
//  CacheWebViewViewController.m
//  MercenaryDemo
//
//  Created by ross zhao on 2018/2/27.
//  Copyright © 2018年 mingzhao. All rights reserved.
//

#import "CacheWebViewViewController.h"

@interface CacheWebViewViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mWebView;

@property (nonatomic,retain) NSURLRequest *request;
@property (nonatomic,retain) NSString *faxianUrl;

@end

@implementation CacheWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mWebView.delegate = self;
    
    self.faxianUrl =  @"https://h5.myrunners.com/h5page/index.php";
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:_faxianUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.f];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[[NSURLSession sharedSession] dataTaskWithRequest:_request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            if (!error) {
//                NSCachedURLResponse *cacheResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
//                [[NSURLCache sharedURLCache] storeCachedResponse:cacheResponse forRequest:_request];
//            }
//        }] resume];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)reload:(id)sender {
    NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:self.request];
    if (response) {
//        [self.mWebView loadRequest:self.request];
        [self.mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_faxianUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.f]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%@ time: %f", NSStringFromSelector(_cmd), [[NSDate date] timeIntervalSince1970]);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@ time: %f", NSStringFromSelector(_cmd), [[NSDate date] timeIntervalSince1970]);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@ time: %f", NSStringFromSelector(_cmd), [[NSDate date] timeIntervalSince1970]);
}

@end
