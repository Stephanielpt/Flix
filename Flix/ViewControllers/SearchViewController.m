//
//  SearchViewController.m
//  
//
//  Created by Stephanie Lampotang on 6/28/18.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *movieSearchBar;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    self.movieSearchBar.delegate = self;
    
    [self fetchMovies];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)fetchMovies {
    NSString *baseSearchURL = @"https://api.themoviedb.org/3/search/movie?api_key=60e1d3f9485ce67b2f7c2f12b424a95d&language=en-US&query=";
    //NSString *queryURL = @"search bar value";
    NSString *queryURL = _movieSearchBar.text;
    NSLog(@"The query text is: ");
    NSLog(@"%@", _movieSearchBar.text);

    NSString *halfwayURL = [baseSearchURL stringByAppendingString:queryURL];
    NSString *fullURL = [halfwayURL stringByAppendingString:@"&page=1&include_adult=false"];
    
    NSURL *url = [NSURL URLWithString:fullURL];
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
            self.movies =  dataDictionary[@"results"];
            for (NSDictionary *movie in self.movies) {
                NSLog(@"%@", movie[@"title"]);
            }
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
            [self.activityIndicator stopAnimating];
            [self.searchTableView reloadData];
        }
        
    }];
    
    [task resume];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self fetchMovies];
    [self.searchTableView reloadData];
    //[self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}
//THIS IS KINDA HACKY!!!
//- (IBAction)onTap:(id)sender {
//    [self fetchMovies];
//    [self.searchTableView reloadData];
//    
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    //Configure the cell...
    cell.searchLabel.text = movie[@"title"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    if(posterURLString == (NSString*)[NSNull null])
    {
        cell.searchPosterView.image = nil;
    }
    else
    {
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        
        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        
        //to avoid flickering w slow connection
        cell.searchPosterView.image = nil;
        [cell.searchPosterView setImageWithURL:posterURL];
    }
 
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SearchCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.searchTableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
    
    [self.searchTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
