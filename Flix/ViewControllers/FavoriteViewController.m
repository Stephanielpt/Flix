//
//  FavoriteViewController.m
//  Flix
//
//  Created by Stephanie Lampotang on 6/28/18.
//  Copyright © 2018 Stephanie Lampotang. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteViewCell.h"

@interface FavoriteViewController () <UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic, strong) NSArray *faves;
@property (weak, nonatomic) IBOutlet UITableView *favoriteTableView;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.favoriteTableView.dataSource = self;
    self.favoriteTableView.delegate = self;
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FavoriteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteViewCell"];
    if(indexPath.row < self.myArray.count)
    {
        cell.faveCell.text = self.myArray[indexPath.row];
    }
    //    NSLog(@"%@", [NSString stringWithFormat: @"row: %d, section: %d", indexPath.row, indexPath.section]);
    
//    NSDictionary *movie = self.movies[indexPath.row];
//    cell.titleLabel.text = movie[@"title"];
//    cell.synopsisLabel.text = movie[@"overview"];
//    [cell.synopsisLabel sizeToFit];
    
//    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
//    NSString *posterURLString = movie[@"poster_path"];
//    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
//
//    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
//
//    //to avoid flickering w slow connection
//    cell.posterView.image = nil;
//    [cell.posterView setImageWithURL:posterURL];
//
//    cell.posterView.clipsToBounds = YES;
//    cell.posterView.layer.borderWidth = 3.0;
//    cell.posterView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    return cell;
}

//
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection { 
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context { 
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded { 
//    <#code#>
//}

@end
