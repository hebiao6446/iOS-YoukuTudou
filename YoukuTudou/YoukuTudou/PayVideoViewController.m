//
//  PayVideoViewController.m
//  YoukuTudou
//
//  Created by ips on 15/2/28.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "PayVideoViewController.h"

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation PayVideoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title=@"视频播放";
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0,0, 320,  416+(isIPhone5?88:0) )];
    webView.backgroundColor=[UIColor whiteColor];
    [webView loadRequest:request];
    //    [webView loadRequest:request];
    
    webView.scrollView.showsVerticalScrollIndicator=NO;
//    webView.delegate=self;
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    for (UIView *subView in [webView subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView *shadowView in [subView subviews]) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;
                }
            }
        }
    }
    [self.view addSubview:webView];
    [webView release];
    
    
     
    
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation {
    
    
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}
- (BOOL)shouldAutorotate {
    
    return NO;
}

@end
