//
//  TrailerViewController.m
//  Flix
//
//  Created by Stephanie Lampotang on 6/28/18.
//  Copyright © 2018 Stephanie Lampotang. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (nonatomic, strong) NSArray *trailers;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchTrailers];
}


- (void)fetchTrailers {
    NSString *one = @"https://api.themoviedb.org/3/movie/";
    NSString *two = [NSString stringWithFormat:@"%@", self.movie[@"id"]];
    NSString *three = [one stringByAppendingString:two];
    
    NSString *final = [three stringByAppendingString:@"/videos?api_key=60e1d3f9485ce67b2f7c2f12b424a95d&language=en-US"];
    NSURL *url = [NSURL URLWithString:final];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dataDictionary);
            // TODO: Get the array of movies // wants to store results in an array of movies
            self.trailers = dataDictionary[@"results"];
//            for (NSDictionary *id in self.trailers) {
//                NSLog(@"%@", id);
//                NSLog(@"here");
//            }
            
            // Do any additional setup after loading the view.
            NSString *urlString = @"https://www.youtube.com/watch?v=";
            NSString *urlString2 = [urlString stringByAppendingString:self.trailers[0][@"key"]];
            // Convert the url String to a NSURL object.
            NSURL *url = [NSURL URLWithString:urlString2];
            
            // Place the URL in a URL Request.
            NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                 timeoutInterval:10.0];
            // Load Request into WebView.
            [self.webView loadRequest:request];
        }
    }];
    
    [task resume];
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
