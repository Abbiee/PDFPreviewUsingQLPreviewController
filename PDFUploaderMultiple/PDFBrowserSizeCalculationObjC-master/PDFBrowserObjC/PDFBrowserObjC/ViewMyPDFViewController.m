//
//  ViewMyPDFViewController.m
//  PDFBrowserObjC
//
//  Created by Abbie on 01/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "ViewMyPDFViewController.h"
#import <WebKit/WebKit.h>

@interface ViewMyPDFViewController ()
@property (strong, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation ViewMyPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        _webView = [[WKWebView alloc] initWithFrame:[[self view] bounds]];
        NSURL *url = self.productURL;
        NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
        NSLog(@"Product URL%@", _productURL);
        [_webView loadRequest:urlReq];
        [self.view addSubview:_webView];
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
