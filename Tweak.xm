#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/NSString+UIKitAdditions.h>
#import <UIKit/UIWebView.h>
#import <dlfcn.h>
#import "Tweak.h"
#import <Cephei/HBPreferences.h>

HBPreferences *preferences;


%group gSearchNewWay

 %hook YTSearchResultsViewController
 - (void)viewDidLoad {   
     
 UIWebView *webView = [[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] self];
   NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"searcherror" withExtension:@"html"]; 
   
[self.view addSubview:webView];
[webView loadRequest:[NSURLRequest requestWithURL:htmlURL]];
 }
%end

 %hook YTGuideResponseViewController
    - (void)viewDidLoad {   
        UIWebView *webView = [[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] self];
        webView.opaque = NO;
        webView.backgroundColor = [UIColor clearColor];
        webView.scalesPageToFit = NO;
        NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"menu" withExtension:@"html"]; 

        [self.view addSubview:webView];
        [webView loadRequest:[NSURLRequest requestWithURL:htmlURL]];
    }

%end
%end

%ctor {
    preferences = [[HBPreferences alloc] initWithIdentifier:@"me.aleksilassila.youtuberebornpreferences"];
    
    [preferences registerDefaults:@{
        @"wantsSearch": @NO,

    }];

    if ([preferences boolForKey:@"wantsSearch"]) %init(gSearchNewWay);
 
    %init(_ungrouped);
}