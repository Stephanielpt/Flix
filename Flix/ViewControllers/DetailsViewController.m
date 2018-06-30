//
//  DetailsViewController.m
//  Flix
//
//  Created by Stephanie Lampotang on 6/27/18.
//  Copyright © 2018 Stephanie Lampotang. All rights reserved.
//

#import "DetailsViewController.h"
#import "TicketsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FavoriteViewController.h"
#import <WebKit/WebKit.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (nonatomic, strong) NSArray *trailers;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    self.posterView.clipsToBounds = YES;
    self.posterView.layer.borderWidth = 3.0;
    self.posterView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    [self.backgroundView setImageWithURL:backdropURL];
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.dateLabel.text = self.movie[@"release_date"];
    
    [self.titleLabel sizeToFit];
    self.synopsisLabel.numberOfLines = 0;
    [self.synopsisLabel sizeToFit];
    
    CGRect newFrame = self.webView.frame;
    newFrame.origin.y = self.synopsisLabel.frame.origin.y + self.synopsisLabel.frame.size.height + 15;
    self.webView.frame = newFrame;
    
//    newFrame.origin.y = CGOriginMake(self.synopsisLabel.frame.origin.y + self.synopsisLabel.frame.size.height);
    
    CGFloat maxHeight = self.synopsisLabel.frame.origin.y + self.synopsisLabel.frame.size.height + self.webView.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, maxHeight);
    
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
//            [self.activityIndicator stopAnimating];
        }
    }];
    
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue isKindOfClass:[FavoriteViewController class]]) {
//    }
    if([segue.identifier isEqualToString:(@"fave")])
    {
        FavoriteViewController *favoriteViewController = [segue destinationViewController];
        //favoriteViewController.myArray = self.movie;
        [favoriteViewController.myArray addObject:self.movie];
    }
    if([segue.identifier isEqualToString:(@"trailer")])
    {
        TrailerViewController *trailerViewController = [segue destinationViewController];
        trailerViewController.movie = self.movie;
    }
    if([segue.identifier isEqualToString:(@"ticket")])
    {
        TicketsViewController *ticketsViewController = [segue destinationViewController];
        ticketsViewController.movie = self.movie;
    }
    
    
    
    
    
    
}


@end
