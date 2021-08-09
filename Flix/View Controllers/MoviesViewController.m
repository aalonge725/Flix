//
//  MoviesViewController.m
//  Flix
//
//  Created by Abraham Alonge on 6/23/21.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"
#import "MovieAPIManager.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.activityIndicator startAnimating];
    
    [self fetchMovies];
        
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl setTintColor:[UIColor whiteColor]];
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchMovies {
    
    MovieAPIManager *manager = [MovieAPIManager new];
    [manager fetchPopular:^(NSArray *movies, NSError *error) {
        self.movies = (NSMutableArray *)movies;
        [self.tableView reloadData];
    }];
   [self.tableView reloadData];
   [self.activityIndicator stopAnimating];
   [self.refreshControl endRefreshing];
    
//    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { // TODO: look into what this means; lines inside block are called once the network call is finished
//           if (error != nil) {
////               NSLog(@"%@", [error localizedDescription]);
//
//               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies" message:@"The internet connection appears to be offline" preferredStyle:UIAlertControllerStyleAlert];
//
//               // create a retry action
//               UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                   [self fetchMovies];
//               }];
//               // add the retry action to the alert controller
//               [alert addAction:retryAction];
//
//               [self presentViewController:alert animated:YES completion:^{
//                   // TODO: optional code for what happens after the alert controller has finished presenting
//               }];
//           }
//           else {
//               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
////               NSLog(@"%@", dataDictionary);
//               NSArray *dictionaries = dataDictionary[@"results"];
//               self.movies = (NSMutableArray *)[Movie moviesWithDictionaries:dictionaries];
//
//               /*for (NSDictionary *movie in self.movies) {
//                   NSLog(@"%@", movie[@"title"]);
//               }*/
//
//               [self.tableView reloadData];
//               [self.activityIndicator stopAnimating];
//               [self.refreshControl endRefreshing];
//           }
//       }];
//    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    cell.movie = movie;

    [cell refreshData];
    
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];

    
//    __weak MovieCell *weakSelf = cell;
//    cell.posterView.image = nil; // clear out previous image before downloading new one
//    [cell.posterView setImageWithURLRequest:request placeholderImage:nil
//                                    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
//
//                                        // imageResponse will be nil if the image is cached
//                                        if (imageResponse) {
////                                            NSLog(@"Image was NOT cached, fade in image");
//                                            weakSelf.posterView.alpha = 0.0;
//                                            weakSelf.posterView.image = image;
//
//                                            //Animate UIImageView back to alpha 1 over 0.3sec
//                                            [UIView animateWithDuration:0.3 animations:^{
//                                                weakSelf.posterView.alpha = 1.0;
//                                            }];
//                                        }
//                                        else {
////                                            NSLog(@"Image was cached so just update the image");
//                                            weakSelf.posterView.image = image;
//                                        }
//                                    }
//                                    failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
//                                        // do something for the failure condition
//                                    }];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Movie *movie = self.movies[indexPath.row];
    
    DetailsViewController *detailViewController = [segue destinationViewController];
    detailViewController.movie = movie;
    
    [self.tableView reloadData];
}

@end
