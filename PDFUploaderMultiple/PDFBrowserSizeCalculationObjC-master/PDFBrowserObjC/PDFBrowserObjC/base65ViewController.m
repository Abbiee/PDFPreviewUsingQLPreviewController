//
//  base65ViewController.m
//  PDFBrowserObjC
//
//  Created by Abbie on 08/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "base65ViewController.h"
#import <WebKit/WebKit.h>

@interface base65ViewController ()
@property (strong, nonatomic) IBOutlet WKWebView *Base64WebView;

@end

@implementation base65ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(refreshPropertyList:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    // Do any additional setup after loading the view.
    _Base64WebView = [[WKWebView alloc] initWithFrame:[[self view] bounds]];
           NSString * base64EncodedString = _base64String;

           NSData *data = [[NSData alloc]initWithBase64EncodedString:base64EncodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];

              

           [_Base64WebView loadData:data MIMEType:@"application/pdf" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
           NSLog(@"Product URL%@", base64EncodedString);
          // [_webView loadRequest:urlReq];
           [self.view addSubview:_Base64WebView];
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
