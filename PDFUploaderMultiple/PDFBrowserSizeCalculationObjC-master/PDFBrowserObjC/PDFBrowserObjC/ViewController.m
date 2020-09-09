//
//  ViewController.m
//  PDFBrowserObjC
//
//  Created by Abbie on 01/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ViewMyPDFViewController.h"
#import "base65ViewController.h"
#import <QuickLook/QuickLook.h>

@interface ViewController ()<UIDocumentPickerDelegate,UIDocumentInteractionControllerDelegate, UINavigationControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic,strong)NSArray *urlArrays;
@property (nonatomic, strong)QLPreviewController *pdfPreviews;
@property (nonatomic, strong)NSMutableArray *multipleURLArrays;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    self.multipleURLArrays = [[NSMutableArray alloc]init];
    self.pdfPreviews = [[QLPreviewController alloc]init];
   // pdfPreviews.delegate = self;
    self.pdfPreviews.dataSource = self;
}

- (IBAction)buttonAction:(id)sender {
    
    NSArray *types = @[(NSString*)kUTTypePDF];
    //Create a object of document picker view and set the mode to Import
    UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
    //Set the delegate
    docPicker.delegate = self;
    docPicker.allowsMultipleSelection = true;
    //present the document picker
    [self presentViewController:docPicker animated:YES completion:nil];
}
#pragma mark Delegate-UIDocumentPickerViewController

/**
 *  This delegate method is called when user will either upload or download the file.
 *
 *  @param controller UIDocumentPickerViewController object
 *  @param url        url of the file
 */
-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    if (controller.documentPickerMode == UIDocumentPickerModeImport)
    {
        self.urlArrays = urls;
        [self.multipleURLArrays removeAllObjects];
        [_pdfPreviews reloadData];
        if (self.urlArrays.count > 1) {
        NSLog(@"URL arryas%@", self.urlArrays);
        for (int i=0; i< [self.urlArrays count]; i++){
            NSData *fileData = [NSData dataWithContentsOfURL:[urls objectAtIndex:i]];
            NSString *pdfBaseString = [fileData base64EncodedStringWithOptions:i];
            [self.multipleURLArrays addObject:pdfBaseString];
            NSLog(@"Multiple Arrays items%@", _multipleURLArrays);
        }
            NSLog(@"Count items %ld", [self.multipleURLArrays count]);
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.pdfPreviews];
        [self presentViewController:navigationController animated:YES completion:^{}];
        } else {
            base65ViewController *webview = [[base65ViewController alloc]init];
            NSData *fileData = [NSData dataWithContentsOfURL:[urls objectAtIndex:0]];
            NSString *pdfBaseString = [fileData base64EncodedStringWithOptions:0];
            webview.base64String = pdfBaseString;
            NSLog(@"Single Array item%@", pdfBaseString);
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webview];
            [self presentViewController:navigationController animated:YES completion:^{}];
        }
    }
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return _urlArrays.count;
    
}

- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index
{
    return _urlArrays[index];
}

/**
 *  Delegate called when user cancel the document picker
 *
 *  @param controller - document picker object
 */
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController {

    return self.navigationController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
