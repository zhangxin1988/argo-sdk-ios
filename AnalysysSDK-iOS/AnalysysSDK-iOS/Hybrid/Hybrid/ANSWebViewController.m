//
//  ANSWebViewController.m
//  EGAnalyticsDemo
//
//  Created by SoDo on 2018/7/20.
//  Copyright © 2018年 analysys. All rights reserved.
//
//  https://blog.csdn.net/flg1554112450/article/details/78854056

#import "ANSWebViewController.h"
#import "AnalysysAgent.h"

@interface ANSWebViewController ()<UIWebViewDelegate> {
    UIActivityIndicatorView *_indicatorView;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ANSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationController.navigationBar.translucent = YES;
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    
    //  加载本地文件 带有css、js
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"app/index.html" withExtension:nil];
//    NSURL *filePath = [NSURL URLWithString:@"http://192.168.6.95/huaxiang/fangzhouBVisual/app/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
    [self.webView loadRequest:request];
    
    
    _indicatorView = [[UIActivityIndicatorView alloc] init];
    _indicatorView.center = self.view.center;
    _indicatorView.hidesWhenStopped = YES;
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    CGAffineTransform transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    _indicatorView.transform = transform;
    [_indicatorView startAnimating];
    [self.view addSubview:_indicatorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [AnalysysAgent resetHybridModel];
}

#pragma mark *** UIWebViewDelegate ***

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([AnalysysAgent setHybridModel:webView request:request]) {
        NSLog(@"AnalysysAgent 统计完成");
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%s",__FUNCTION__);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [_indicatorView stopAnimating];
    
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect absoluteRect = [self.webView convertRect:self.webView.bounds toView:window];
    NSLog(@"absoluteRect:%@",NSStringFromCGRect(absoluteRect));
    
//    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"a('')"];
//    NSLog(@"result:%@", result);
//
//    NSString *thisURL = @"document.URL";
//    NSString *urlStr = [webView stringByEvaluatingJavaScriptFromString:thisURL];
//    NSLog(@"url: %@", urlStr);
//
//    NSString *thisHREF = @"document.location.href";
//    NSString *href = [webView stringByEvaluatingJavaScriptFromString:thisHREF];
//    NSLog(@"href: %@", href);
//
//    //  https://www.jianshu.com/p/e82235ef2974
//    NSString *dom = @"document.documentElement.innerHTML";
//    NSString *html = [webView stringByEvaluatingJavaScriptFromString:dom];
//    NSLog(@"%@",html);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_indicatorView stopAnimating];
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
